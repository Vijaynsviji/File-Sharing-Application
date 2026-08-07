//
// Created by VijayNSadashiva on 06-08-2026.
//

// #ifndef FILESHAREBACKEND_ONLINEDEVICE_H
// #define FILESHAREBACKEND_ONLINEDEVICE_H
//
// #endif //FILESHAREBACKEND_ONLINEDEVICE_H

#pragma once
#include <iostream>
#include <vector>
#include <string>
#include <winsock2.h>

#include <ws2tcpip.h>

#include "DiscoveryService/Models/OnlineDevice.h"

#pragma comment(lib, "Ws2_32.lib")

#include "PacketService/Packets/Device.h"


class OnlineDevice {
    Device device;
    std::string uniqueId;
    sockaddr_in deviceSocket;
    time_t lastHeartBeatTimeStamp;
public:

    OnlineDevice(Device& device_value, std::string uniqueId,sockaddr_in& socket):
    device(device_value),
    uniqueId(uniqueId),
    deviceSocket(socket)
    {
        time(&lastHeartBeatTimeStamp);
    };

    Device device1() const {
        return device;
    }

    void set_device(Device& device_value) {
        this->device = device_value;
    }

    std::string unique_id() const {
        return uniqueId;
    }

    void set_unique_id(std::string& unique_id) {
        uniqueId = unique_id;
    }

    sockaddr_in getDeviceSocket() {
        return deviceSocket;
    }

    void setDeviceSocket(sockaddr_in socket) {
        deviceSocket = socket;
    }

    time_t last_heart_beat_time_stamp() const {
        return lastHeartBeatTimeStamp;
    }

    void set_last_heart_beat_time_stamp(time_t last_heart_beat_time_stamp) {
        lastHeartBeatTimeStamp = last_heart_beat_time_stamp;
    }
};
