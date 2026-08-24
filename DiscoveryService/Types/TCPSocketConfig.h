//
// Created by VijayNSadashiva on 18-08-2026.
//

// #ifndef FILESHAREBACKEND_TCPSOCKETCONFIG_H
// #define FILESHAREBACKEND_TCPSOCKETCONFIG_H
//
// #endif //FILESHAREBACKEND_TCPSOCKETCONFIG_H
#pragma once
#include <string>


struct TCPServerSocketConfig {
    int portValue;
};

struct TCPClientSocketConfig {
    int portValue;
    std::string listenIPAddress = "127.0.0.1";
};