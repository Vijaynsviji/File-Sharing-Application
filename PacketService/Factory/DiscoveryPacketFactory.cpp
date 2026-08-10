//
// Created by VijayNSadashiva on 10-08-2026.
//


#include "DiscoveryPacketFactory.h"

#include <iostream>
#include <string>

#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Packets/Discovery.h"
#include "PacketService/Proto/Discovery.pb.h"


Discovery DiscoveryPacketFactory::createPacket(
    std::string &uniqueId,
    Device &device
) {
    if (uniqueId.empty() || device.isInvalid()) {
        throw std::invalid_argument("Cannot Create Discovery Packet.");
    }
    Discovery discovery(
        uniqueId,
        device
    );
    return discovery;
}


discoverProto::Discovery DiscoveryPacketFactory::createProto(
    std::string& uniqueId,
    Device& device
) {
    if (uniqueId.empty() || device.isInvalid()) {
        throw std::invalid_argument("Cannot Create Discovery Proto.");
    }

    discoverProto::Discovery discoveryProto;
    auto deviceProto = DeviceConverter::toProto(device);
    if (!deviceProto.has_value()) {
        throw std::runtime_error("Not able to convert device to proto.");
    }

    *discoveryProto.mutable_device() = *deviceProto;
    discoveryProto.set_uniqueid(uniqueId);
    discoveryProto.set_packettype(PacketEnum::Discovery);

    return discoveryProto;
}