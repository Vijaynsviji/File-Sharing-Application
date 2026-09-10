//
// Created by VijayNSadashiva on 12-08-2026.
//

// #ifndef FILESHAREBACKEND_FILEREQUESTPACKETFACTORY_H
// #define FILESHAREBACKEND_FILEREQUESTPACKETFACTORY_H
//
// #endif //FILESHAREBACKEND_FILEREQUESTPACKETFACTORY_H

#pragma once
#include<string>

#include "PacketService/Packets/FileRequest.h"
#include "PacketService/Proto/FileRequest.pb.h"


class FileRequestPacketFactory {
public:

    static FileRequest createPacket(
        std::string& uniqueId,
        Device& device
    );

    static FileRequestProto::FileRequest createProto(
        std::string& uniqueId,
        Device& device
    );
};
