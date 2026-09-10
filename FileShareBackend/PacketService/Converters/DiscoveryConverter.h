//
// Created by VijayNSadashiva on 27-07-2026.
//


// #ifndef FILESHAREBACKEND_DISCOVERYCONVERTER_H
//
// #define FILESHAREBACKEND_DISCOVERYCONVERTER_H

#pragma once
#include <iostream>
#include <string>

#include "DeviceConverter.h"
#include "PacketService/Packets/Discovery.h"
#include "PacketService/Proto/Discovery.pb.h"
#include "PacketService/Proto/PacketEnum.pb.h"


class DiscoveryConverter {

public:

    static discoveryProto::Discovery toProto(Discovery discovery);

    static Discovery toPacket(discoveryProto::Discovery discoveryProto);


};
