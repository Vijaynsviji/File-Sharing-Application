//
// Created by VijayNSadashiva on 15-08-2026.
//

#include "UDPService.h"

#include <stdexcept>
#include "UniversalSocket.h"




SocketValue UDPService::createSocket(
    UDPSocketConfig socketParams
) {
    SocketType udpSocket = socket(AF_INET,SOCK_DGRAM,0);
    if (udpSocket == INVALID_SOCKET) {
        throw std::runtime_error("Not able to create Socket for UDP Listen");
    }

    if (socketParams.isBroadCastEnabled) {
        int broadCastValue = 1;
        int result = setsockopt(
            udpSocket,
            SOL_SOCKET,
            SO_BROADCAST,
            (const char*)&broadCastValue,
            sizeof(broadCastValue)
            );
        if (result == SOCKET_ERROR) {
            int err = CROSS_GET_ERROR();
            CROSS_CLOSE(udpSocket); // Prevent socket leak before throwing
            throw std::runtime_error("Failed to set SO_BROADCAST. Error Code: " + std::to_string(err));
        }
    }

    sockaddr_in address{};
    address.sin_family =  AF_INET;
    address.sin_port = htons(socketParams.portValue);


    if (socketParams.isListenBroadCastMessage) {
        address.sin_addr.s_addr  = INADDR_ANY;
    }else {
        int result = inet_pton(AF_INET,socketParams.listenIPAddress.data(),&address.sin_addr);
        if (result <= 0) {
            CROSS_CLOSE(udpSocket);
            throw std::runtime_error("Invalid IP address format provided: " + socketParams.listenIPAddress);
        }
    }


    return SocketValue(udpSocket,address);
}