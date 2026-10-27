//
// Created by VijayNSadashiva on 07-08-2026.
//


#include "UDPBroadcaster.h"

#include <iostream>
#include "UniversalSocket.h"
#include <vector>
// #include <bits/this_thread_sleep.h>
#include <thread>


#include "UDPService.h"
#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/UDPSocketConfig.h"
#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Converters/UserConverter.h"
#include "PacketService/Factory/DiscoveryPacketFactory.h"
#include "PacketService/Packets/Discovery.h"
#include "PacketService/Packets/User.h"
#include "Utils/utils.h"


void UDPBroadcaster::broadCastUDP(
        Device& device,
        User& user
    ) {
    // SocketType broadCastSocket = socket(AF_INET,SOCK_DGRAM,0);
    // if (broadCastSocket == INVALID_SOCKET) {
    //     throw std::runtime_error("Not able to create Socket for UDP Listen");
    // }
    //
    // int isBroadCastEnabled = 1;
    // setsockopt(
    //     broadCastSocket,
    //     SOL_SOCKET,
    //     SO_BROADCAST,
    //     (const char*)&isBroadCastEnabled,
    //     sizeof(isBroadCastEnabled)
    //     );
    //
    // sockaddr_in address{
    //     AF_INET,
    //    htons(broadCastPort)
    // };

    UDPSocketConfig udpSocketParams{};
    udpSocketParams.portValue = broadCastPort;
    udpSocketParams.isBroadCastEnabled = true;
    udpSocketParams.listenIPAddress = "255.255.255.255";

    SocketValue createdSocketValue = UDPService::createSocket(udpSocketParams);
    SocketType broadCastSocket = createdSocketValue.socket;
    sockaddr_in address = createdSocketValue.address;

    // inet_pton(AF_INET,"255.255.255.255",&address.sin_addr);
    stopServer.store(false);

    while (!stopServer.load()) {
        // if (stopServer) {
        //     if (broadCastSocket != INVALID_SOCKET) {
        //         CROSS_CLOSE(broadCastSocket);
        //     }
        //     break;
        // }

        std::string msg = "BroadCasting Message";
        std::cout<<"Started BroadCasing"<<std::endl;
        auto uniqueId = Utility::generateGUID();
        auto discoveryProto = DiscoveryPacketFactory::createProto(uniqueId,device,user);

        std::string bufferStr;
        if (!discoveryProto.SerializeToString(&bufferStr)) {
            throw std::runtime_error("Cannot covert Discovery Packet to buffer String");
        }

        int sendDiscoveryData = sendto(broadCastSocket,
                                        bufferStr.data(),
                                        bufferStr.size(),0,
                                        (struct sockaddr*)&address,
                                        sizeof(address)
                                        );
        std::cout << "sendto returned: "
          << sendDiscoveryData << std::endl;
        if (sendDiscoveryData == SOCKET_ERROR) {
            throw std::runtime_error("Not able to broadcast Discovery Packet.");
        }

        // std::this_thread::sleep_for(std::chrono::seconds(5));

        std::unique_lock<std::mutex> lock(stopMutex);

        if (stopCondition.wait_for(
            lock,
            std::chrono::seconds(5),
            [this] { return stopServer.load(); })) {
        break;
            }
        }

    // The worker owns socket cleanup.
    if (broadCastSocket != INVALID_SOCKET) {
        CROSS_CLOSE(broadCastSocket);
        broadCastSocket = INVALID_SOCKET;
    }

        // TODO 1: Create Discovery Packet and Convert that Packet to PROTO.

        //TODO 2: Send this Packet and wait for some seconds and Do Again.


    }

void UDPBroadcaster::shutDownServer() {
    stopServer.store(true);
    stopCondition.notify_all();
}