//
// Created by VijayNSadashiva on 29-07-2026.
//

// #ifndef FILESHAREBACKEND_DEVICECONVERTER_H
// #define FILESHAREBACKEND_DEVICECONVERTER_H
//
// #endif //FILESHAREBACKEND_DEVICECONVERTER_H

#pragma once

#include <iostream>
#include <optional>
#include <string>

#include "PacketService/Packets/Device.h"
#include "PacketService/Proto/DeviceProto.pb.h"


class DeviceConverter {
public:

    static std::optional<DeviceProto::Device> toProto(const Device& device);

    static std::optional<Device> toDevice(const DeviceProto::Device& deviceProto);

};
