//
// Created by VijayNSadashiva on 10-08-2026.
//

// #ifndef FILESHAREBACKEND_DISCOVERYFACTORY_H
// #define FILESHAREBACKEND_DISCOVERYFACTORY_H
//
// #endif //FILESHAREBACKEND_DISCOVERYFACTORY_H

#pragma once
#include <iostream>
#include <string>

#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Packets/Discovery.h"
#include "PacketService/Proto/Discovery.pb.h"

class DiscoveryPacketFactory {
public:
    static Discovery createPacket(
        std::string &uniqueId,
        Device &device
    );


    static discoverProto::Discovery createProto(
        std::string& uniqueId,
        Device& device
    );
};
