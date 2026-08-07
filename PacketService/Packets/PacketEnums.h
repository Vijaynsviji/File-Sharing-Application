//
// Created by VijayNSadashiva on 01-08-2026.
//

// #ifndef FILESHAREBACKEND_PACKETENUMS_H
// #define FILESHAREBACKEND_PACKETENUMS_H
//
// #endif //FILESHAREBACKEND_PACKETENUMS_H

#pragma once

enum PacketTypes {
    kDiscovery,
    kHeartBeat,
    kFileMetadata,
    kFileRequest,
    kFileResponse,
    kFileChunk,
    kTransferComplete,
    kError
};