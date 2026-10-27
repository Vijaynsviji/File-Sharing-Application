//
// Created by VijayNSadashiva on 26-07-2026.
//

// #ifndef FILESHAREBACKEND_DISCOVERY_H
// #define FILESHAREBACKEND_DISCOVERY_H
//
// #endif //FILESHAREBACKEND_DISCOVERY_H

#pragma once
#include <iostream>
#include <string>

#include "Device.h"
#include "PacketEnums.h"
#include "User.h"

class Discovery{
    PacketTypes PacketType;
    std::string UniqueId;
    // std::string DeviceName;
    // std::string DeviceType;
    Device device;
    User user;

public:
    Discovery(std::string unique_id, Device device,User user)
        : UniqueId(unique_id),
          device(device),user(user),
        PacketType(PacketTypes::kDiscovery) {
    }

    PacketTypes get_packet_type() {
        return PacketType;
    }

    void set_packet_type(PacketTypes packet_type) {
        if (packet_type != PacketTypes::kDiscovery) return;
        PacketType = packet_type;
    }

    std::string& get_unique_id() {
        return UniqueId;
    }

    void set_unique_id(std::string unique_id) {
        UniqueId = unique_id;
    }

    Device& get_device() {
        return device;
    }

    void set_device(Device newDeviceValue)  {
        device = newDeviceValue;
    }

    User& get_user() {
        return user;
    }

    void set_user(User newUser)  {
        user = newUser;
    }

    bool isInvalid() {
        return UniqueId.empty() || device.isInvalid() || user.isInvalid();
    }

    // std::string get_device_name() const {
    //     return DeviceName;
    // }
    //
    // void set_device_name(std::string device_name) {
    //     DeviceName = device_name;
    // }
    //
    // std::string get_device_type() const {
    //     return DeviceType;
    // }
    //
    // void set_device_type(std::string device_type) {
    //     DeviceType = device_type;
    // }
};
