//
// Created by VijayNSadashiva on 29-07-2026.
//

#include <iostream>
#include <stdexcept>

#include "DeviceConverter.h"
#include "DiscoveryConverter.h"
#include "PacketService/Packets/Discovery.h"
#include "PacketService/Proto/Discovery.pb.h"
#include "PacketService/Proto/PacketEnum.pb.h"


discoverProto::Discovery DiscoveryConverter::toProto(Discovery discovery) {
    if (discovery.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid Discovery object to Proto.");
    }

    discoverProto::Discovery discoveryProto;
    discoveryProto.set_packettype(PacketEnum::Discovery);
    discoveryProto.set_uniqueid(discovery.get_unique_id());

    auto deviceProto = DeviceConverter::toProto(discovery.get_device());
    if (!deviceProto.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Discovery Device object to Device Proto.");
    }

    if (deviceProto) {
        *discoveryProto.mutable_device() = *deviceProto;
    }

    // discoveryProto.set_allocated_device(deviceProto);
    return discoveryProto;
}

Discovery DiscoveryConverter::toPacket(discoverProto::Discovery discoveryProto) {
    std::string uniqueId = discoveryProto.uniqueid();

    auto device = DeviceConverter::toDevice(discoveryProto.device());

    if (!device.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Discovery Device Proto to Device.");
    }

    Discovery discovery(uniqueId,device.value());
    return discovery;
}
