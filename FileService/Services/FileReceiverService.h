//
// Created by VijayNSadashiva on 20-08-2026.
//

// #ifndef FILESHAREBACKEND_FILERECEIVERSERVICE_H
// #define FILESHAREBACKEND_FILERECEIVERSERVICE_H
//
// #endif //FILESHAREBACKEND_FILERECEIVERSERVICE_H


#pragma once
#include <stdexcept>
#include <vector>
#include<string>
#include "UniversalSocket.h"


#include "FileSendPacketService.h"
#include "DiscoveryService/Services/TCPService.h"
#include "PacketService/Packets/FileMetadata.h"
#include "Utils/utils.h"

class FileReceiverService {
    SocketType receiverSocket;
    std::vector<FileMetadata> allFileMetadata;
    Device receiverDevice;
public:

    SocketType receiver_socket() const {
        return receiverSocket;
    }

    void set_receiver_socket(SocketType receiver_socket) {
        receiverSocket = receiver_socket;
    }

    std::vector<FileMetadata> all_file_metadata() const {
        return allFileMetadata;
    }

    void set_all_file_metadata(std::vector<FileMetadata> all_file_metadata) {
        allFileMetadata = all_file_metadata;
    }

    Device receiver_device() const {
        return receiverDevice;
    }

    void set_receiver_device(Device receiver_device) {
        receiverDevice = receiver_device;
    }

    void handleSendFileRequestPacket(std::string& senderIPAddress);

    void handleErrorDetails(SocketType& socket,std::string& errorDetails);
};
