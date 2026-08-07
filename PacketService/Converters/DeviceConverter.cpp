//
// Created by VijayNSadashiva on 29-07-2026.
//

#include "DeviceConverter.h"

#include <iostream>
#include <optional>
#include <string>


std::optional<DeviceProto::Device> DeviceConverter::toProto(const Device& device) {
    if (device.isInvalid()) {
        return std::nullopt;
    }
    DeviceProto::Device deviceProto;

    deviceProto.set_devicetype(device.get_device_type());
    deviceProto.set_devicename(device.get_device_name());
    deviceProto.set_deviceid(device.get_device_id());

    return deviceProto;
}

std::optional<Device> DeviceConverter::toDevice(const DeviceProto::Device& deviceProto) {
    // if (deviceProto.devicename()) {
    //     return std::nullopt;
    // }

    std::string deviceName = deviceProto.devicename();
    std::string deviceType = deviceProto.devicetype();
    std::string deviceid = deviceProto.deviceid();

    if (deviceName.empty() || deviceType.empty() || deviceid.empty()) {
        return std::nullopt;;
    }

    Device device(deviceid,deviceName,deviceType);
    return device;
}