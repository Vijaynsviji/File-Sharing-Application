//
// Created by VijayNSadashiva on 07-08-2026.
//

#include "UDPListener.h"

#include <iostream>
#include <unordered_map>

#include "UniversalSocket.h"
#include <vector>
#include <nlohmann/json.hpp>


#include "UDPService.h"
#include "DiscoveryService/Models/OnlineDevice.h"
#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/UDPSocketConfig.h"
#include "PacketService/Converters/DiscoveryConverter.h"
#include "PacketService/Proto/Discovery.pb.h"


void UDPListener::listenUDP(std::unordered_map<std::string,OnlineDevice>& onlineDevice) {

    UDPSocketConfig udpSocketParams{};
    udpSocketParams.portValue = listenPortValue;
    udpSocketParams.isListenBroadCastMessage = true;

    SocketValue createdSocketValue = UDPService::createSocket(udpSocketParams);
    SocketType listenSocket = createdSocketValue.socket;
    sockaddr_in address = createdSocketValue.address;

    int bindSocketToAdrress = bind(listenSocket,(struct sockaddr*)&address,sizeof(address));
    if (bindSocketToAdrress == SOCKET_ERROR) {
        throw std::runtime_error("Not able to Bind to Socket address in UDP Listen");
    }

    // int listenToBindedAdress = listen(listenSocket,10);

    while (true) {
        if (stopListening.load()) {
            if (listenSocket != INVALID_SOCKET) {
                CROSS_CLOSE(listenSocket);
            }
            break;
        }

        sockaddr_in clientSocket;
        std::vector<char> buffer(65507);
        socklen_t  sizeOfClientSocket  = sizeof(clientSocket);
        std::cout<<"BroadCast Listner is Started"<<std::endl;
        int receiveFromResponse = recvfrom(listenSocket,buffer.data(),buffer.size(),0,(struct sockaddr*)
           &clientSocket, &sizeOfClientSocket);
        if (receiveFromResponse == SOCKET_ERROR) {
            std::cerr<<"Not able to Connect"<<std::endl;
        }

        char ipAddress[INET_ADDRSTRLEN]{};

        if (inet_ntop(
                AF_INET,
                &clientSocket.sin_addr,
                ipAddress,
                sizeof(ipAddress)) != nullptr) {

            std::cout << "Packet received from IP: "
                      << ipAddress << std::endl;
                }

        std::string receivedData(buffer.data(), receiveFromResponse);
        if (stopListening.load() ||
            receivedData == POISON_PILL) {
                    break;
            }

        std::cout<<"Found a BroadCast Message"<<std::endl;


        discoveryProto::Discovery discoveryProto;
        if (!discoveryProto.ParseFromString(buffer.data())) {
            throw std::runtime_error("Not able to Deserialise captured Data");
        }
        //TODO 1:  here Sender Discovery Packet Received, and will send one File Request Message.
        std::cout<<discoveryProto.DebugString()<<std::endl;

        Discovery discoveryPacket = DiscoveryConverter::toPacket(discoveryProto);
        if (discoveryPacket.isInvalid()) {
            throw std::runtime_error("Not able to convert Discovery Proto to Packet");
        }

        eventEmitter.sendDiscoveredUserEvent(discoveryPacket,ipAddress);
    }

}

void UDPListener::stopServer() {
    stopListening.store(true);

    SocketType wakeSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (wakeSocket == INVALID_SOCKET) {
        return;
    }

    sockaddr_in address{};
    address.sin_family = AF_INET;
    address.sin_port = htons(listenPortValue);
    address.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

    sendto(
        wakeSocket,
        POISON_PILL.c_str(),
        sizeof(POISON_PILL) - 1,
        0,
        reinterpret_cast<sockaddr*>(&address),
        sizeof(address)
    );

    CROSS_CLOSE(wakeSocket);
}