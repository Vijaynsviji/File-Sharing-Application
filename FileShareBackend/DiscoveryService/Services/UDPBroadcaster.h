//
// Created by VijayNSadashiva on 07-08-2026.
//

// #ifndef FILESHAREBACKEND_UDPBROADCASTER_H
// #define FILESHAREBACKEND_UDPBROADCASTER_H
//
// #endif //FILESHAREBACKEND_UDPBROADCASTER_H


#pragma once
#include <iostream>
#include "UniversalSocket.h"
#include <vector>
#include <atomic>
#include <condition_variable>
#include <mutex>


#include "DiscoveryService/Models/OnlineDevice.h"
#include "PacketService/Packets/User.h"


class UDPBroadcaster {
    int broadCastPort;
    std::atomic<bool> stopServer{false};
    int bufferSize = 1024;

    std::mutex stopMutex;
    std::condition_variable stopCondition;
public:
    explicit UDPBroadcaster(int portValue,int bufferSize):broadCastPort(portValue),bufferSize(bufferSize){}
    void broadCastUDP(
    Device& device,
User& user
        );
    void shutDownServer();
};
