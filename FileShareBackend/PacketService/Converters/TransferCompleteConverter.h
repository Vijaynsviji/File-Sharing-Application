//
// Created by VijayNSadashiva on 06-08-2026.
//
//
// #ifndef FILESHAREBACKEND_TRANSFERCOMPLETECONVERTER_H
// #define FILESHAREBACKEND_TRANSFERCOMPLETECONVERTER_H
//
// #endif //FILESHAREBACKEND_TRANSFERCOMPLETECONVERTER_H

#pragma once
#include <iostream>

#include "PacketService/Packets/TransferComplete.h"
#include "PacketService/Proto/TransferComplete.pb.h"

class TransferCompleteConverter {
public:
    static TransferCompleteProto::TransferComplete toProto(TransferComplete& transfer_complete);

    static TransferComplete toPacket(TransferCompleteProto::TransferComplete& transfer_complete_proto);
};
