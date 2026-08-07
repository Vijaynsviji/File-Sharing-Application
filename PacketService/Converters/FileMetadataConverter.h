//
// Created by VijayNSadashiva on 30-07-2026.
//

// #ifndef FILESHAREBACKEND_FILEMETADATACONVERTER_H
// #define FILESHAREBACKEND_FILEMETADATACONVERTER_H
//
// #endif //FILESHAREBACKEND_FILEMETADATACONVERTER_H

#pragma once
#include <iostream>
#include<string>

#include "PacketService/Packets/FileMetadata.h"
#include "PacketService/Proto/FileMetadata.pb.h"

class FileMetadataConverter {
public:

    static FileMetadataProto::FileMetadata toProto(const FileMetadata& file_metadata);

    static FileMetadata toPacket(const FileMetadataProto::FileMetadata& file_metadata_proto);

};
