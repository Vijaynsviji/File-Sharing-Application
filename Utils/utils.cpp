//
// Created by VijayNSadashiva on 21-08-2026.
//


#include "utils.h"
#include <string>

#include "UUID/uuid_v4.h"

std::string Utility::generateGUID() {
    UUIDv4::UUIDGenerator<std::mt19937_64> uuidGenerator;
    UUIDv4::UUID uuid = uuidGenerator.getUUID();
    return uuid.str();
}
