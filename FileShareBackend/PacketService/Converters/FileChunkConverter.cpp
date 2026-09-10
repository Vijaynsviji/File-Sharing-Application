//
// Created by VijayNSadashiva on 04-08-2026.
//

#include "FileChunkConverter.h"

#include <iostream>
#include <string>

#include "PacketService/Packets/FileChunk.h"
#include "PacketService/Proto/FileChunk.pb.h"


FileChunkProto::FileChunk FileChunkConverter::toProto(const FileChunk& file_chunk) {
    if (file_chunk.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid File chunk Data object to Proto.");
    }

    FileChunkProto::FileChunk file_chunk_proto;
    file_chunk_proto.set_packettype(PacketEnum::FileChunk);
    auto fileData = file_chunk.get_file_data();
    file_chunk_proto.set_filedata(fileData.data(),fileData.size());
    file_chunk_proto.set_chunknumber(file_chunk.get_chunk_number());
    file_chunk_proto.set_chunksize(file_chunk.get_chunk_size());
    file_chunk_proto.set_uniqueid(file_chunk.get_unique_id());

    return file_chunk_proto;
}

FileChunk FileChunkConverter::toPacket(const FileChunkProto::FileChunk& file_chunk_proto) {

    std::string fileData = file_chunk_proto.filedata().data();
    FileChunk file_chunk(
        file_chunk_proto.uniqueid(),
        fileData,
        file_chunk_proto.chunknumber(),
        file_chunk_proto.chunksize()
    );

    return file_chunk;
}