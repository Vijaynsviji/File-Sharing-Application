//
// Created by VijayNSadashiva on 13-08-2026.
//

// #ifndef FILESHAREBACKEND_DISCOVERYSERVICE_H
// #define FILESHAREBACKEND_DISCOVERYSERVICE_H
//
// #endif //FILESHAREBACKEND_DISCOVERYSERVICE_H


#pragma once
#include <unordered_map>
#include <string>
#include <mutex>

#include "EventService/EventEmitter.h"
#include "Models/OnlineDevice.h"
#include "PacketService/Converters/FileRequestConverter.h"
#include "PacketService/Packets/FileRequest.h"
#include "PacketService/Proto/FileRequest.pb.h"
#include "Services/TCPService.h"
#include "Services/UDPBroadcaster.h"
#include "Services/UDPListener.h"
#include "Types/SocketValue.h"


class DiscoveryService {
    DartEventEmitter& eventEmitter;
    std::unordered_map<std::string,OnlineDevice> onlineDevices;
    UDPBroadcaster udpBroadCaster;
    UDPListener udpListener;
    std::mutex onlineDeviceMutex;
    bool stopRemoveInactiveTask = false;
    bool stopDiscoveryListenServer = false;
    int DiscoveryTCPPort;
public:
    DiscoveryService(long long bufferSize, int portValue,int discoveryTCPPort,DartEventEmitter& eventEmitter):
    udpBroadCaster(portValue,bufferSize),udpListener(portValue),DiscoveryTCPPort(discoveryTCPPort),
    eventEmitter(eventEmitter){}

    std::unordered_map<std::string, OnlineDevice> online_devices() const {
        return onlineDevices;
    }

    void set_online_devices(std::unordered_map<std::string, OnlineDevice> online_devices) {
        onlineDevices = online_devices;
    }

    UDPBroadcaster udp_broad_caster() const {
        return udpBroadCaster;
    }

    void set_udp_broad_caster(UDPBroadcaster udp_broad_caster) {
        udpBroadCaster = udp_broad_caster;
    }

    UDPListener udp_listener() const {
        return udpListener;
    }

    void set_udp_listener(UDPListener udp_listener) {
        udpListener = udp_listener;
    }

    bool stop_remove_inactive_task() const {
        return stopRemoveInactiveTask;
    }

    void set_stop_remove_inactive_task(bool stop_remove_inactive_task) {
        stopRemoveInactiveTask = stop_remove_inactive_task;
    }

    bool stop_discovery_listen_server() const {
        return stopDiscoveryListenServer;
    }

    void set_stop_discovery_listen_server(bool stop_discovery_listen_server) {
        stopDiscoveryListenServer = stop_discovery_listen_server;
    }

    int discovery_tcp_port() const {
        return DiscoveryTCPPort;
    }

    void set_discovery_tcp_port(int discovery_tcp_port) {
        DiscoveryTCPPort = discovery_tcp_port;
    }

    void startUdpBroadCasting() {
        udpBroadCaster.broadCastUDP();
    }

    void stopUdpBroadCasting() {
        udpBroadCaster.shutDownServer();
    }

    void listenToBroadCast() {
        udpListener.listenUDP(onlineDevices);
    }

    void stopUdpListening() {
        udpListener.stopServer();
    }

    void removeInactivDevices();

    void stopRemoveInactivyDeviceTask();

    void DiscoveryRequestListner();

    void stopDiscoveryRequestLister();
};
