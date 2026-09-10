//
// Created by VijayNSadashiva on 06-08-2026.
//

#include "ErrorConverter.h"

#include <iostream>

#include "PacketService/Packets/Error.h"
#include "PacketService/Proto/Error.pb.h"


ErrorProto::Error ErrorConverter::toProto(Error& error) {
    if (error.isInvalid()) {
        throw std::invalid_argument("Cannot convert invalid Error Data object to Proto.");
    }
    ErrorProto::Error error_proto;
    error_proto.set_packettype(PacketEnum::Error);
    error_proto.set_uniqueid(error.get_unique_id());
    error_proto.set_errordetails(error.get_error_details());
    return error_proto;
}

Error ErrorConverter::toPacket(ErrorProto::Error& error_proto) {
    if (error_proto.uniqueid().empty()) {
        throw std::invalid_argument("Cannot convert invalid Error Proto to Error Data object.");
    }

    Error error(
        error_proto.uniqueid(),
        error_proto.errordetails()
        );
    return error;
}