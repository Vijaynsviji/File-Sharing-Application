//
// Created by VijayNSadashiva on 30-07-2026.
//

#include "FileMetadataConverter.h"

#include <iostream>
#include<string>

#include "PacketService/Packets/FileMetadata.h"
#include "PacketService/Proto/FileMetadata.pb.h"



FileMetadataProto::FileMetadata FileMetadataConverter::toProto(const FileMetadata& file_metadata) {
    if (file_metadata.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid File Meta Data object to Proto.");
    }
    FileMetadataProto::FileMetadata file_metadata_proto;
    file_metadata_proto.set_packettype(PacketEnum::FileMetadata);
    file_metadata_proto.set_filetype(file_metadata.get_file_type());
    file_metadata_proto.set_filename(file_metadata.get_file_name());
    file_metadata_proto.set_filesize(file_metadata.get_file_size());

    return file_metadata_proto;
}

FileMetadata FileMetadataConverter::toPacket(const FileMetadataProto::FileMetadata& file_metadata_proto) {

    std::string fileName = file_metadata_proto.filename();
    std::string fileType = file_metadata_proto.filetype();
    int fileSize = file_metadata_proto.filesize();

    if (fileName.empty() || fileType.empty()) {
        throw std::invalid_argument("Cannot convert invalid File Meta Data Proto to File Meta Data.");
    }


    FileMetadata file_metadata(
        fileName,
        fileType,
        fileSize
    );

    return file_metadata;
}