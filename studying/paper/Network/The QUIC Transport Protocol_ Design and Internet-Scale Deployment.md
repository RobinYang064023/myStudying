# The QUIC Transport Protocol: Design and Internet-Scale Deployment

## Note

---

### Introduction

---

- QUIC 設計的目的是增進 HTTPS traffic 的效能，本文展示 QUIC 的設計、也分享從 deploy QUIC 的過程中了解的互聯網生態。
- QUIC 能取代傳統 HTTPS 的大多數組成: 「部分 HTTP/2」、「TLS」、「TCP」(不用 TCP 而只需要 UDP)。
- 使用 UDP 的目的是使 QUIC packet 可以通過 middleboxes。
- QUIC 如何比原本的網路設計有效？
  - QUIC 使用加密握手
    - 與已知服務器的重複連接透過使用已知服務器之憑證減少大部分連線的握手消耗。
    - 刪除掉那些在網路連線中各個層級之「冗餘」的握手消耗。

### Motivation

---

- Why QUIC?
  - 我們逐漸把 Web 作為各種應用之 Platform。
  - HTTPS(加密、安全)逐漸普及，同時也意味著 latency 的增加。
  - 因上述兩者原因，需要突破 TLS/TCP 系統的能力限制。
  - Protocol Entrenchment
    - Middlebox 的阻擾
      - Firewall 因不安全或者不熟悉做出的阻擋。
      - NATs 改寫 transport header。
      - 因為 middlebox 可以 inspect and modify transport header，所以改變 TCP 是一個很難的挑戰，可以預期一個簡單的更改可以花費十年(收益/投入太差)。
  - Implementation Entrenchment
    - 因為安全問題，需要快速的對 client 部署改變，那 TCP 是 OS kernel implement 的，就算我們更新了 TCP，那也需要更新 OS，然而更新 OS 需要非常謹慎，導致不能快速更新。
  - Handshake Delay
    - TCP connections commonly incur at least one round-trip delay of connection setup time before any application data can be sent.
    - TLS adds two round trips to this delay.
    - Most connections on the Internet, and certainly most transactions on the web, are short transfers and are most impacted by unnecessary handshake round trips.
  - Head-of-line Blocking Delay
    - TCP 因為其需保證 reliability，其傳遞需等待先前丟失之 TCP 重傳。
    - Web 的傳輸經常會需要更改 Client 和 Server，這過程牽涉到 Server, Client, and Middlebox。
    - 故 QUIC 對 header 進行加密、並使用 UDP 建構 transport 可以避免依賴供應商、網路運營商。

### QUIC Design and Implementation

---

- 使用單一一個連線(connect)負責多重請求(request)/回應(respond)，手法是為每個請求(request)/回應(response)提供他自己的串流，所以沒有 response 會被其他 response 阻擋(block)
- 將 packet 加密、驗證以防止 middlebox 篡改、進而達到限制 protocol 骨化程度(看起來像是)
- 如何達成 loss recovery?
  - packet numbers 都是 unique 以利回復時不混淆性。
  - 使用 explicit signaling 作 ACK 以準確計算 RTTs。(explicit signaling 即註明 QoS 參數，如: Latency(延遲
Jitter(不穩定性)、Throughput(頻寬效能)、 Packet Loss(封包遺失)以及 Availability(高可用性)等)
  - 使用一個 Connection ID 取代 IP/port 5-tuple。
  - 提供 Flow Control 去限制龜速 receiver 之 data buffered 量、使用 per-stream flow control limits 確保不
單一 stream 消耗所有 receiver's buffer。
  - 提供 modular congestion control interface 以試驗各種 controller。
  - Client and Server 在沒有額外延遲下 negotiate the use of the protocol。
- Connection Establishment
  - Initial handshake
    - The client sends a *inchoate client hello*(CHLO) message to the server to elicit(引發) a reject(REJ) message.
    - The REJ message contains:
      - a server config that includes the server's long-term Diffie-Hellman public value(交換密碼的演算法)
      - a *certificate chain* authenticating the server
      - a *signature* of the server config using the private key from the leaf certificate of the chain
      - a source-address token: an authenticated-encryption block that contains the client's publicly visible IP address(as seen at the server) and a timestamp by the server
        - 作用是在未來的 hand shake 中將此傳回給 server 以證明其 IP address 之所有權。
    - Once the client has received a server config, it authenticates the config by verifying the *certificate chain* and *signature*.
    - It then sends a complete CHLO, containing the client’s ephemeral Diffie-Hellman public value.(密碼交換完成)
  - Final(and repeat) handshake
    - All key for a connection are established using Diffie-Hellman.(確保「密碼交換」是安全的)
    - The client is free to start sending application data to the server.(前述步驟已經做到你擁有密碼了)
    - The client 可以直接傳送 encrypted data with its initial keys 以達成具備 0-RTT latency 的傳輸。(無需 server 回應)
    - QUIC 的加密方法可提供兩層級的安全:
      - 只有 initial client data 是使用 initial keys 加密，後續均採用 forward-secure keys(會持續變化，保證安全性)。
      - The client caches the server config and source-address token, and on a repeat connection to the same origin, uses them to start the connection with a complete CHLO.
    - QUIC 連線失敗:
      - the source address token or the server config 可能會過期、或 the server 可能更換 certificates，前述均會導致 the client 傳送 complete CHLO 後握手失敗。
      - 此時，the server 會回應一個 REJ message，就好像他第一次收到 inchoate CHLO(initial connection 傳送的 CHLO)一樣，再次建立起連線。(握手細節參照[A. Langley and W. Chang. QUIC Crypto.](http://goo.gl/OuVSxa))
  - Version Negotiation
    - QUIC client 會在第一個 packet 指名 version，若 the server 並不是採用此 version，則他傳回一個 *Version Negotiation packet* 給 the client 紀錄 the server 所有可使用的 version，這會在連線建立前導致 a round trip of delay。
    - 反過來說，若 the client 選擇了 the server 可用的 version 則會節省掉 round-trip latency。
    - 為防 downgrade attacks，上述有關 version 的資訊均會被雙方在產生 final keys 時丟進 key-derivation functions。
- Stream Multiplexing
  - 首先先提到 TCP 的傳輸是採用 singlebytestream abstraction 來達成 multiplex data，其為順序傳播(sequential delivery)，會有 head-of-line blocking 的問題。
  - 為了避免 head-of-line blocking，QUIC 支援一個連線多串流(multiple streams)，確保了丟失的 UDP packet 只會影響到該 packet 傳送的 stream，其他 stream 可以持續組合併傳輸。
  - QUIC streams
    - a lightweight abstraction that provide a reliable bidirectional bytestream.
    - Streams 可為任意大小，至高可達到單一 stream 傳送 2 的 64 次方 bytes。
    - 但同時又足夠輕量: 每當發送 a series of messages 就可以為每一個 message 使用一個 stream。
    - 每個 Stream 具有 unique Stream ID 以用於識別、防止 clooisions。
    - 在尚未使用的 stream 上傳送第一個 bytes 即隱含創建。
    - 在關閉 stream 時，將 "FIN" bit set on。
    - 由上述兩點可知，stream 跑完只須關閉而非斷開連結，要用就在傳。
    - 不過雖然 stream 是 reliable abstractions，但是 QUIC 不會重傳取消的 stream。
  - QUIC packet
    - 由 a common header 和不定量的 frames 組成。(eg. | Flags (8) | Connection ID (64) | Version (32) | Diversification Nonce (256) | Packet Number (8~48) | Frame 1 | Frame 2 |)
    - 由上可看出，單個 QUIC packet 可以封裝多個 stream 的 frames。
  - QUIC endpoint 是會受到限速的，一個 endpoint 必須決定如何將可用頻寬切給 multiple streams。
    - 他們的實現是只依賴 HTTP/2 的 stream priorities 做 scheduling。
- Authentication and Encryption
  - 除了最前頭封包及重置用封包之外，QUIC 的封包是完全驗證(authenticated)且大部分加密(encrypted)的。
  - 由上述 example 來說，從 Flags 到 Packet Number 的部分是 authenticated but unencrypted、Frame 1 之後則是 encrypted。未加密的部分是必須的，是為了 routing and decrypting。
  - Flags 包含 Connection ID field and length of the Packey Number field 且必須是 visible。
  - Connection ID 是為了 routing 和 identification，load balancer 可以用 Connection ID 去引導 connection's traffic。
  - Version number 和 diversification nonce fields 只存在於前頭的封包中。
  - The server 會生成 the diversification nonce，並在存在 SHLO packet 中傳送給 client，讓 client 可以用他生成複雜的 key。
  - 兩個 endpoint 都使用 packet number 作為對方驗證、解密用的隨機數。而 packet number 是存放在加密資料外，才能支援無序封包的解密(類似 DTLS)。
  - 包含 version negotiation packet 之所有未加密的 handshake packet 均會納入最終 connection keys 的產生中。
  - 如果有人篡改 handshake packet(比如想導向到哪裡)，均會導致最終 connection key 不同而連接失敗也沒有 peer 可以成功解密任何資料。
  - 重置封包(Reset packet) 是由不具 state for the connection 的 server 傳送，需要傳送重置封包的時機點通常為路由更改或者 server reboot。此時 server 會沒有 connection key，這也是為什麼重置封包會是 unencrypted and unauthenticated。
- Loss Recovery
  - TCP 的可靠性是依靠傳送字組的順序，但會造成 the "retransmission ambiguity" problem，因為重送的與原始的封包會有相同的序列號，會導致 TCP ACK 無法判定誰才是重送的而且重送需要用 timeout 來決定是否要發出重送 ACK。
  - 每個 QUIC 封包(包含重送封包)均攜帶全新的 packet number，此機制消除了區分原始與重送的需要、不再會造成 the "retransmission ambiguity" problem。
  - 傳遞的排序則用 stream offset in stream frames 達成。
  - 另外，因為 packet number 具備時間順序性，可以比 TCP 更明確的做到分辨重送。
  - QUIC 明確地對 *接收封包*  和 *發送確認* 間的延遲做編碼，加上單調增加(持續增加沒有特別規則)的 packet number，可以更精確的估計 RTT，這也有助於偵測 loss。
  - 準確的 RTT estimation 也對 delay-sensing congestion controllers 有幫助。
  - QUIC 可支援多達 256 ACK blocks，這也使得QUIC比 TCP 更具彈性，也使 QUIC 在 reordering 或 loss 可以保留更多 bytes。
  - 上述差異使我們能建立比 TCP 更簡單、更有效的機制。


## 註解

---

- [A Ten Minute Introduction to Middleboxes](http://yuba.stanford.edu/~huangty/sigcomm15_preview/mbpreview.pdf)
  - What is a middlebox?
    - A middlebox is defined as any intermediary device performing functions other than the normal, standard   functions of an IP router on the datagram path between a source host and destination host.
    - 在 src 與 dest 間不單純作為路由器之機器即為 middlebox
    - 依其作用可分為安全、效能及其他
      - 安全: Firewalls, Application Firewalls, Intrusion Detection Systems(IDS), Intrusion Prevention Systems  (IPS)
      - 效能: Proxy/Caches, WAN Optimizers, Protocol Accelerators
      - 其他: Network Address Translation(NAT), Protocol Converters(IPv6 to IPv4/IPv4 to IPv6)
    - middleboxes and routers 的關鍵差異
      - Middleboxes 是 stateful，可以記憶那些不斷跟著連線及封包更新的 data。
      - Middleboxes 可以對 packets 做很多 operations。
  - What are some recent trends in middlebox engineering?
    - Network Functions Virtualization
      - Network functions virtualization (NFV) is an initiative to virtualize the network services that are now being carried out by proprietary, dedicated hardware.
