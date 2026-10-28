//
// Created by VijayNSadashiva on 18-08-2026.
//

#include "TCPService.h"

#include <iostream>
#include <stdexcept>
#include "UniversalSocket.h"


#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/TCPSocketConfig.h"



SocketValue TCPService::createServerSocket(TCPServerSocketConfig& config) {
    SocketType requestListenSocket = socket(AF_INET,SOCK_STREAM,0);
    if (requestListenSocket == INVALID_SOCKET) {
        throw std::runtime_error("Not able to Create a TCP Socket!!");
    }

    sockaddr_in address{
        AF_INET,
        htons(config.portValue),
        INADDR_ANY
    };

    int bindSocket = bind(requestListenSocket,(const struct sockaddr*)&address,sizeof(address));
    if (bindSocket == SOCKET_ERROR) {
        CROSS_CLOSE(requestListenSocket);
        throw std::runtime_error("Not able to Bind to a Port");
    }

    int listenToRequest = listen(requestListenSocket,10);
    if (listenToRequest == SOCKET_ERROR) {
        CROSS_CLOSE(requestListenSocket);
        throw std::runtime_error("Not able to Listen for Requests");
    }

    return SocketValue(requestListenSocket,address);
}

SocketValue TCPService::createClientSocket(TCPClientSocketConfig& config) {
    SocketType requestListenSocket = socket(AF_INET,SOCK_STREAM,0);
    if (requestListenSocket == INVALID_SOCKET) {
        throw std::runtime_error("Not able to Create a TCP Socket!!");
    }

    sockaddr_in address{
        AF_INET,
        htons(config.portValue)
    };

    int assignIp = inet_pton(AF_INET,config.listenIPAddress.data(),&address.sin_addr);
    if (assignIp <= 0) {
        CROSS_CLOSE(requestListenSocket);
        throw std::runtime_error("Not able to assign a IP");
    }

    int connectResult = connect(
        requestListenSocket,
        reinterpret_cast<sockaddr*>(&address),
        sizeof(address)
    );

    if (connectResult == SOCKET_ERROR) {
        int error = CROSS_GET_ERROR();
        CROSS_CLOSE(requestListenSocket);

        throw std::runtime_error(
            "TCP connect failed. Error: " + std::to_string(error)
        );
    }

    std::cout << "TCP connection established successfully"
              << std::endl;

    return SocketValue(requestListenSocket,address);
}


