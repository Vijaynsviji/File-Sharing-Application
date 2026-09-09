//
// Created by VijayNSadashiva on 24-08-2026.
//
//
// #ifndef FILESHAREBACKEND_UNIVERSALSOCKET_H
// #define FILESHAREBACKEND_UNIVERSALSOCKET_H
//
// #endif //FILESHAREBACKEND_UNIVERSALSOCKET_H


#pragma once

#ifdef _WIN32
    // 🪟 If building for Windows, use Windows headers
    #ifndef WIN32_LEAN_AND_MEAN
    #define WIN32_LEAN_AND_MEAN
    #endif

    #include <windows.h>   // <-- Pulls in UINT_PTR and other base types
    #include <winsock2.h>
    #include <ws2tcpip.h>

    // Tell Windows to link the networking library
    #pragma comment(lib, "Ws2_32.lib")

    // Create universal shortcuts
    typedef SOCKET SocketType;
#define CROSS_CLOSE(s) closesocket
#define CROSS_GET_ERROR() WSAGetLastError()
#else
// 🤖 If building for Android, use Android headers
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>
    #include <unistd.h>
    #include <errno.h>

    // Create matching shortcuts so Android understands Windows terms
    typedef int SocketType;
    #define CROSS_CLOSE(s) close(s)
    #define CROSS_GET_ERROR() errno
    #define INVALID_SOCKET -1
    #define SOCKET_ERROR -1
#endif

// 🛠️ Universal Network Startup Helper
inline bool initNetwork() {
#ifdef _WIN32
    WSADATA wsaData;
    return WSAStartup(MAKEWORD(2, 2), &wsaData) == 0;
#else
    return true; // Android doesn't need startup!
#endif
}

// 🛠️ Universal Network Cleanup Helper
inline void cleanupNetwork() {
#ifdef _WIN32
    WSACleanup();
// Android doesn't need cleanup!
#endif
}
