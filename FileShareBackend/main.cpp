#include <iostream>

#include "Engine.h"
#include "UniversalSocket.h"


int main() {
    if (!initNetwork()) {
        std::cerr << "Winsock initialization failed!" << std::endl;
        return -1;
    }
    Engine engine;
    engine.intialiseCurrentUserAndDevice(R"({
      "device_unique_id": "3f9a8b7c-6d5e-4f3a-2b1c-0d9e8f7a6b5c",
      "device_name": "IQOO Z10 X",
      "device_type": "Mobile",
      "name": "Vijay",
      "bio": "Nothing Much",
      "profileImage": "Profile Image Base64 or URL string",
      "id": "user-unique-id-12345"
    })");
    engine.startBroadCast();
    engine.startTCPListening();
    // engine.startListening();

    std::cout << "Server is running. Press Enter to shut down..." << std::endl;

    // This blocks the main thread from proceeding!
    std::cin.get();

    std::cout << "Shutting down server..." << std::endl;

    cleanupNetwork();
    return 0;
}
