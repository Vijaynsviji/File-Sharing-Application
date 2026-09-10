//
// Created by VijayNSadashiva on 15-08-2026.
// //
//
// #ifndef FILESHAREBACKEND_UDPSERVICE_H
// #define FILESHAREBACKEND_UDPSERVICE_H
//
// #endif //FILESHAREBACKEND_UDPSERVICE_H

#pragma once
#include<string>
#include <stdexcept>
#include "UniversalSocket.h"


#include "DiscoveryService/Types/SocketValue.h"
#include "DiscoveryService/Types/UDPSocketConfig.h"




class UDPService {
public:

    static SocketValue createSocket(
        UDPSocketConfig socketParams
    );



};