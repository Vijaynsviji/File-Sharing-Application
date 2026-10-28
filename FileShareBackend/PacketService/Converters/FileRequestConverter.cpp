//
// Created by VijayNSadashiva on 02-08-2026.
//

#include <iostream>
#include <optional>

#include "FileRequestConverter.h"
#include "DeviceConverter.h"
#include "UserConverter.h"
#include "PacketService/Packets/FileRequest.h"
#include "PacketService/Proto/FileRequest.pb.h"


FileRequestProto::FileRequest FileRequestConverter::toProto(FileRequest& file_request) {
    if (file_request.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid File Request Data object to Proto.");
    }

    FileRequestProto::FileRequest file_request_proto;
    Device device = file_request.get_device();
    std::optional<DeviceProto::Device> deviceProto = DeviceConverter::toProto(device);

    if (!deviceProto.has_value()) {
        throw std::invalid_argument("Cannot convert invalid File Request Device object to Device Proto.");
    }

    auto userProto = UserConverter::toProto(file_request.get_user());
    if (!userProto.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Discovery User object to User Proto.");
    }

    *file_request_proto.mutable_user() = std::move(userProto.value());


    *file_request_proto.mutable_device() = std::move(deviceProto.value());

    file_request_proto.set_uniqueid(file_request.get_unique_id());
    file_request_proto.set_packettype(PacketEnum::FileRequest);

    return file_request_proto;
}

FileRequest FileRequestConverter::toPacket(FileRequestProto::FileRequest& file_request_proto) {

    std::string uniqueId = file_request_proto.uniqueid();
    DeviceProto::Device deviceProto= file_request_proto.device();

    auto device = DeviceConverter::toDevice(deviceProto);
    if (!device.has_value()) {
        throw std::invalid_argument("Cannot convert invalid File Request Device Proto to Device.");
    }

    std::cout<<file_request_proto.user().DebugString()<<std::endl;
    auto user = UserConverter::toUser(file_request_proto.user());
    if (!user.has_value()) {
        throw std::invalid_argument("Cannot convert invalid File Request User Proto to User.");
    }

    FileRequest file_request(uniqueId,device.value(),user.value());
    return file_request;
}