//
// Created by VijayNSadashiva on 07-08-2026.
//


#include "UDPBroadcaster.h"

#include <iostream>
#include <winsock2.h>
#include <vector>
#include <ws2tcpip.h>

#include "UDPService.h"
#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/UDPSocketConfig.h"

#pragma comment(lib, "Ws2_32.lib")

void UDPBroadcaster::broadCastUDP() {
    // SOCKET broadCastSocket = socket(AF_INET,SOCK_DGRAM,0);
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
    SOCKET broadCastSocket = createdSocketValue.socket;
    sockaddr_in address = createdSocketValue.address;

    // inet_pton(AF_INET,"255.255.255.255",&address.sin_addr);

    while (true) {
        if (stopServer) break;

        std::vector<char> buffer(bufferSize);
        int sendDiscoveryData = sendto(broadCastSocket,
                                        buffer.data(),
                                        buffer.size(),0,
                                        (struct sockaddr*)&address,
                                        sizeof(address)
                                        );
        if (sendDiscoveryData == SOCKET_ERROR) {
            throw std::runtime_error("Not able to broadcast Discovery Packet.");
        }

        // TODO 1: Create Discovery Packet and Convert that Packet to PROTO.

        //TODO 2: Send this Packet and wait for some seconds and Do Again.


    }



}

void UDPBroadcaster::shutDownServer() {
    stopServer = true;
}