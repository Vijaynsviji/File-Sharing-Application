//
// Created by VijayNSadashiva on 06-08-2026.
//

// #ifndef FILESHAREBACKEND_UDPLISTENER_H
// #define FILESHAREBACKEND_UDPLISTENER_H
//
// #endif //FILESHAREBACKEND_UDPLISTENER_H


#pragma once
#include <iostream>
#include <unordered_map>

#include "UniversalSocket.h"
#include <vector>


#include "DiscoveryService/Models/OnlineDevice.h"




class UDPListener {
    int bufferSize = 1024;
    bool stopListening = false;
    int listenPortValue;
public:

    explicit UDPListener(int portValue): listenPortValue(portValue){}

    void listenUDP(std::unordered_map<std::string,OnlineDevice>& onlineDevice);

    void stopServer();
};