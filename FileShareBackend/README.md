# P2P LAN File Sharing Application

A cross-platform **Peer-to-Peer (P2P) LAN File Sharing Application** designed to transfer files directly between devices connected to the same local network, without relying on cloud storage or a centralized file server.

The project focuses on building the networking and application logic from the ground up using **C++**, with an architecture designed to support multiple clients such as a desktop CLI and an Android application.

---

## 🚀 Overview

This application enables devices on the same Wi-Fi/LAN network to:

* Discover other available devices automatically.
* Maintain the online status of discovered devices using heartbeats.
* Select a device for file sharing.
* Request files from another peer.
* Transfer files directly between peers.
* Handle multiple network operations concurrently.
* Stream large files without loading the entire file into memory.
* Use a structured application-level packet protocol.
* Serialize network messages using Protocol Buffers.

The application follows a **serverless P2P architecture** for file transfer.

There is no central server responsible for storing or transferring the files.

```text
             Local Network / Wi-Fi
                    │
        ┌───────────┴───────────┐
        │                       │
   ┌────▼─────┐           ┌─────▼────┐
   │ Device A │◄─────────►│ Device B │
   │  Sender  │   P2P     │ Receiver │
   └──────────┘           └───────────┘
        │                       │
        └───────────┬───────────┘
                    │
             Direct Transfer
```

---

## ✨ Features

### Device Discovery

Devices periodically broadcast discovery/heartbeat information over UDP.

Other devices listening on the network can automatically detect them.

```text
Device A
   │
   │ UDP Broadcast
   ▼
Local Network
   │
   ├──────────────► Device B
   ├──────────────► Device C
   └──────────────► Device D
```

---

### Heartbeat Monitoring

After discovering a device, the application continuously monitors its availability.

Each peer periodically sends a heartbeat containing information such as:

* Device ID
* Device name
* Device type
* TCP port
* Timestamp

If heartbeats stop arriving within the configured timeout period, the device can be considered offline and removed from the online-device list.

```text
Heartbeat
    │
    ▼
Update lastHeartbeatTimestamp
    │
    ▼
Device remains ONLINE
    │
    └── No heartbeat for timeout
              │
              ▼
       Device marked OFFLINE
```

---

### Direct P2P File Transfer

Once a device is selected, the receiver communicates directly with the sender.

```text
Receiver                     Sender
   │                            │
   │──── File Request ─────────►│
   │                            │
   │◄── File Metadata ──────────│
   │                            │
   │◄──── File Data ────────────│
   │                            │
   │◄──── File Data ────────────│
   │                            │
   │◄──── File Data ────────────│
   │                            │
   │──── Transfer Complete ────►│
```

The file itself is transferred directly between peers instead of passing through a central server.

---

## 🏗️ Architecture

The project is divided into multiple layers to keep networking, packet handling, business logic, and application-specific services separated.

```text
┌─────────────────────────────────────────────┐
│                 Application                 │
├─────────────────────────────────────────────┤
│                  Services                   │
│                                             │
│  DiscoveryService                           │
│  FileService                                │
│  FileShareService                           │
│  FileReceiverService                        │
│  ThreadPoolService                          │
├─────────────────────────────────────────────┤
│                Packet Services              │
│                                             │
│  DiscoveryPacketService                     │
│  HeartbeatPacketService                     │
│  FileRequestPacketService                   │
│  ...                                        │
├─────────────────────────────────────────────┤
│                   Packets                   │
│                                             │
│  Discovery                                  │
│  Heartbeat                                  │
│  FileRequest                                │
│  ...                                        │
├─────────────────────────────────────────────┤
│              Packet Converters              │
│                                             │
│  Packet <──────► Protocol Buffer            │
├─────────────────────────────────────────────┤
│              Protocol Buffers               │
├─────────────────────────────────────────────┤
│               Network Layer                 │
│                                             │
│       UDP              TCP                  │
└─────────────────────────────────────────────┘
```

---

## 📂 Project Structure

The project is organized around responsibilities rather than putting all networking logic into a single module.

```text
src/
│
├── Models/
│
├── Packets/
│   ├── Discovery.h
│   ├── HeartBeat.h
│   ├── FileRequest.h
│   └── ...
│
├── Proto/
│   ├── Discovery.proto
│   ├── HeartBeat.proto
│   ├── FileRequest.proto
│   └── ...
│
├── Converters/
│   ├── DiscoveryConverter.h
│   ├── DiscoveryConverter.cpp
│   ├── HeartBeatConverter.h
│   ├── HeartBeatConverter.cpp
│   └── ...
│
├── PacketServices/
│   ├── DiscoveryPacketService.h
│   ├── HeartBeatPacketService.h
│   ├── FileRequestPacketService.h
│   └── ...
│
├── Services/
│   ├── DiscoveryService.h
│   ├── ThreadPoolService.h
│   ├── FileService.h
│   ├── FileShareService.h
│   └── FileReceiverService.h
│
├── Network/
│   ├── UDPBroadcaster.h
│   ├── UDPListener.h
│   ├── TCPServer.h
│   ├── TCPClient.h
│   └── ...
│
└── main.cpp
```

The exact structure may evolve as the project develops.

---

## 📡 Network Communication

The application uses different protocols for different responsibilities.

| Protocol         | Purpose                        |
| ---------------- | ------------------------------ |
| UDP              | Device discovery and heartbeat |
| TCP              | Reliable file transfer         |
| Protocol Buffers | Packet serialization           |
| Wi-Fi/LAN        | Peer connectivity              |

### Why UDP for Discovery?

Device discovery does not require a persistent connection.

A device can periodically broadcast:

```text
"I am available."
```

Other devices can listen for these broadcasts and maintain their list of online peers.

UDP is suitable because:

* Low overhead
* Connectionless
* Fast
* Supports broadcast
* Discovery packets can simply be retransmitted periodically

---

### Why TCP for File Transfer?

File transfer requires reliable delivery.

TCP provides:

* Reliable delivery
* Ordered data
* Retransmission
* Flow control
* Congestion control

Therefore the project uses UDP for **discovery** and TCP for **actual file transfer**.

---

# 📦 Application Protocol

The application defines its own packet structures.

Example packet types include:

```text
HEARTBEAT
DISCOVERY
FILE_REQUEST
FILE_RESPONSE
FILE_METADATA
FILE_DATA
TRANSFER_COMPLETE
```

A packet is represented internally as a C++ structure.

Protocol Buffers are used for serialization across the network.

```text
C++ Packet
    │
    ▼
Packet Service
    │
    ▼
Packet Converter
    │
    ▼
Protocol Buffer
    │
    ▼
Network
    │
    ▼
Protocol Buffer
    │
    ▼
Packet Converter
    │
    ▼
C++ Packet
```

This keeps packet creation and serialization logic separate from the networking layer.

---

# 🔎 Device Discovery Flow

```text
                  Device A
                     │
                     │ UDP Broadcast
                     ▼
              ┌──────────────┐
              │ Local Network│
              └──────┬───────┘
                     │
             ┌───────┼───────┐
             ▼       ▼       ▼
          Device B Device C Device D
             │
             ▼
       UDP Listener
             │
             ▼
    Deserialize Packet
             │
             ▼
      Discovery Service
             │
             ▼
      Online Device List
```

Each discovered device contains information such as:

```text
Device ID
Device Name
Device Type
IP Address
TCP Port
Last Heartbeat
```

---

# ❤️ Heartbeat Flow

The heartbeat mechanism prevents stale devices from remaining in the online-device list.

```text
Sender
  │
  │ Heartbeat
  ▼
Receiver
  │
  ├── Update device timestamp
  │
  └── Keep device online
```

If the receiver does not receive a heartbeat within the configured timeout:

```text
Last Heartbeat
      │
      ▼
Timeout
      │
      ▼
Device considered offline
      │
      ▼
Remove from online devices
```

---

# 📁 File Transfer Flow

The high-level file-sharing workflow is:

```text
1. Device Discovery
        │
        ▼
2. Heartbeat Monitoring
        │
        ▼
3. User selects a peer
        │
        ▼
4. Receiver sends File Request
        │
        ▼
5. Sender validates request
        │
        ▼
6. Sender prepares file
        │
        ▼
7. File metadata is exchanged
        │
        ▼
8. File is streamed over TCP
        │
        ▼
9. Receiver writes data to disk
        │
        ▼
10. Transfer completion
```

---

# 🧵 Concurrency

Network operations should not block the main application thread.

The project therefore includes a thread-pool based architecture for handling tasks concurrently.

Example:

```text
TCP Connection
      │
      ▼
Create Client Task
      │
      ▼
Thread Pool
      │
 ┌────┼────┐
 ▼    ▼    ▼
T1    T2    T3
 │    │    │
 ▼    ▼    ▼
File  File  Network
Task  Task  Task
```

This allows multiple network operations to be processed concurrently without continuously creating new threads.

---

# 💾 Large File Handling

Files are not intended to be loaded completely into memory.

Instead, the transfer is performed using chunks:

```text
File
 │
 ├── Chunk 1 ─────► Receiver
 ├── Chunk 2 ─────► Receiver
 ├── Chunk 3 ─────► Receiver
 ├── Chunk 4 ─────► Receiver
 │
 └── ...
```

This makes the system suitable for transferring large files while keeping memory usage under control.

---

# 🔐 Security

Security is an important part of the planned architecture.

Future/ongoing security considerations include:

* Peer authentication
* Secure device identification
* Encrypted communication
* File-transfer authorization
* Protection against unauthorized peers
* Integrity verification of transferred files

The current implementation primarily focuses on the networking architecture and P2P communication model.

---

# 🛠️ Technology Stack

### Core

* **C++**
* **Socket Programming**
* **UDP**
* **TCP**
* **Multithreading**
* **Thread Pool**

### Serialization

* **Protocol Buffers**

### Planned Clients

* Desktop CLI
* Android Application

### Android Integration

The core networking engine is designed to be reusable from Android through:

```text
Android Application
       │
       ▼
      JNI
       │
       ▼
C++ Core Engine
       │
       ▼
Networking / File Transfer
```

This allows the networking and file-transfer logic to remain independent from the UI layer.

---

# 🎯 Project Goals

The main goals of this project are:

* Build a real-world P2P networking application.
* Understand socket programming deeply.
* Design an application-level network protocol.
* Learn UDP broadcasting and discovery.
* Implement reliable TCP file transfer.
* Build a scalable concurrent architecture.
* Practice C++ resource and memory management.
* Design reusable services and abstractions.
* Integrate a native C++ core with different frontends.
* Eventually support desktop and Android clients.

---

# 🗺️ Roadmap

## Phase 1 — Networking Fundamentals

* [x] TCP socket basics
* [x] UDP socket basics
* [x] Client/server communication
* [x] UDP broadcasting
* [ ] Robust socket abstraction
* [ ] Connection management

## Phase 2 — Device Discovery

* [x] UDP broadcaster
* [x] UDP listener
* [x] Discovery packet
* [ ] Online device registry
* [ ] Heartbeat mechanism
* [ ] Device timeout/removal
* [ ] Discovery service

## Phase 3 — Protocol Layer

* [x] Packet structures
* [x] Protocol Buffer definitions
* [x] Packet converters
* [ ] Packet services
* [ ] Packet validation
* [ ] Protocol versioning

## Phase 4 — File Transfer

* [ ] File request
* [ ] File metadata exchange
* [ ] TCP file transfer
* [ ] Chunked streaming
* [ ] Transfer progress
* [ ] Transfer cancellation
* [ ] Transfer integrity verification

## Phase 5 — Concurrency

* [x] Thread pool foundation
* [ ] Network task management
* [ ] Concurrent transfers
* [ ] Graceful thread-pool shutdown
* [ ] Resource cleanup

## Phase 6 — Security

* [ ] Peer authentication
* [ ] Secure communication
* [ ] Transfer authorization
* [ ] File integrity validation

## Phase 7 — Clients

* [ ] Desktop CLI
* [ ] Android client
* [ ] JNI bridge
* [ ] Cross-platform testing

---

# 🧪 Development Philosophy

The project intentionally avoids putting all functionality into a single large networking class.

Instead, responsibilities are separated:

```text
Network Layer
     │
     ▼
Packet Layer
     │
     ▼
Packet Services
     │
     ▼
Application Services
```

For example:

**Network layer**

> "Receive these bytes."

**Packet converter**

> "Convert these bytes into a packet."

**Packet service**

> "Create and interpret this particular packet."

**Application service**

> "What should the application do when this packet arrives?"

This separation makes the system easier to test, maintain, and extend.

---

# 📚 What This Project Demonstrates

This project is intended to demonstrate practical understanding of:

* C++ system programming
* Object-oriented design
* RAII and resource management
* Socket programming
* TCP/IP networking
* UDP broadcasting
* Peer-to-peer architecture
* Network protocol design
* Protocol Buffers
* Multithreading
* Thread pools
* Producer/consumer patterns
* File streaming
* Cross-platform native development
* JNI integration
* Software architecture and separation of concerns

---

# 🤝 Future Improvements

Possible future improvements include:

* Multiple simultaneous file transfers
* Folder sharing
* Transfer resume
* File compression
* Bandwidth management
* Peer authentication
* End-to-end encryption
* NAT traversal
* QR-based device pairing
* Transfer history
* Android background transfers
* Desktop GUI
* Network performance monitoring

---

# 📄 License

This project is currently developed as a personal learning and portfolio project.

License information will be added as the project matures.

---

## ⭐ Project Status

**🚧 Active Development**

The project is being developed incrementally, starting from low-level socket programming and gradually building toward a complete cross-platform P2P file-sharing system.

The architecture and APIs may change as new networking and application requirements are introduced.
