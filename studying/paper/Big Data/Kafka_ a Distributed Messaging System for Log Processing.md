# Kafka: a Distributed Messaging System for Log Processing

## Abstract

---

Kafka is a distributed messaging system that we developed for collecting and delivering high volumes of log data with low latency.

## Introduction

---

- There is a large amount of "log" data generated at any sizable internet company.
  - user activity events corresponding to logins, pageviews, clicks, "likes", sharing. comments and search queries.
  - operational metrics such as service call stack, call latency, errors, and system metrics such as CPU, memory, network, or disk utilization on each machine.
- Recent trends in internet applications have made activity data a part of the production data pipeline used directly in site feature.
  - search relevance
  - recommendations which may driven by item popluarity or cooccurrence in the activity stream
  - ad targeting and reporting
  - security applications that protect against abusive behaviors such as spam or unauthorized data scraping
  - newsfed feature that aggregate user status updates or actions for their "friends" or "connections" to read

## Related Work

---

- About traditional enterpries messaging systems: there are a few reasons why they tend not to be a good fit for log processing.
  - Mismatch in features: Those systems often focus on offering a rich set of delivery guarantees.
    - IBM Websphere MQ [7] has transactional supports that allow an application to insert messages into multiple queues atomically.
    - The JMS [14] specification allows each individual message to be acknowledged after consumption, potentially out of order. Such delivery guarantees are often overkill for collecting log data.
    - Consequence: such delivery guarantees are often overkill for collecting log data. For instance, losing a few pageview events occasionally is certainly not the end of the world. Those unneeded features tend to increase the complexity of both the API and the underlying implementation of those systems.
  - Many systems do not focus as strongly on throughput as their primary design constraint.
    - For example, JMS has no API to allow the producer to explicitly batch multiple messages into a single request. This means each message requires a full TCP/IP roundtrip, which is not feasible for the throughput requirements of our domain.
  - Those systems are weak in distributed support.
    - There is no easy way to partition and store messages on multiple machines.
  - Many messaging systems assume near immediate consumption of messages, so the queue of unconsumed messages is always fairly small. Their performance degrades significantly if messages are allowed to accumulate, as is the case for offline consumers such as data warehousing applications that do periodic large loads rather than continuous consumption.