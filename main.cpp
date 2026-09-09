#include <iostream>

#include "Engine.h"
#include "UniversalSocket.h"


int main() {
    if (!initNetwork()) {
        std::cerr << "Winsock initialization failed!" << std::endl;
        return -1;
    }
    Engine engine;
    engine.startBroadCast();
    engine.startListening();

    std::cout << "Server is running. Press Enter to shut down..." << std::endl;

    // This blocks the main thread from proceeding!
    std::cin.get();

    std::cout << "Shutting down server..." << std::endl;

    cleanupNetwork();
    return 0;
}
