//
// Created by VijayNSadashiva on 04-08-2026.
//

// #ifndef FILESHAREBACKEND_FILECHUNKCONVERTER_H
// #define FILESHAREBACKEND_FILECHUNKCONVERTER_H
//
// #endif //FILESHAREBACKEND_FILECHUNKCONVERTER_H


#pragma once
#include <iostream>
#include <string>

#include "PacketService/Packets/FileChunk.h"
#include "PacketService/Proto/FileChunk.pb.h"


class FileChunkConverter {
public:

    static FileChunkProto::FileChunk toProto(const FileChunk& file_chunk);

    static FileChunk toPacket(const FileChunkProto::FileChunk& file_chunk_proto);
};
