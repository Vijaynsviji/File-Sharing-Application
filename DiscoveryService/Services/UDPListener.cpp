//
// Created by VijayNSadashiva on 07-08-2026.
//

#include "UDPListener.h"

#include <iostream>
#include <winsock2.h>
#include <vector>
#include <ws2tcpip.h>

#include "UDPService.h"
#include "DiscoveryService/Models/OnlineDevice.h"
#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/UDPSocketConfig.h"

#pragma comment(lib, "Ws2_32.lib")


void UDPListener::listenUDP(std::vector<OnlineDevice>& devices) {
    // SOCKET listenSocket = socket(AF_INET,SOCK_DGRAM,0);
    // if (listenSocket == INVALID_SOCKET) {
    //     throw std::runtime_error("Not able to create Socket for UDP Listen");
    // }
    //
    // sockaddr_in address{
    //     AF_INET,
    //     htons(listenPortValue),
    //     INADDR_ANY
    // };

    UDPSocketConfig udpSocketParams{};
    udpSocketParams.portValue = listenPortValue;
    udpSocketParams.isListenBroadCastMessage = true;

    SocketValue createdSocketValue = UDPService::createSocket(udpSocketParams);
    SOCKET listenSocket = createdSocketValue.socket;
    sockaddr_in address = createdSocketValue.address;

    int bindSocketToAdrress = bind(listenSocket,(struct sockaddr*)&address,sizeof(address));
    if (bindSocketToAdrress == SOCKET_ERROR) {
        throw std::runtime_error("Not able to Bind to Socket address in UDP Listen");
    }

    // int listenToBindedAdress = listen(listenSocket,10);

    while (true) {
        if (stopListening) break;

        sockaddr_in clientSocket;
        std::vector<char> buffer(bufferSize);
        int sizeOfClientSocket  = sizeof(clientSocket);
        int receiveFromResponse = recvfrom(listenSocket,buffer.data(),buffer.size(),0,(struct sockaddr*)
           &clientSocket, &sizeOfClientSocket);
        if (receiveFromResponse == SOCKET_ERROR) {
            std::cerr<<"Not able to Connect"<<std::endl;
        }

        //TODO 1:  here Sender Discovery Packet Received, and will send one File Request Message.


        //TODO 2: then break this loop after the File Request Message Sent.


    }

}

void UDPListener::stopServer() {
    stopListening = true;
}