# The QUIC Transport Protocol: Design and Internet-Scale Deployment

## Note

---

- QUIC 設計的目的是增進 HTTPS traffic 的效能，本文展示 QUIC 的設計、也分享從 deploy QUIC 的過程中了解的互聯網生態。
- QUIC 能取代傳統 HTTPS 的大多數組成: 「部分 HTTP/2」、「TLS」、「TCP」(不用 TCP 而只需要 UDP)。
- 使用 UDP 的目的是使 QUIC packet 可以通過 middleboxes。
- QUIC 如何比原本的網路設計有效？
  - QUIC 使用加密握手
    - 與已知服務器的重複連接透過使用已知服務器之憑證減少大部分連線的握手消耗。
    - 刪除掉那些在網路連線中各個層級之「冗餘」的握手消耗。
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
- QUIC Design and Implementation
  - 使用單一一個連線(connect)負責多重請求(request)/回應(respond)，手法是為每個請求(request)/回應(response)提供他們自己的串流，所以沒有 response 會被其他 response 阻擋(block)
  - 將 packet 加密、驗證以防止 middlebox 篡改、進而達到限制 protocol 骨化程度(看起來像是)
  - 如何達成 loss recovery?
    - packet numbers 都是 unique 以利回復時不混淆性。
    - 使用 explicit signaling 作 ACK 以準確計算 RTTs。(explicit signaling 即註明 QoS 參數，如: Latency(延遲)、Jitter(不穩定性)、Throughput(頻寬效能)、 Packet Loss(封包遺失)以及 Availability(高可用性)等)
    - 使用一個 Connection ID 取代 IP/port 5-tuple。
    - 提供 Flow Control 去限制龜速 receiver 之 data buffered 量、使用 per-stream flow control limits 確保不會有單一 stream 消耗所有 receiver's buffer。
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
