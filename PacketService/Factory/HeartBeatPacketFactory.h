//
// Created by VijayNSadashiva on 10-08-2026.
//
//
// #ifndef FILESHAREBACKEND_HEARTBEATPACKETFACTORY_H
// #define FILESHAREBACKEND_HEARTBEATPACKETFACTORY_H
//
// #endif //FILESHAREBACKEND_HEARTBEATPACKETFACTORY_H

#pragma once
#include <iostream>

#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Packets/HeartBeat.h"
#include "PacketService/Proto/HeartBeat.pb.h"

class HeartBeatPacketFactory {
public:

    static HeartBeat createPacket(Device& device);

    static HearBeatProto::HeartBeat createProto(Device& device);

};
