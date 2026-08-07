//
// Created by VijayNSadashiva on 26-07-2026.
//

// #ifndef FILESHAREBACKEND_DEVICE_H
// #define FILESHAREBACKEND_DEVICE_H
//
// #endif //FILESHAREBACKEND_DEVICE_H

#pragma once
#include <iostream>
#include <string>

class Device {
    std::string DeviceId;
    std::string DeviceName;
    std::string DeviceType;
public:
    Device(std::string device_id, std::string device_name, std::string device_type)
        : DeviceId(device_id),
          DeviceName(device_name),
          DeviceType(device_type) {
    }

    std::string get_device_id() const {
        return DeviceId;
    }

    void set_device_id(std::string device_id) {
        DeviceId = device_id;
    }

    std::string get_device_name() const{
        return DeviceName;
    }

    void set_device_name(std::string device_name) {
        DeviceName = device_name;
    }

    std::string get_device_type() const{
        return DeviceType;
    }

    void set_device_type(std::string device_type) {
        DeviceType = device_type;
    }

    bool isInvalid() const {
        return DeviceId.empty() || !DeviceType.empty() || DeviceName.empty();
    }
};