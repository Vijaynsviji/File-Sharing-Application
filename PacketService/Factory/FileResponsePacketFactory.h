//
// Created by VijayNSadashiva on 12-08-2026.
//

// #ifndef FILESHAREBACKEND_FILERESPONSEPACKETFACTORY_H
// #define FILESHAREBACKEND_FILERESPONSEPACKETFACTORY_H
//
// #endif //FILESHAREBACKEND_FILERESPONSEPACKETFACTORY_H

#pragma once
#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Converters/FileMetadataConverter.h"
#include "PacketService/Packets/FileResponse.h"
#include "PacketService/Proto/FileResponse.pb.h"


class FileResponsePacketFactory {
public:
    static FileResponse createPacket(
        std::vector<FileMetadata>& fileMetadata,
        bool isSenderAccepted
    );

    static FileResponseProto::FileResponse createProto(
        std::vector<FileMetadata>& fileMetadata,
       bool isSenderAccepted
    );
};
