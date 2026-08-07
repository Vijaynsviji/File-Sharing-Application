//
// Created by VijayNSadashiva on 26-07-2026.
//
//
// #ifndef FILESHAREBACKEND_ERROR_H
// #define FILESHAREBACKEND_ERROR_H
//
// #endif //FILESHAREBACKEND_ERROR_H

#pragma once
#include <iostream>
#include <string>

#include "PacketEnums.h"

class Error {
    PacketTypes PacketType;
    std::string uniqueId;
    std::string errorDetails;
public:
    Error(std::string unique_id, std::string error_details)
        : uniqueId(unique_id),
          errorDetails(error_details),
    PacketType(PacketTypes::kError){
    }

    bool isInvalid() {
        return uniqueId.empty() || errorDetails.empty();
    }

    PacketTypes get_packet_type() const {
        return PacketType;
    }

    void set_packet_type(PacketTypes packet_type) {
        if (PacketTypes::kError != packet_type) return;
        PacketType = packet_type;
    }

    std::string get_unique_id() const {
        return uniqueId;
    }

    void set_unique_id(std::string unique_id) {
        uniqueId = unique_id;
    }

    std::string get_error_details() const {
        return errorDetails;
    }

    void set_error_details(std::string error_details) {
        errorDetails = error_details;
    }
};
