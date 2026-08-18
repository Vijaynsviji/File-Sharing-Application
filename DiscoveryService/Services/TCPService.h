//
// Created by VijayNSadashiva on 15-08-2026.
//

// #ifndef FILESHAREBACKEND_TCPSERVICE_H
// #define FILESHAREBACKEND_TCPSERVICE_H
//
// #endif //FILESHAREBACKEND_TCPSERVICE_H

#pragma once
#include <stdexcept>
#include <winsock2.h>
#include <ws2tcpip.h>

#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/TCPSocketConfig.h"
#pragma comment(lib, "Ws2_32.lib")



class TCPService {
public:
    static SocketValue createSocket(TCPSocketConfig& config);
};