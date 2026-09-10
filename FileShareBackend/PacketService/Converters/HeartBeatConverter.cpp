//
// Created by VijayNSadashiva on 29-07-2026.
//


#include <iostream>

#include "HeatBeatConverter.h"
#include "PacketService/Packets/HeartBeat.h"
#include "PacketService/Proto/HeartBeat.pb.h"

HearBeatProto::HeartBeat  HeartBeatConverter::toProto(const HeartBeat& heart_beat) {
    if (heart_beat.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid Heart Beat object to Proto.");
    }
    HearBeatProto::HeartBeat heart_beat_proto;

    heart_beat_proto.set_packettype(PacketEnum::HeartBeat);

    auto deviceProto = DeviceConverter::toProto(heart_beat.get_device());
    if (!deviceProto) {
        throw std::invalid_argument("Cannot convert invalid Heart Beat Device object to Device Proto.");
    }

    if (deviceProto) {
        *heart_beat_proto.mutable_device() = *deviceProto;
    }

    // heart_beat_proto.set_allocated_device(deviceProto.value())
    return heart_beat_proto;
}


HeartBeat HeartBeatConverter::toPacket(const HearBeatProto::HeartBeat& heart_beat_proto) {
    auto device = DeviceConverter::toDevice(heart_beat_proto.device());

    if (device.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Heart Beat Device Proto to Device.");
    }

    HeartBeat heart_beat(device.value());

    return heart_beat;
}