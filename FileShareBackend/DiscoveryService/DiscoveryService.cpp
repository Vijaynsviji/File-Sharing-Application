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
    // SocketType requestListenSocket = socket(AF_INET,SOCK_STREAM,0);
    // if (requestListenSocket == INVALID_SOCKET) {
    //     throw std::runtime_error("Not able to Create a TCP Socket!!");
    // }
    //
    // sockaddr_in address{
    //     AF_INET,
    //     htons(DiscoveryTCPPort)
    // };
    //
    // int bindSocket = bind(requestListenSocket,(const struct sockaddr*)&address,sizeof(address));
    // if (bindSocket == SOCKET_ERROR) {
    //     throw std::runtime_error("Not able to Bind to a Port");
    // }
    //
    // int assignIp = inet_pton(AF_INET,"127.0.0.1",&address);
    // if (assignIp == SOCKET_ERROR) {
    //     throw std::runtime_error("Not able to assign a IP");
    // }
    //
    // int listenToRequest = listen(requestListenSocket,10);
    // if (listenToRequest == SOCKET_ERROR) {
    //     throw std::runtime_error("Not able to Listen for Requests");
    // }
    TCPServerSocketConfig socketConfig = TCPServerSocketConfig(DiscoveryTCPPort);
    SocketValue tcpSocketValue = TCPService::createServerSocket(socketConfig);
    sockaddr_in address = tcpSocketValue.address;
    SocketType requestListenSocket = tcpSocketValue.socket;

    // accept(requestListenSocket)


    while (!stopDiscoveryListenServer) {
        sockaddr_in clientSocket;
        std::vector<char> buffer(1024);
        int receiveRequest = recv(requestListenSocket,buffer.data(),buffer.size(),0);
        if (receiveRequest == SOCKET_ERROR) {
            throw std::runtime_error("Not able to receive A Request!!");
        }

        //TODO 1: When Request Comes, if the User Click Allow this User To Receive Added them To Online Devices
        std::cout<<"Do You Want to Accept This User as a Receiver?\nYes Or No";
        std::string userChoice;
        std::cin>>userChoice;
        if (userChoice == "Yes"){
            FileRequestProto::FileRequest fileRequestProto;
            fileRequestProto.ParseFromArray(buffer.data(), buffer.size());
            std::optional<FileRequest> file_request;
            try {
                file_request = FileRequestConverter::toPacket(fileRequestProto);
            }catch (const std::exception& e) {
                std::cerr<<e.what();
                return;
            }

            // OnlineDevice onlineDevice(
            //    file_request->get_device(),
            //    file_request->get_unique_id(),
            //    clientSocket
            // );
            //
            // std::unique_lock<std::mutex> lock = std::unique_lock<std::mutex>(onlineDeviceMutex);
            // std::string uniqueId = file_request->get_unique_id();
            // onlineDevices.insert({uniqueId,onlineDevice});
            // lock.unlock();
        };

    }



}

void DiscoveryService::stopDiscoveryRequestLister() {
    stopDiscoveryListenServer = true;
}
