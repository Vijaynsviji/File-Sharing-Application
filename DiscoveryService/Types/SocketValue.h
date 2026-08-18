//
// Created by VijayNSadashiva on 15-08-2026.
//

// #ifndef FILESHAREBACKEND_SOCKETVALUE_H
// #define FILESHAREBACKEND_SOCKETVALUE_H
//
// #endif //FILESHAREBACKEND_SOCKETVALUE_H

#pragma once
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "Ws2_32.lib")


struct SocketValue {
    SOCKET socket;
    sockaddr_in address;
};