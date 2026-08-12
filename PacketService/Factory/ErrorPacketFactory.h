//
// Created by VijayNSadashiva on 12-08-2026.
//

// #ifndef FILESHAREBACKEND_ERRORPACKETFACTORY_H
// #define FILESHAREBACKEND_ERRORPACKETFACTORY_H
//
// #endif //FILESHAREBACKEND_ERRORPACKETFACTORY_H

#pragma once
#include<string>
#include "PacketService/Packets/Error.h"
#include "PacketService/Proto/Error.pb.h"


class ErrorPacketFactory {
public:

    static Error createPacket(
        std::string& uniqueId,
        std::string& errorDetails
    );

    static ErrorProto::Error createProto(
        std::string& uniqueId,
        std::string& errorDetails
    );
};
