//
// Created by VijayNSadashiva on 18-08-2026.
//

#include "DiscoveryService.h"

#include <unordered_map>
#include <string>
#include <mutex>
#include <thread>
#include <stdexcept>

#include "Models/OnlineDevice.h"
#include "PacketService/Converters/FileRequestConverter.h"
#include "PacketService/Packets/FileRequest.h"
#include "PacketService/Proto/FileRequest.pb.h"
#include "Services/TCPService.h"
#include "Services/UDPBroadcaster.h"
#include "Services/UDPListener.h"
#include "Types/SocketValue.h"


void DiscoveryService::removeInactivDevices() {
    while (!stopRemoveInactiveTask) {
        auto lock = std::unique_lock<std::mutex>(onlineDeviceMutex);
        for (auto& device: onlineDevices) {
            auto onlineDevice = device.second;
            if (onlineDevice.checkIsTimeDiffIsGreater(10)) {
                onlineDevices.erase(device.first);
            }
        }
        lock.unlock();
        std::this_thread::sleep_for(std::chrono::seconds(5));
    }
}

void DiscoveryService::stopRemoveInactivyDeviceTask() {
    stopRemoveInactiveTask = true;
}

void DiscoveryService::DiscoveryRequestListner() {

    TCPServerSocketConfig socketConfig = TCPServerSocketConfig(DiscoveryTCPPort);
    SocketValue tcpSocketValue = TCPService::createServerSocket(socketConfig);
    sockaddr_in address = tcpSocketValue.address;
    SocketType requestListenSocket = tcpSocketValue.socket;

    while (!stopDiscoveryListenServer) {

        sockaddr_in address{};
        std::vector<char> buffer(65507);


        #ifdef _WIN32
                int addr_len = sizeof(address);
        #else
                socklen_t addr_len = sizeof(address);
        #endif


        SocketType clientSocket = CROSS_ACCEPT(requestListenSocket,(struct sockaddr*)&address,&addr_len);
        if (clientSocket == INVALID_SOCKET) {
            std::cerr << "accept() failed: "
                      << CROSS_GET_ERROR() << std::endl;
            continue;
        }

        int receiveRequest = recv(clientSocket,buffer.data(),buffer.size(),0);
        if (receiveRequest == SOCKET_ERROR) {
            throw std::runtime_error("Not able to receive A Request!!");
        }

        FileRequestProto::FileRequest fileRequestProto;

        if (fileRequestProto.ParseFromArray(buffer.data(), receiveRequest)) {
            std::cout << "File Request: " << fileRequestProto.DebugString() << '\n';
        } else {
            std::cerr << "Failed to parse FileRequest protobuf\n";
        }

        FileRequest file_request = FileRequestConverter::toPacket(fileRequestProto);
        if (file_request.isInvalid()) {
            throw std::runtime_error("Not able to Convert File Request Proto to File Request Packet");
        }

    }



}

void DiscoveryService::stopDiscoveryRequestLister() {
    stopDiscoveryListenServer = true;
}
