//
// Created by VijayNSadashiva on 01-08-2026.
//
//
// #ifndef FILESHAREBACKEND_FILEREQUESTCONVERTER_H
// #define FILESHAREBACKEND_FILEREQUESTCONVERTER_H
//
// #endif //FILESHAREBACKEND_FILEREQUESTCONVERTER_H

#pragma once

#include <iostream>
#include <optional>

#include "DeviceConverter.h"
#include "PacketService/Packets/FileRequest.h"
#include "PacketService/Proto/FileRequest.pb.h"

class FileRequestConverter {
public:
    static FileRequestProto::FileRequest toProto(FileRequest& file_request);

    static FileRequest toPacket(FileRequestProto::FileRequest& file_request_proto);
};
