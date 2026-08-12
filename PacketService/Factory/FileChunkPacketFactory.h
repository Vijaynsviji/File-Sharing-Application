//
// Created by VijayNSadashiva on 12-08-2026.
//

// #ifndef FILESHAREBACKEND_FILECHUNKPACKETFACTORY_H
// #define FILESHAREBACKEND_FILECHUNKPACKETFACTORY_H
//
// #endif //FILESHAREBACKEND_FILECHUNKPACKETFACTORY_H

#pragma once
#include <string>
#include "PacketService/Packets/FileChunk.h"
#include "PacketService/Proto/FileChunk.pb.h"


class FileChunkPacketFactory {
public:

    static FileChunk createPacket(
        std::string& uniqueId,
        std::string& fileData,
        long long chunkSize,
        int chunkNumber
    );

    static FileChunkProto::FileChunk createProto(
        std::string& uniqueId,
        std::string& fileData,
        long long chunkSize,
        int chunkNumber
    );
};
