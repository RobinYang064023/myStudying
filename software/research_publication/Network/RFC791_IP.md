# RFC 791 Internet Protocol

## Introduction

---

- IP 也被稱為 host-to-host protocols，其最終目的是能夠在互聯網(可能必須以小分段傳遞)中傳遞可以重新集成為 packet 的協議。
- 分為兩種基本的 function:
  - addressing
    - routing
      - The internet modules use the addresses carried in the internet header to transmit internet datagrams toward their destinations. The selection of a path for transmission is called routing.
      - 總之是在解釋 routing 的意思是「一個選擇互聯網中傳遞路線的過程」。
  - fragmentation
    - The internet modules use fields in the internet header to fragment and reassemble internet datagrams when necessary for transmission through "small packet" networks.
- IP 將所有 internet datagram 視為一個獨立的 entity(不與其他 internet datagram 有相關)。
- IP 使用四個機制(mechanisms)來達成:
  - Type of Service
    - 是用作指明所需之 service 的品質。
    - 是一組抽象的、泛化的參數集合。
    - 被 gateways 用來選擇「用在特定網路中」、「下一個網路中」或者「下一個 gateway 做 routing 使用」之具體、真實的參數。
  - Time to Live
    - 是用作指明 internet datagram 能存活的時間上限。
    - 藉由「發送者」決定、並在過程中逐漸減少。
    - 達到零值(Zero)就自我毀滅。
  - Options
    - 提供一些在特定處境下的控制功能、或者有用的功能且對於一般通訊是非必要的。
    - 包含「特定時間戳記規範」、「安全」、「特定 routing」。
  - Header Checksum
    - 提供可以確認 internet datagram 傳遞正確的驗證。
    - 只要 header checksum fails，則會直接視為偵測到錯誤並丟掉封包。
- IP 並沒有提供可靠的通信
  - 它沒有 end-to-end的確認、也沒有 hop-by-hop 的確認。
  - 它沒有對錯誤的控制、只有 header checksum(偵測錯誤)。
  - 它沒有重傳。
  - 它沒有流程控制。
- 錯誤偵測我們通常用 Internet Control Message Protocol(ICMP)，它實際上就是 IP 的一種實踐。

## Overview

---

### Relation to Other Protocols

- 展示 IP 在哪個層次而已，不多談。

### Model of Operation

- 我們假定傳輸過程會有一個 gateway。
- 發送者會把 data、destination address 和相關參數藉由 local internet module 包起來。
- internet modul 準備 datagram header 被附加在 datagram 上、決定一個 local network address，在這個例子是 gateway 的 address。
- 把 datagram、the local network address 發送給 local network interface。
- The local network interface 創建一個 local network header 並附加到 datagram 上並透過 local network 傳送。
- destination host 透過 local network interface 處理給 internet module ，在透過 internet module 處理後接收。

```
Application Program(sender)                Application Program(receiver)
            \                                         /
    Internet Module       Internet Module        Internet Module
              \            /           \            /
             LNI-1      LNI-1         LNI-2      LNI-2
               \        /               \         /
             Local Network 1           Local Network 2
```
### Function Description

- Addressing
  - distinction
    - names
      - 我們要找誰
    - addresses
      - 它在哪
    - routes
      - 怎麼去那
- Fragmentation
  - 通常我們傳遞一個 datagram 會需要將其切割為更小的 size 來傳遞，但也可以標記 "don't fragment." 避免被切割，同時一旦不切割則會大到不能傳遞的話，此 datagram 會被拒絕傳遞。
  - How to do the fragmentation and reassemble? We use fields below.
    - Intranet fragmentaion
      - fragmentation, transmission and reassembly across a local network which is invisible to the IP module.
    - identification field
      - Used to ensure that fragments of different datagrams are not mixed.
    - fragment offset field
      - Used to tell the receiver the position of a fragment in the original datagram.
    - more-fragments flag
      - Used to indicates the last fragment.
  - More detail about these fields
    - identification
      - 對於每個相同 source-destination pair (來源-目的)、同一時間之協議(protocol for the time)內存活的 datagram 均配給一個 unique 的數值。
    - more-fragments flag and fragment offset
      - 在一個完整的 datagram 之 originating protocol module 會將兩者設為 0。

## Specification

## Appendix A

## Appendix B

## Glossary