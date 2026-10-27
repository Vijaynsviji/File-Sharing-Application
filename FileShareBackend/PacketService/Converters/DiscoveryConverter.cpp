//
// Created by VijayNSadashiva on 29-07-2026.
//

#include <iostream>
#include <stdexcept>

#include "DeviceConverter.h"
#include "DiscoveryConverter.h"

#include "UserConverter.h"
#include "PacketService/Packets/Discovery.h"
#include "PacketService/Proto/Discovery.pb.h"
#include "PacketService/Proto/PacketEnum.pb.h"


discoveryProto::Discovery DiscoveryConverter::toProto(Discovery discovery) {
    if (discovery.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid Discovery object to Proto.");
    }

    discoveryProto::Discovery discoveryProto;
    discoveryProto.set_packettype(PacketEnum::Discovery);
    discoveryProto.set_uniqueid(discovery.get_unique_id());

    auto deviceProto = DeviceConverter::toProto(discovery.get_device());
    if (!deviceProto.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Discovery Device object to Device Proto.");
    }

    auto userProto = UserConverter::toProto(discovery.get_user());
    if (!userProto.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Discovery User object to User Proto.");
    }

    if (userProto) {
        *discoveryProto.mutable_user() = *userProto;
    }

    // discoveryProto.set_allocated_device(deviceProto);
    return discoveryProto;
}

Discovery DiscoveryConverter::toPacket(discoveryProto::Discovery discoveryProto) {
    std::string uniqueId = discoveryProto.uniqueid();

    auto device = DeviceConverter::toDevice(discoveryProto.device());

    if (!device.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Discovery Device Proto to Device.");
    }

    auto user = UserConverter::toUser(discoveryProto.user());
    if (!user.has_value()) {
        throw std::invalid_argument("Cannot convert invalid Discovery User Proto to User.");
    }

    Discovery discovery(uniqueId,device.value(),user.value());
    return discovery;
}
