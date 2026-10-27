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
#include <atomic>

#include "UniversalSocket.h"
#include <vector>


#include "DiscoveryService/Models/OnlineDevice.h"
#include "EventService/EventEmitter.h"


class UDPListener {
    DartEventEmitter& eventEmitter;
    int bufferSize = 1024;
    // bool stopListening = false;
    std::atomic<bool> stopListening{false};
    int listenPortValue;

    std::string POISON_PILL = "__STOP_UDP_LISTENER__";
public:

    explicit UDPListener(int portValue,DartEventEmitter& eventEmitter): listenPortValue(portValue),eventEmitter(eventEmitter){}

    void listenUDP(std::unordered_map<std::string,OnlineDevice>& onlineDevice);

    void stopServer();
};
