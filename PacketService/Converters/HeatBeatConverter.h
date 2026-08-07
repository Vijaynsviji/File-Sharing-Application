//
// Created by VijayNSadashiva on 29-07-2026.
//

// #ifndef FILESHAREBACKEND_HEATBEATCONVERTER_H
// #define FILESHAREBACKEND_HEATBEATCONVERTER_H
//
// #endif //FILESHAREBACKEND_HEATBEATCONVERTER_H

#pragma once

#include <iostream>

#include "../Packets/HeartBeat.h"
#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Proto/HeartBeat.pb.h"


class HeartBeatConverter {
    DeviceConverter device_converter;
public:

    static HearBeatProto::HeartBeat toProto(const HeartBeat& heart_beat);

    static HeartBeat toPacket(const HearBeatProto::HeartBeat& heart_beat_proto);

};
