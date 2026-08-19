//
// Created by VijayNSadashiva on 19-08-2026.
//

// #ifndef FILESHAREBACKEND_FILESERVICE_H
// #define FILESHAREBACKEND_FILESERVICE_H
//
// #endif //FILESHAREBACKEND_FILESERVICE_H


#pragma once
#include <psdk_inc/_socket_types.h>
#include <vector>
#include<string>
#include "PacketService/Factory/FileRequestPacketFactory.h"
#include "PacketService/Packets/Device.h"
#include "PacketService/Packets/FileMetadata.h"

class FileService {
public:
    static void fileRequest(SOCKET& socket, Device& device);

    static void fileResponse(SOCKET& socket,std::vector<FileMetadata>& fileMetadataArray,bool isRequestAcceptedOrNot);

    static void transferComplete(SOCKET& socket, std::string& uniqueId);

    static void sendError(SOCKET& socket,std::string uniqueId,std::string errorDetails);
};
