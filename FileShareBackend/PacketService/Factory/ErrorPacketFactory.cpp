//
// Created by VijayNSadashiva on 12-08-2026.
//

#include "ErrorPacketFactory.h"

#include<string>
#include "PacketService/Packets/Error.h"
#include "PacketService/Proto/Error.pb.h"

Error ErrorPacketFactory::createPacket(
    std::string& uniqueId,
    std::string& errorDetails
) {

    if (uniqueId.empty() || errorDetails.empty()) {
        throw std::invalid_argument("Cannot Create Error Packet.");
    }

    Error error(
        uniqueId,
        errorDetails
    );
    return error;
}

ErrorProto::Error ErrorPacketFactory::createProto(
    std::string& uniqueId,
    std::string& errorDetails
) {
    if (uniqueId.empty() || errorDetails.empty()) {
        throw std::invalid_argument("Cannot Create Error Proto.");
    }

    ErrorProto::Error errorProto;
    errorProto.set_packettype(PacketEnum::Error);
    errorProto.set_uniqueid(uniqueId);
    errorProto.set_errordetails(errorDetails);
    return errorProto;
}