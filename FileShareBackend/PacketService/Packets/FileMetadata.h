//
// Created by VijayNSadashiva on 26-07-2026.
//

// #ifndef FILESHAREBACKEND_FILEMETADATA_H
// #define FILESHAREBACKEND_FILEMETADATA_H
//
// #endif //FILESHAREBACKEND_FILEMETADATA_H

#pragma once
#include <iostream>
#include <string>

#include "PacketEnums.h"

class FileMetadata {
    PacketTypes PacketType;
    std::string FileName;
    std::string FileType;
    long long FileSize;
public:
    FileMetadata(std::string file_name, std::string file_type, long long file_size)
        : FileName(file_name),
          FileType(file_type),
          FileSize(file_size),
    PacketType(PacketTypes::kFileMetadata){
    }

    bool isInvalid() const {
        return  FileName.empty() || FileType.empty();
    }

    PacketTypes get_packet_type() const {
        return PacketType;
    }

    void set_packet_type(PacketTypes packet_type) {
        if (PacketTypes::kFileMetadata != packet_type) return;
        PacketType = packet_type;
    }

    std::string get_file_name() const {
        return FileName;
    }

    void set_file_name(std::string file_name) {
        FileName = file_name;
    }

    std::string get_file_type() const {
        return FileType;
    }

    void set_file_type(std::string file_type) {
        FileType = file_type;
    }

    long long get_file_size() const {
        return FileSize;
    }

    void set_file_size(long long file_size) {
        FileSize = file_size;
    }
};
