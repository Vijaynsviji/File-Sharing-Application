//
// Created by VijayNSadashiva on 18-08-2026.
//

#include "TCPService.h"

#include <stdexcept>
#include <winsock2.h>
#include <ws2tcpip.h>

#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/TCPSocketConfig.h"
#pragma comment(lib, "Ws2_32.lib")


SocketValue TCPService::createSocket(TCPSocketConfig& config) {
    SOCKET requestListenSocket = socket(AF_INET,SOCK_STREAM,0);
    if (requestListenSocket == INVALID_SOCKET) {
        throw std::runtime_error("Not able to Create a TCP Socket!!");
    }

    sockaddr_in address{
        AF_INET,
        htons(config.portValue)
    };

    int bindSocket = bind(requestListenSocket,(const struct sockaddr*)&address,sizeof(address));
    if (bindSocket == SOCKET_ERROR) {
        throw std::runtime_error("Not able to Bind to a Port");
    }

    int assignIp = inet_pton(AF_INET,config.listenIPAddress.data(),&address);
    if (assignIp == SOCKET_ERROR) {
        throw std::runtime_error("Not able to assign a IP");
    }

    int listenToRequest = listen(requestListenSocket,10);
    if (listenToRequest == SOCKET_ERROR) {
        throw std::runtime_error("Not able to Listen for Requests");
    }

    return SocketValue(requestListenSocket,address);
}


