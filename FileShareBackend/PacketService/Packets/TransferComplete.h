//
// Created by VijayNSadashiva on 26-07-2026.
//
//
// #ifndef FILESHAREBACKEND_TRANSFERCOMPLETE_H
// #define FILESHAREBACKEND_TRANSFERCOMPLETE_H
//
// #endif //FILESHAREBACKEND_TRANSFERCOMPLETE_H

#pragma once
#include <iostream>
#include <string>

#include "PacketEnums.h"

class TransferComplete {
    PacketTypes PacketType;
    std::string uniqueId;

public:
    explicit TransferComplete(std::string unique_id)
        : uniqueId(unique_id),
    PacketType(PacketTypes::kTransferComplete){
    }

    bool isInvalid() {
        return uniqueId.empty();
    }

    PacketTypes get_packet_type() const {
        return PacketType;
    }

    std::string get_unique_id() const {
        return uniqueId;
    }
};
