//
// Created by VijayNSadashiva on 15-08-2026.
//

// #ifndef FILESHAREBACKEND_TCPSERVICE_H
// #define FILESHAREBACKEND_TCPSERVICE_H
//
// #endif //FILESHAREBACKEND_TCPSERVICE_H

#pragma once
#include <stdexcept>
#include "UniversalSocket.h"


#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/TCPSocketConfig.h"




class TCPService {
public:
    static SocketValue createServerSocket(TCPServerSocketConfig& config);
    static SocketValue createClientSocket(TCPClientSocketConfig& config);
};