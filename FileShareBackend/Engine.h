//
// Created by VijayNSadashiva on 07-09-2026.
//

// #ifndef FILESHAREBACKEND_ENGINE_H
// #define FILESHAREBACKEND_ENGINE_H
//
// #endif //FILESHAREBACKEND_ENGINE_H



#pragma once
#include <nlohmann/json.hpp>
#include "DiscoveryService/DiscoveryService.h"
#include "EventService/EventEmitter.h"
#include "FileService/Services/FileReceiverService.h"
#include "FileService/Services/FileSenderService.h"
#include "ThreadPoolService/ThreadPool.h"



class Engine {
    DartEventEmitter eventEmitter;
    DiscoveryService discoveryService;
    FileSenderService fileSenderService;
    FileReceiverService fileReceiverService;
    ThreadPool threadPool;

public:
    Engine()
       : eventEmitter(),
        discoveryService(1024, 3125, 8085,eventEmitter),
         fileSenderService(eventEmitter),
         fileReceiverService(eventEmitter),
         threadPool(5)
    {
        // The constructor body is now clean and empty!
    }

    void startBroadCast();

    void startListening();

    void stopBroadCasting();

    void stopListening();

    void startTCPListening();

    void stopTCPListening();

    void sendFileRequest(std::string senderIPAddress);

    void sendFileResponse(std::string deviceId);
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

    void addUserSelectedFiles(const char* jsonString);

    void initialiseDartPortId(int dartPortId);

};
