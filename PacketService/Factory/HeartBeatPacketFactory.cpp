//
// Created by VijayNSadashiva on 10-08-2026.
//

#include "HeartBeatPacketFactory.h"

#include <iostream>

#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Packets/HeartBeat.h"
#include "PacketService/Proto/HeartBeat.pb.h"


HeartBeat HeartBeatPacketFactory::createPacket(Device& device) {
    if (device.isInvalid()) {
        throw std::invalid_argument("Cannot Create HeartBeat Packet.");
    }

    HeartBeat hearBeat(device);
    return hearBeat;
}

HearBeatProto::HeartBeat HeartBeatPacketFactory::createProto(Device& device) {
    if (device.isInvalid()) {
        throw std::invalid_argument("Cannot Create HeartBeat Proto.");
    }

    HearBeatProto::HeartBeat heartBeatProto;
    auto deviceProto = DeviceConverter::toProto(device);
    if (!deviceProto.has_value()) {
        throw std::runtime_error("Not able to convert device to proto.");
    }

    *heartBeatProto.mutable_device() = *deviceProto;
    heartBeatProto.set_packettype(PacketEnum::HeartBeat);
    return  heartBeatProto;
}
