//
// Created by VijayNSadashiva on 15-08-2026.
//

// #ifndef FILESHAREBACKEND_SOCKETVALUE_H
// #define FILESHAREBACKEND_SOCKETVALUE_H
//
// #endif //FILESHAREBACKEND_SOCKETVALUE_H

#pragma once
#include "UniversalSocket.h"




struct SocketValue {
    SocketType socket;
    sockaddr_in address;
};