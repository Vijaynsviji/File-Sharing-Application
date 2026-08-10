//
// Created by VijayNSadashiva on 10-08-2026.
//

#include <string>

#include "FIleMetadataPacketFactory.h"
#include "PacketService/Packets/FileMetadata.h"
#include "PacketService/Proto/FileMetadata.pb.h"

FileMetadata FileMetadataPacketFactory::createPacket(
    std::string &fileName,
    std::string &fileType,
    long long &fileSize
) {
    if (fileName.empty() || fileType.empty()) {
        throw std::invalid_argument("Cannot Create File Metadata Packet.");
    }

    FileMetadata fileMetadata(fileName,fileType,fileSize);
    return fileMetadata;
}

FileMetadataProto::FileMetadata FileMetadataPacketFactory::createProto(
    std::string &fileName,
    std::string &fileType,
    long long &fileSize
) {
    if (fileName.empty() || fileType.empty()) {
        throw std::invalid_argument("Cannot Create File Metadata Proto.");
    }

    FileMetadataProto::FileMetadata fileMetadataProto;
    fileMetadataProto.set_filename(fileName);
    fileMetadataProto.set_filetype(fileType);
    fileMetadataProto.set_filesize(fileSize);
    fileMetadataProto.set_packettype(PacketEnum::FileMetadata);

    return fileMetadataProto;
}