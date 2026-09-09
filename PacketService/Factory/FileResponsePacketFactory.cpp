//
// Created by VijayNSadashiva on 12-08-2026.
//

#include "FileResponsePacketFactory.h"
#include <vector>

#include "PacketService/Converters/DeviceConverter.h"
#include "PacketService/Converters/FileMetadataConverter.h"
#include "PacketService/Packets/FileResponse.h"
#include "PacketService/Proto/FileResponse.pb.h"


FileResponse FileResponsePacketFactory::createPacket(
    std::vector<FileMetadata>& fileMetadata,
    bool isSenderAccepted
) {
    for (auto& fileData: fileMetadata) {
        if (fileData.isInvalid()) {
            throw std::invalid_argument("Cannot Create File Response Packet");
        }
    }

    FileResponse fileResponse(
        fileMetadata,
        isSenderAccepted
    );

    return fileResponse;
}

FileResponseProto::FileResponse FileResponsePacketFactory::createProto(
    std::vector<FileMetadata>& fileMetadata,
   bool isSenderAccepted
) {
    for (auto& fileData: fileMetadata) {
        if (fileData.isInvalid()) {
            throw std::invalid_argument("Cannot Create File Response Proto");
        }
    }

    FileResponseProto::FileResponse fileResponseProto;
    // auto deviceProto = DeviceConverter::toProto(device);
    // if (!deviceProto.has_value()) {
    //     throw std::runtime_error("Not able to convert device to proto.");
    // }
    for (const auto& fileData : fileMetadata) {
        // 2. Convert your native structural object to a temporary Proto object
        FileMetadataProto::FileMetadata file_metadata_proto = FileMetadataConverter::toProto(fileData);

        // FIXED: Call add_filemetadata() INSIDE the loop to allocate a brand new slot for every item
        // FIXED: Spelled 'filemetadata' correctly with the missing 'a'
        FileMetadataProto::FileMetadata* new_item = fileResponseProto.add_filemetdata();

        // 3. Copy the data or swap memory allocations
        new_item->CopyFrom(file_metadata_proto);
    }
    // auto fileMetaDataProto = FileMetadataConverter::toProto(fileMetadata);


    // *fileResponseProto.() = *deviceProto;
    // *fileResponseProto.mutable_filemetdata() = *fileMetaDataProto;
    fileResponseProto.set_packettype(PacketEnum::FileResponse);
    fileResponseProto.set_issenderacceptedornot(isSenderAccepted);


    return fileResponseProto;
}