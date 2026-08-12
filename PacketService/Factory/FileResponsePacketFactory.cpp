//
// Created by VijayNSadashiva on 12-08-2026.
//

#include "FileResponsePacketFactory.h"

#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Converters/FileMetadataConverter.h"
#include "PacketService/Packets/FileResponse.h"
#include "PacketService/Proto/FileResponse.pb.h"


FileResponse FileResponsePacketFactory::createPacket(
    FileMetadata& fileMetadata,
    bool isSenderAccepted
) {
    if (fileMetadata.isInvalid()) {
        throw std::invalid_argument("Cannot Create File Response Packet");
    }

    FileResponse fileResponse(
        fileMetadata,
        isSenderAccepted
    );

    return fileResponse;
}

FileResponseProto::FileResponse FileResponsePacketFactory::createProto(
    FileMetadata& fileMetadata,
   bool isSenderAccepted
) {
    if (fileMetadata.isInvalid()) {
        throw std::invalid_argument("Cannot Create File Response Proto");
    }

    FileResponseProto::FileResponse fileResponseProto;
    auto deviceProto = DeviceConverter::toProto(device);
    if (!deviceProto.has_value()) {
        throw std::runtime_error("Not able to convert device to proto.");
    }

    auto fileMetaDataProto = FileMetadataConverter::toProto(fileMetadata);


    *fileResponseProto.mutable_device() = *deviceProto;
    *fileResponseProto.mutable_filemetdata() = *fileMetaDataProto;
    fileResponseProto.set_packettype(PacketEnum::FileResponse);
    fileResponseProto.set_issenderacceptedornot(isSenderAccepted);


    return fileResponseProto;
}