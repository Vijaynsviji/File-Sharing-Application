//
// Created by VijayNSadashiva on 12-08-2026.
//


#include "FileChunkPacketFactory.h"

#include <string>
#include "PacketService/Packets/FileChunk.h"
#include "PacketService/Proto/FileChunk.pb.h"


FileChunk FileChunkPacketFactory::createPacket(
       std::string& uniqueId,
       std::string& fileData,
       long long chunkSize,
       int chunkNumber
   ) {
    if (uniqueId.empty() || fileData.empty()) {
        throw std::invalid_argument("Cannot Create File Chunk Packet");
    }

    FileChunk fileChunk(
        uniqueId,
        fileData,
        chunkNumber,
        chunkSize
    );
    return fileChunk;
}

FileChunkProto::FileChunk FileChunkPacketFactory::createProto(
    std::string& uniqueId,
    std::string& fileData,
    long long chunkSize,
    int chunkNumber
) {
    if (uniqueId.empty() || fileData.empty()) {
        throw std::invalid_argument("Cannot Create File Chunk Proto");
    }

    FileChunkProto::FileChunk fileChunkProto;
    fileChunkProto.set_packettype(PacketEnum::FileChunk);
    fileChunkProto.set_uniqueid(uniqueId);
    fileChunkProto.set_chunknumber(chunkNumber);
    fileChunkProto.set_chunksize(chunkSize);

    return fileChunkProto;
}