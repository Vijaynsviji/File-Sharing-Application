//
// Created by VijayNSadashiva on 07-08-2026.
//

// #ifndef FILESHAREBACKEND_UDPBROADCASTER_H
// #define FILESHAREBACKEND_UDPBROADCASTER_H
//
// #endif //FILESHAREBACKEND_UDPBROADCASTER_H


#pragma once
#include <iostream>
#include <winsock2.h>
#include <vector>
#include <ws2tcpip.h>

#include "DiscoveryService/Models/OnlineDevice.h"

#pragma comment(lib, "Ws2_32.lib")



class UDPBroadcaster {
    int broadCastPort;
    bool stopServer = false;
    int bufferSize = 1024;
public:
    explicit UDPBroadcaster(int portValue,int bufferSize):broadCastPort(portValue),bufferSize(bufferSize){}
    void broadCastUDP();

    void shutDownServer();
};