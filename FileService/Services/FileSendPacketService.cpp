//
// Created by VijayNSadashiva on 19-08-2026.
//

#include "FileSendPacketService.h"

#include <psdk_inc/_socket_types.h>
#include <stdexcept>
#include <vector>
#include<string>
#include "UniversalSocket.h"

#include "PacketService/Factory/ErrorPacketFactory.h"
#include "PacketService/Factory/FileRequestPacketFactory.h"
#include "PacketService/Factory/FileResponsePacketFactory.h"
#include "PacketService/Factory/TransferCompletePacketFactory.h"
#include "PacketService/Packets/Device.h"
#include "PacketService/Packets/FileMetadata.h"
#include "PacketService/Proto/Error.pb.h"
#include "PacketService/Proto/FileResponse.pb.h"
#include "PacketService/Proto/TransferComplete.pb.h"



void FileSendPacketService::fileRequest(SocketType& socket, Device& device) {
        if (device.isInvalid()) {
            throw std::invalid_argument("Cannot send invalid File Request.");
        }
        std::string uniqueId = device.get_device_id();
        FileRequestProto::FileRequest fileRequestProto = FileRequestPacketFactory::createProto(uniqueId,device);
        std::string serialisedFileRequestProto;
        if (!fileRequestProto.SerializeToString(&serialisedFileRequestProto)) {
            throw std::runtime_error("Not able to Serialise File Request Proto");
            return;
        }
        int sendResult = send(socket, serialisedFileRequestProto.data(), static_cast<int>(serialisedFileRequestProto.size()), 0);
        if (sendResult == SOCKET_ERROR) {
            throw std::runtime_error("Not able to send File Request Payload");
            return;
        }
    }

void FileSendPacketService::fileResponse(SocketType& socket,std::vector<FileMetadata>& fileMetadataArray,bool isRequestAcceptedOrNot) {
        FileResponseProto::FileResponse fileResponseProto = FileResponsePacketFactory::createProto(fileMetadataArray,isRequestAcceptedOrNot);
        std::string serialisedFileResponseProto;
        if (!fileResponseProto.SerializeToString(&serialisedFileResponseProto)) {
            throw std::runtime_error("Not able to Serialise File Response Proto");
        }

        int sendResult = send(socket, serialisedFileResponseProto.data(),static_cast<int>(serialisedFileResponseProto.size()),0);
        if (sendResult == SOCKET_ERROR) {
            throw std::runtime_error("Not able to send File Response Payload");
        }
    }

void FileSendPacketService::transferComplete(SocketType& socket, std::string& uniqueId) {
        if (uniqueId.empty()) {
            throw std::runtime_error("Cannot Send Transfer Complete Packet");
        }

        TransferCompleteProto::TransferComplete transferCompleteProto = TransferCompletePacketFactory::createProto(uniqueId);
        std::string serialisedTranferCompleteProto;
        if (!transferCompleteProto.SerializeToString(&serialisedTranferCompleteProto)) {
            throw std::runtime_error("Not able to Serialise the Transfer Complete Proto");
        }

        int sendResult = send(socket, serialisedTranferCompleteProto.data(),static_cast<int>(serialisedTranferCompleteProto.size()),0);
        if (sendResult == SOCKET_ERROR) {
            throw std::runtime_error("Not able to send Transfer Complete Payload");
        }

    }

void FileSendPacketService::sendError(SocketType& socket,std::string uniqueId,std::string errorDetails) {
        if (uniqueId.empty() || errorDetails.empty()) {
            throw std::invalid_argument("Cannot send error details.");
        }


        ErrorProto::Error errorProto = ErrorPacketFactory::createProto(uniqueId,errorDetails);
        std::string serialisedErrorProto;
        if (!errorProto.SerializeToString(&serialisedErrorProto)) {
            throw std::runtime_error("Not able to Serialise Error Proto");
        }

        int sendResult = send(socket, serialisedErrorProto.data(),static_cast<int>(serialisedErrorProto.size()),0);
        if (sendResult == SOCKET_ERROR) {
            throw std::runtime_error("Not able to send File Response Payload");
        }

    }