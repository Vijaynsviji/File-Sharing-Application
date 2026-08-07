//
// Created by VijayNSadashiva on 26-07-2026.
//

// #ifndef FILESHAREBACKEND_FILERESPONSE_H
// #define FILESHAREBACKEND_FILERESPONSE_H
//
// #endif //FILESHAREBACKEND_FILERESPONSE_H

#pragma once
#include <iostream>
#include <string>

#include "FileMetadata.h"
#include "PacketEnums.h"

class FileResponse {
    PacketTypes PacketType;
    FileMetadata fileMetadata;
    bool isSenderAcceptedOrNot;
public:
    FileResponse(FileMetadata file_metadata, bool is_sender_accepted_or_not)
        : fileMetadata(file_metadata),
          isSenderAcceptedOrNot(is_sender_accepted_or_not),
    PacketType(PacketTypes::kFileMetadata){
    }

    bool isInvalid() const{
        return  fileMetadata.isInvalid();
    }

    PacketTypes get_packet_type() const {
        return PacketType;
    }

    void set_packet_type(PacketTypes packet_type) {
        if (PacketTypes::kFileRequest != packet_type) return;
        PacketType = packet_type;
    }

    FileMetadata get_file_metadata() const {
        return fileMetadata;
    }

    void set_file_metadata(FileMetadata file_metadata) {
        fileMetadata = file_metadata;
    }

    bool is_is_sender_accepted_or_not() const {
        return isSenderAcceptedOrNot;
    }

    void set_is_sender_accepted_or_not(bool is_sender_accepted_or_not) {
        isSenderAcceptedOrNot = is_sender_accepted_or_not;
    }
};
