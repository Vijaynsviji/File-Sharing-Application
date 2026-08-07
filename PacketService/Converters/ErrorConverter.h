//
// Created by VijayNSadashiva on 06-08-2026.
//
//
// #ifndef FILESHAREBACKEND_ERRORCONVERTER_H
// #define FILESHAREBACKEND_ERRORCONVERTER_H
//
// #endif //FILESHAREBACKEND_ERRORCONVERTER_H


#pragma once
#include <iostream>

#include "PacketService/Packets/Error.h"
#include "PacketService/Proto/Error.pb.h"

class ErrorConverter {
public:
    static ErrorProto::Error toProto(Error& error);

    static Error toPacket(ErrorProto::Error& error_proto);
};
