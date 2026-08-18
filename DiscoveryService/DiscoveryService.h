//
// Created by VijayNSadashiva on 13-08-2026.
//

// #ifndef FILESHAREBACKEND_DISCOVERYSERVICE_H
// #define FILESHAREBACKEND_DISCOVERYSERVICE_H
//
// #endif //FILESHAREBACKEND_DISCOVERYSERVICE_H


#pragma once
#include <unordered_map>
#include <string>
#include <mutex>
#include <bits/this_thread_sleep.h>

#include "Models/OnlineDevice.h"
#include "PacketService/Converters/FileRequestConverter.h"
#include "PacketService/Packets/FileRequest.h"
#include "PacketService/Proto/FileRequest.pb.h"
#include "Services/TCPService.h"
#include "Services/UDPBroadcaster.h"
#include "Services/UDPListener.h"
#include "Types/SocketValue.h"


class DiscoveryService {
    std::unordered_map<std::string,OnlineDevice> onlineDevices;
    UDPBroadcaster udpBroadCaster;
    UDPListener udpListener;
    std::mutex onlineDeviceMutex;
    bool stopRemoveInactiveTask = false;
    bool stopDiscoveryListenServer = false;
    int DiscoveryTCPPort;
public:
    DiscoveryService(long long bufferSize, int portValue,int discoveryTCPPort):
    udpBroadCaster(portValue,bufferSize),udpListener(portValue),DiscoveryTCPPort(discoveryTCPPort){}

    void removeInactivDevices();

    void stopRemoveInactivyDeviceTask();

    void DiscoveryRequestListner();

    void stopDiscoveryRequestLister();
};
