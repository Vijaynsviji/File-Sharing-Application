//
// Created by VijayNSadashiva on 20-08-2026.
//

#include "FileSenderService.h"

#include <stdexcept>
#include <vector>
#include<string>
#include "UniversalSocket.h"

#include "FileSendPacketService.h"
#include "DiscoveryService/Models/OnlineDevice.h"
#include "FileService/Models/File.h"


void FileSenderService::handleFileResponsePacket(OnlineDevice& online_device,bool isRequestAcceptedOrNot) {
    SocketType socket = online_device.getDeviceSocket();
    if (socket == INVALID_SOCKET) {
        throw std::invalid_argument("Socket is Not Valid, Not able to Send File Response Packet");
    }


    std::vector<FileMetadata> fileMetadataArray;
    for (auto file:selectedFiles) {
        fileMetadataArray.push_back(file.get_file_metadata());
    }
    FileSendPacketService::fileResponse(socket, fileMetadataArray,isRequestAcceptedOrNot);
    acceptedDevices.push_back(online_device);
}


void FileSenderService::handleTransferComplete(SocketType& socket,Device& senderDevice) {
    if (socket == INVALID_SOCKET) {
        throw std::invalid_argument("Socket is Not Valid, Not able to Send Transfer Complete Packet");
    }
    std::string uniqueId = senderDevice.get_device_id();

    if (uniqueId.empty()) {
        throw std::runtime_error("Device Id is Not Present, Not able to Send Transfer Complete Packet");
    }

    FileSendPacketService::transferComplete(socket,uniqueId);
}

void FileSenderService::handleErrorDetails(SocketType& socket,Device& senderDevice,std::string& errorDetails) {
    if (socket == INVALID_SOCKET) {
        throw std::invalid_argument("Socket is Not Valid, Not able to Send Error Details Packet");
    }
    std::string uniqueId = senderDevice.get_device_id();

    if (uniqueId.empty()) {
        throw std::runtime_error("Device Id is Not Present, Not able to Send Error Details Packet");
    }

    FileSendPacketService::sendError(socket,uniqueId,errorDetails);
}