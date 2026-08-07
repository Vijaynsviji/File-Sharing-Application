//
// Created by VijayNSadashiva on 06-08-2026.
//

// #ifndef FILESHAREBACKEND_UDPLISTENER_H
// #define FILESHAREBACKEND_UDPLISTENER_H
//
// #endif //FILESHAREBACKEND_UDPLISTENER_H


#pragma once
#include <iostream>
#include <winsock2.h>
#include <vector>
#include <ws2tcpip.h>

#include "DiscoveryService/Models/OnlineDevice.h"

#pragma comment(lib, "Ws2_32.lib")


class UDPListener {
    int bufferSize = 1024;
    bool stopListening = false;
    int listenPortValue;
public:

    explicit UDPListener(int portValue): listenPortValue(portValue){}

    void listenUDP(std::vector<OnlineDevice>& devices);

    void stopServer();
};