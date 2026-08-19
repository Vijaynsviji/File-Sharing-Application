//
// Created by VijayNSadashiva on 18-08-2026.
//

// #ifndef FILESHAREBACKEND_FILE_H
// #define FILESHAREBACKEND_FILE_H
//
// #endif //FILESHAREBACKEND_FILE_H

#pragma once
#include <string>

#include "PacketService/Packets/FileMetadata.h"

class File {
    std::string filePath;
    FileMetadata fileMetadata;
public:
    File(std::string file_path, FileMetadata file_metadata)
        : filePath(file_path),
          fileMetadata(file_metadata) {
    }

    std::string get_file_path() const {
        return filePath;
    }

    void set_file_path(std::string file_path) {
        filePath = file_path;
    }

    FileMetadata get_file_metadata() const {
        return fileMetadata;
    }

    void set_file_metadata(FileMetadata file_metadata) {
        fileMetadata = file_metadata;
    }
};
