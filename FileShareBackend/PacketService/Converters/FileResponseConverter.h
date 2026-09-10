//
// Created by VijayNSadashiva on 04-08-2026.
//

// #ifndef FILESHAREBACKEND_FILERESPONSECONVERTER_H
// #define FILESHAREBACKEND_FILERESPONSECONVERTER_H
//
// #endif //FILESHAREBACKEND_FILERESPONSECONVERTER_H


#pragma once
#include <iostream>

#include "FileMetadataConverter.h"
#include "PacketService/Packets/FileResponse.h"
#include "PacketService/Proto/FileResponse.pb.h"


class FileResponseConverter {
public:

    static FileResponseProto::FileResponse toProto(const FileResponse& file_response);

    static FileResponse toPacket(const FileResponseProto::FileResponse& file_response_proto);
};
