//
// Created by VijayNSadashiva on 12-08-2026.
//


#include "TransferCompletePacketFactory.h"

#include<string>
#include "PacketService/Packets/TransferComplete.h"
#include "PacketService/Proto/TransferComplete.pb.h"

TransferComplete TransferCompletePacketFactory::createPacket(
    std::string& uniqueId
) {
    if (uniqueId.empty()) {
        throw std::invalid_argument("Cannot Create TransferComplete Packet.");
    }

    TransferComplete transferComplete(
        uniqueId
    );
    return transferComplete;
}

TransferCompleteProto::TransferComplete TransferCompletePacketFactory::createProto(
    std::string& uniqueId
) {
    if (uniqueId.empty()) {
        throw std::invalid_argument("Cannot Create TransferComplete Proto.");
    }

    TransferCompleteProto::TransferComplete transferCompleteProto;
    transferCompleteProto.set_packettype(PacketEnum::TransferComplete);
    transferCompleteProto.set_uniqueid(uniqueId);

    return transferCompleteProto;
}