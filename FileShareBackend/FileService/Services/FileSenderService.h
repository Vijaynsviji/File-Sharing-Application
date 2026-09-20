//
// Created by VijayNSadashiva on 20-08-2026.
//

// #ifndef FILESHAREBACKEND_FILESENDERSERVICE_H
// #define FILESHAREBACKEND_FILESENDERSERVICE_H
//
// #endif //FILESHAREBACKEND_FILESENDERSERVICE_H


#pragma once
#include <vector>
#include <stdexcept>
#include <vector>
#include<string>
#include "UniversalSocket.h"

#include "FileSendPacketService.h"
#include "DiscoveryService/Models/OnlineDevice.h"
#include "EventService/EventEmitter.h"
#include "FileService/Models/File.h"

class FileSenderService {
    DartEventEmitter& eventEmitter;
    std::vector<OnlineDevice> acceptedDevices;
    std::vector<File> selectedFiles;
public:
    FileSenderService(DartEventEmitter& eventEmitter) : eventEmitter(eventEmitter) {
    }

    FileSenderService(std::vector<OnlineDevice>& devices,std::vector<File>& files,DartEventEmitter& eventEmitter )
        :acceptedDevices(devices),
        selectedFiles(files),
        eventEmitter(eventEmitter)
    {}

    std::vector<OnlineDevice> accepted_devices() const {
        return acceptedDevices;
    }

    void set_accepted_devices(std::vector<OnlineDevice> accepted_devices) {
        acceptedDevices = accepted_devices;
    }

    std::vector<File> selected_files() const {
        return selectedFiles;
    }

    void set_selected_files(std::vector<File> selected_files) {
        selectedFiles = selected_files;
    }

    void handleFileResponsePacket(OnlineDevice& online_device,bool isRequestAcceptedOrNot);

    void handleTransferComplete(SocketType& socket,Device& senderDevice);

    void handleErrorDetails(SocketType& socket,Device& device,std::string& errorDetails);
};
