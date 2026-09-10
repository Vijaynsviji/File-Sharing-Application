//
// Created by VijayNSadashiva on 10-08-2026.
//

// #ifndef FILESHAREBACKEND_FILEMETADATAPACKETFACTORY_H
// #define FILESHAREBACKEND_FILEMETADATAPACKETFACTORY_H
//
// #endif //FILESHAREBACKEND_FILEMETADATAPACKETFACTORY_H

#pragma once
#include <string>

#include "PacketService/Packets/FileMetadata.h"
#include "PacketService/Proto/FileMetadata.pb.h"


class FileMetadataPacketFactory {
public:
    static FileMetadata createPacket(
        std::string &fileName,
        std::string &fileType,
        long long &fileSize
    );

    static FileMetadataProto::FileMetadata createProto(
        std::string &fileName,
        std::string &fileType,
        long long &fileSize
    );
};
