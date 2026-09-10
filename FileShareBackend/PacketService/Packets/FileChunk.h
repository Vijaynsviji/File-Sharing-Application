//
// Created by VijayNSadashiva on 26-07-2026.
//

// #ifndef FILESHAREBACKEND_FILECHUNK_H
// #define FILESHAREBACKEND_FILECHUNK_H
//
// #endif //FILESHAREBACKEND_FILECHUNK_H

#pragma once
#include <iostream>
#include <string>
#include <vector>

#include "PacketEnums.h"

class FileChunk {
    PacketTypes PacketType;
    std::string UniqueId;
    std::string FileData;
    int chunkNumber;
    long long chunkSize;

public:
    FileChunk(std::string unique_id, std::string file_data, int chunk_number, long long chunk_size)
        : UniqueId(unique_id),
          FileData(file_data),
          chunkNumber(chunk_number),
            PacketType(PacketTypes::kFileChunk),
          chunkSize(chunk_size) {
    }


    bool isInvalid() const{
        return  UniqueId.empty();
    }


    PacketTypes get_packet_type() const {
        return PacketType;
    }

    void set_packet_type(PacketTypes packet_type) {
        if (PacketTypes::kFileChunk != packet_type) return;
        PacketType = packet_type;
    }

    std::string get_unique_id() const {
        return UniqueId;
    }

    void set_unique_id(std::string unique_id) {
        UniqueId = unique_id;
    }

    std::string get_file_data() const {
        return FileData;
    }

    void set_file_data(std::string file_data) {
        FileData = file_data;
    }

    int get_chunk_number() const {
        return chunkNumber;
    }

    void set_chunk_number(int chunk_number) {
        chunkNumber = chunk_number;
    }

    long long get_chunk_size() const {
        return chunkSize;
    }

    void set_chunk_size(long long chunk_size) {
        chunkSize = chunk_size;
    }
};
