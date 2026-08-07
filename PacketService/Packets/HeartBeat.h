//
// Created by VijayNSadashiva on 26-07-2026.
//

// #ifndef FILESHAREBACKEND_HEARTBEAT_H
// #define FILESHAREBACKEND_HEARTBEAT_H
//
// #endif //FILESHAREBACKEND_HEARTBEAT_H

#pragma once
#include <iostream>
#include <string>

#include "Device.h"
#include "PacketEnums.h"

class HeartBeat {
    PacketTypes PacketType;
    // std::string DeviceType;
    // std::string DeviceName;
    Device device;
public:
    HeartBeat(Device device)
        : device(device),
            PacketType(PacketTypes::kHeartBeat){
    }

    bool isInvalid() const {
        return  device.isInvalid();
    }

    PacketTypes get_packet_type() const {
        return PacketType;
    }

    void set_packet_type(PacketTypes packet_type) {
        if (packet_type != PacketTypes::kHeartBeat)
        PacketType = packet_type;
    }

    Device get_device() const {
        return device;
    }

    void set_device_type(Device newDevice) {
        device = newDevice;
    }
    //
    // std::string get_device_name() const {
    //     return DeviceName;
    // }
    //
    // void set_device_name(std::string device_name) {
    //     DeviceName = device_name;
    // }
};
