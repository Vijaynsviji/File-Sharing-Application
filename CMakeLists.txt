cmake_minimum_required(VERSION 3.15)
project(FileShareBackend)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 1. Find Protobuf using CONFIG mode (this targets vcpkg directly)
find_package(protobuf CONFIG REQUIRED)

file(GLOB PROTO_FILES "${CMAKE_CURRENT_SOURCE_DIR}/PacketService/Proto/*.proto")

# 2. Define your executable target with just your core C++ files
add_executable(FileShareBackend main.cpp
        ThreadPoolService/Models/Task.h
        ThreadPoolService/ThreadPool.h
        ThreadPoolService/ThreadPool.cpp
        PacketService/Packets/Discovery.h
        PacketService/Packets/HeartBeat.h
        PacketService/Packets/FileMetadata.h
        PacketService/Packets/FileRequest.h
        PacketService/Packets/Device.h
        PacketService/Packets/FileResponse.h
        PacketService/Packets/FileChunk.h
        PacketService/Packets/TransferComplete.h
        PacketService/Packets/Error.h
        PacketService/Converters/DiscoveryConverter.h
        PacketService/Converters/DeviceConverter.h
        PacketService/Converters/DeviceConverter.cpp
        PacketService/Converters/DiscoveryConverter.cpp
        PacketService/Converters/HeatBeatConverter.h
        PacketService/Converters/HeartBeatConverter.cpp
        PacketService/Converters/FileMetadataConverter.h
        PacketService/Converters/FileMetadataConverter.cpp
        PacketService/Converters/FileRequestConverter.h
        PacketService/Packets/PacketEnums.h
        PacketService/Converters/FileRequestConverter.cpp
        PacketService/Converters/FileResponseConverter.h
        PacketService/Converters/FileResponseConverter.cpp
        PacketService/Converters/FileChunkConverter.h
        PacketService/Converters/FileChunkConverter.cpp
        PacketService/Converters/TransferCompleteConverter.h
        PacketService/Converters/TransferCompleteConverter.cpp
        PacketService/Converters/ErrorConverter.h
        PacketService/Converters/ErrorConverter.cpp
        DiscoveryService/Models/OnlineDevice.h
        DiscoveryService/Services/UDPListener.h
        DiscoveryService/Services/UDPListener.cpp
        DiscoveryService/Services/UDPBroadcaster.h
        DiscoveryService/Services/UDPBroadcaster.cpp
        PacketService/Factory/DiscoveryPacketFactory.h
        PacketService/Factory/DiscoveryPacketFactory.cpp
        PacketService/Factory/HeartBeatPacketFactory.h
        PacketService/Factory/HeartBeatPacketFactory.cpp
        PacketService/Factory/FIleMetadataPacketFactory.h
        PacketService/Factory/FileMetadataPacketFactory.cpp
        PacketService/Factory/FileRequestPacketFactory.h
        PacketService/Factory/FileRequestPacketFactory.cpp
        PacketService/Factory/FileResponsePacketFactory.h
        PacketService/Factory/FileResponsePacketFactory.cpp
        PacketService/Factory/FileChunkPacketFactory.h
        PacketService/Factory/FileChunkPacketFactory.cpp
        PacketService/Factory/TransferCompletePacketFactory.h
        PacketService/Factory/TransferCompletePacketFactory.cpp
        PacketService/Factory/ErrorPacketFactory.h
        PacketService/Factory/ErrorPacketFactory.cpp
        DiscoveryService/DiscoveryService.h
        DiscoveryService/Services/UDPService.h
        DiscoveryService/Services/UDPService.cpp
        DiscoveryService/Services/TCPService.h
        DiscoveryService/Types/UDPSocketConfig.h
        DiscoveryService/Types/SocketValue.h
        DiscoveryService/Types/TCPSocketConfig.h
        DiscoveryService/Services/TCPService.cpp
        DiscoveryService/DiscoveryService.cpp
        FileService/Models/File.h
        FileService/FileService.h
        FileService/FileService.h
        FileService/FileService.cpp)

# 3. Modern generation: Automatically compile the proto and attach it to the target
# This replaces the old macro and handles all generated file paths for you
protobuf_generate(
        TARGET FileShareBackend
        LANGUAGE cpp
        PROTOS ${PROTO_FILES}
        IMPORT_DIRS "${CMAKE_CURRENT_SOURCE_DIR}"
)

# 4. Include directories
target_include_directories(FileShareBackend PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_BINARY_DIR}
)

# 5. Link using the modern target (Crucial for x64-mingw-dynamic!)
# This automatically applies the correct DLL import definitions to your build
target_link_libraries(FileShareBackend PRIVATE
        protobuf::libprotobuf
)

# Win32 specific linking for Winsock2 (Required for UDP/TCP sockets)
if(WIN32)
    target_link_libraries(FileShareBackend PRIVATE ws2_32)
endif()