//
// Created by VijayNSadashiva on 04-08-2026.
//


#include "FileResponseConverter.h"

#include <iostream>

#include "FileMetadataConverter.h"
#include "PacketService/Packets/FileResponse.h"
#include "PacketService/Proto/FileResponse.pb.h"


FileResponseProto::FileResponse FileResponseConverter::toProto(const FileResponse& file_response) {
    if (file_response.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid File Response Data object to Proto.");
    }

    FileResponseProto::FileResponse file_response_proto;
    const FileMetadata& file_metadata = file_response.get_file_metadata();
    FileMetadataProto::FileMetadata file_metadata_proto = FileMetadataConverter::toProto(
        file_metadata
        );

    *file_response_proto.mutable_filemetdata() = std::move(file_metadata_proto);

    file_response_proto.set_packettype(PacketEnum::FileResponse);
    file_response_proto.set_issenderacceptedornot(file_response.is_is_sender_accepted_or_not());

    return file_response_proto;
}

FileResponse FileResponseConverter::toPacket(const FileResponseProto::FileResponse& file_response_proto) {
    auto file_metadata_proto = file_response_proto.filemetdata();

    auto file_metadata = FileMetadataConverter::toPacket(file_metadata_proto);

    FileResponse file_response(file_metadata,
        file_response_proto.issenderacceptedornot()
        );

    return file_response;
}