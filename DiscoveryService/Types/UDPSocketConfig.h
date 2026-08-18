//
// Created by VijayNSadashiva on 15-08-2026.
//

// #ifndef FILESHAREBACKEND_SOCKETCONFIG_H
// #define FILESHAREBACKEND_SOCKETCONFIG_H
//
// #endif //FILESHAREBACKEND_SOCKETCONFIG_H

#pragma once
#include<string>


struct UDPSocketConfig {
    int portValue;
    std::string listenIPAddress = "127.0.0.1";
    bool isBroadCastEnabled = false;
    bool isListenBroadCastMessage = false;
};