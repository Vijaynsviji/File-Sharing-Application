//
// Created by VijayNSadashiva on 12-08-2026.
//


#include "FileRequestPacketFactory.h"

#include<string>

#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Packets/FileRequest.h"
#include "PacketService/Proto/FileRequest.pb.h"


FileRequest FileRequestPacketFactory::createPacket(
        std::string& uniqueId,
        Device& device
    ) {
    if (uniqueId.empty() || device.isInvalid()) {
        throw std::invalid_argument("Cannot Create File Request Packet");
    }

    FileRequest fileRequest(
        uniqueId,
        device
    );

    return fileRequest;
}

FileRequestProto::FileRequest FileRequestPacketFactory::createProto(
    std::string& uniqueId,
    Device& device
) {
    if (uniqueId.empty() || device.isInvalid()) {
        throw std::invalid_argument("Cannot Create Discovery Proto.");
    }

    FileRequestProto::FileRequest fileRequestProto;
    auto deviceProto = DeviceConverter::toProto(device);
    if (!deviceProto.has_value()) {
        throw std::runtime_error("Not able to convert device to proto.");
    }

    *fileRequestProto.mutable_device() = *deviceProto;
    fileRequestProto.set_uniqueid(uniqueId);
    fileRequestProto.set_packettype(PacketEnum::FileRequest);
    return fileRequestProto;
}