//
// Created by VijayNSadashiva on 12-08-2026.
//
//
// #ifndef FILESHAREBACKEND_TRANSFERCOMPLETEPACKETFACTORY_H
// #define FILESHAREBACKEND_TRANSFERCOMPLETEPACKETFACTORY_H
//
// #endif //FILESHAREBACKEND_TRANSFERCOMPLETEPACKETFACTORY_H

#pragma once
#include<string>
#include "PacketService/Packets/TransferComplete.h"
#include "PacketService/Proto/TransferComplete.pb.h"


class TransferCompletePacketFactory {
public:

    static TransferComplete createPacket(
        std::string& uniqueId
    );

    static TransferCompleteProto::TransferComplete createProto(
        std::string& uniqueId
    );
};
