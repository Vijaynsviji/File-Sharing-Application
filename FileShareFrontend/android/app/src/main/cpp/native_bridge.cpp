#include "Engine.h"

extern "C" {

Engine* engine_create() {
    return new Engine();
}

void engine_destroy(Engine* engine) {
    delete engine;
}

void engine_startBroadCast(Engine* engine) {
    engine->startBroadCast();
}

void engine_startListening(Engine* engine) {
    engine->startListening();
}

void engine_stopBroadCasting(Engine* engine) {
    engine->stopBroadCasting();
}

void engine_stopListening(Engine* engine) {
    engine->stopListening();
}

void engine_startTCPListening(Engine* engine) {
    engine->startTCPListening();
}

void engine_stopTCPListening(Engine* engine) {
    engine->stopTCPListening();
}

void engine_sendFileRequest(
        Engine* engine,
        const char* senderIPAddress
) {
    engine->sendFileRequest(senderIPAddress);
}

void engine_sendFileResponse(
        Engine* engine,
        const char* deviceId
) {
    engine->sendFileResponse(deviceId);
}

void engine_addUserSelectedFiles(
        Engine* engine,
        const char* jsonString
) {
    engine->addUserSelectedFiles(jsonString);
}

void engine_initialiseDartEventPortId(
        Engine* engine,
        int dartPortId
        ){
    engine->initialiseDartPortId(dartPortId);
}

}
