//
// Created by VijayNSadashiva on 09-09-2026.
//

#include "Engine.h"
#include <nlohmann/json.hpp>
#include "DiscoveryService/DiscoveryService.h"
#include "FileService/Services/FileReceiverService.h"
#include "FileService/Services/FileSenderService.h"
#include "PacketService/Proto/Discovery.pb.h"
#include "ThreadPoolService/ThreadPool.h"



void Engine::startBroadCast() {
        try {
            std::function<void()> broadcastUDPCallBack = [this]() {
                discoveryService.startUdpBroadCasting();
            };
            Task broadCastTask("BroadCasting",broadcastUDPCallBack);
            threadPool.addTask(broadCastTask);

        }catch (std::exception& e) {
            std::cerr<<e.what()<<std::endl;
        }
    }

void Engine::startListening() {
    try {
        std::function<void()> listenUDPCallBack = [this]() {
            discoveryService.listenToBroadCast();
        };
        Task broadCastTask("BroadCastListening",listenUDPCallBack);
        threadPool.addTask(broadCastTask);

    }catch (std::exception& e) {
        std::cerr<<e.what()<<std::endl;
    }
}

void Engine::stopBroadCasting() {
    try {
        discoveryService.stopUdpBroadCasting();

    }catch (std::exception& e) {
        std::cerr<<e.what()<<std::endl;
    }
}

void Engine::stopListening() {
    try {
        discoveryService.stopUdpListening();
    }catch (std::exception&  e) {
        std::cerr<<e.what()<<std::endl;
    }
}

void Engine::startTCPListening() {
    try {
        discoveryService.DiscoveryRequestListner();
        std::function<void()> listenTCPCallBack = [this]() {
            discoveryService.DiscoveryRequestListner();
        };
        Task broadCastTask("TCPListening",listenTCPCallBack);
        threadPool.addTask(broadCastTask);

    }catch (std::exception&  e) {
        std::cerr<<e.what()<<std::endl;
    }
}

void Engine::stopTCPListening() {
    try {
        discoveryService.stopDiscoveryRequestLister();
    }catch (std::exception&  e) {
        std::cerr<<e.what()<<std::endl;
    }
}

void Engine::sendFileRequest(std::string senderIPAddress) {
    try {
        fileReceiverService.handleSendFileRequestPacket(senderIPAddress);
    }catch (std::exception& e) {
        std::cerr<<e.what()<<std::endl;
    }
}

void Engine::sendFileResponse(std::string deviceId) {
    try {

        auto onlineDevice = discoveryService.online_devices().at(deviceId);
        auto socketValue = onlineDevice.getDeviceSocket();
        fileSenderService.handleFileResponsePacket(onlineDevice,true);

    }catch (std::exception& e) {
        std::cerr<<e.what()<<std::endl;
    }
}
// void addAcceptedReceivers(std::string deviceId) {
//     try {
//         auto onlineDevicesMap = discoveryService.online_devices();
//         auto device = onlineDevicesMap.at(deviceId);
//
//
//
//     }catch (std::exception& e) {
//         std::cerr<<e.what()<<std::endl;
//     }
// }

void Engine::addUserSelectedFiles(const char* jsonString) {
    if (!jsonString) return;
    try {
        nlohmann::json parsedJson = nlohmann::json::parse(jsonString);
        std::vector<File> selectedFiles;
        for (const auto& item : parsedJson) {
            std::string filePath = item.value("filePath","");
            std::string fileName = item.value("fileName","");
            std::string fileType = item.value("fileType", "");
            long long fileSize = item.value("fileSize", 0);
            FileMetadata file_metadata(fileName,fileType,fileSize);
            File file(filePath,file_metadata);
            selectedFiles.push_back(file);
        }

        fileSenderService.set_selected_files(selectedFiles);

    }catch (std::exception& e) {
        std::cerr<<e.what()<<std::endl;
    }
}

void Engine::initialiseDartPortId(int dartPortId) {
    eventEmitter.initialize(dartPortId);
}


