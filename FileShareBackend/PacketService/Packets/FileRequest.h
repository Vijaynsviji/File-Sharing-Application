//
// Created by VijayNSadashiva on 26-07-2026.
//

// #ifndef FILESHAREBACKEND_FILEREQUEST_H
// #define FILESHAREBACKEND_FILEREQUEST_H
//
// #endif //FILESHAREBACKEND_FILEREQUEST_H

#pragma once
#include <iostream>
#include <string>

#include "Device.h"
#include "User.h"
#include "PacketEnums.h"

class FileRequest {
    PacketTypes PacketType;
    std::string UniqueId;
    Device device;
    User& user;


public:
    FileRequest(std::string unique_id, Device device,User user)
        : UniqueId(unique_id),
          device(device),
    user(user),
    PacketType(PacketTypes::kFileRequest){
    }

    bool isInvalid() {
        return UniqueId.empty() || device.isInvalid();
    }


    PacketTypes get_packet_type() const {
        return PacketType;
    }

    void set_packet_type(PacketTypes packet_type) {
        if (PacketTypes::kFileRequest != packet_type) return;
        PacketType = packet_type;
    }

    std::string get_unique_id() const {
        return UniqueId;
    }

    void set_unique_id(std::string unique_id) {
        UniqueId = unique_id;
    }

    Device get_device() const {
        return device;
    }

    void set_device(Device device) {
        this->device = device;
    }

    User get_user() const {
        return user;
    }

    void set_user(User user) {
        this->user = user;
    }
};
