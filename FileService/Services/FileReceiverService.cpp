//
// Created by VijayNSadashiva on 24-08-2026.
//


#include "FileReceiverService.h"

#include <stdexcept>
#include <vector>
#include<string>
#include "UniversalSocket.h"


#include "FileSendPacketService.h"
#include "DiscoveryService/Services/TCPService.h"
#include "PacketService/Packets/FileMetadata.h"
#include "Utils/utils.h"


void FileReceiverService::handleSendFileRequestPacket(std::string& senderIPAddress) {
    if (senderIPAddress.empty()) {
        throw std::invalid_argument("Sender IP is Empty, Not able to Send File Request Packet");
    }


    int senderTCPPort = 9082;
    TCPClientSocketConfig tcpConfig(
        senderTCPPort,
        senderIPAddress
    );
    SocketValue receiverSocket = TCPService::createClientSocket(tcpConfig);
    std::string deviceId = Utility::generateGUID();

    //TODO 1: this Device will taken from our Android Application
    Device receiverDevice = Device(
        deviceId,
        "Temp Name",
        "Android"
    );
    set_receiver_device(receiverDevice);
    FileSendPacketService::fileRequest(receiverSocket.socket,receiverDevice);

}

void FileReceiverService::handleErrorDetails(SocketType& socket,std::string& errorDetails) {
    if (socket == INVALID_SOCKET) {
        throw std::invalid_argument("Socket is Invalid, Not Able to Send Error Details");
    }

    if (errorDetails.empty()) {
        throw std::invalid_argument("Error Details is Empty, Not Able to Send Error Details");
    }


    std::string uniqueId = receiverDevice.get_device_id();

    if (uniqueId.empty()) {
        throw std::runtime_error("Device Id is Not Present, Not able to Send Error Details");
    }


    FileSendPacketService::sendError(socket,uniqueId,errorDetails);
}