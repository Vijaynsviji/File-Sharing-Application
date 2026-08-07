//
// Created by VijayNSadashiva on 06-08-2026.
//


#include "TransferCompleteConverter.h"

#include <iostream>

#include "PacketService/Packets/TransferComplete.h"
#include "PacketService/Proto/TransferComplete.pb.h"


TransferCompleteProto::TransferComplete TransferCompleteConverter::toProto(TransferComplete& transfer_complete) {
    if (transfer_complete.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid TransferComplete chunk Data object to Proto.");
    }

    TransferCompleteProto::TransferComplete transfer_complete_proto;
    transfer_complete_proto.set_packettype(PacketEnum::TransferComplete);
    transfer_complete_proto.set_uniqueid(transfer_complete.get_unique_id());

    return transfer_complete_proto;
}

TransferComplete TransferCompleteConverter::toPacket(TransferCompleteProto::TransferComplete& transfer_complete_proto) {
    if (transfer_complete_proto.uniqueid() == "") {
        throw std::invalid_argument("Cannot convert invalid TransferComplete proto to Packet.");
    }
    TransferComplete transfer_complete(
        transfer_complete_proto.uniqueid()
        );
    return transfer_complete;
}
