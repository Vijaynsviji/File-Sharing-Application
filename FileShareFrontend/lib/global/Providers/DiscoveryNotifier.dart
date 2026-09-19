

import 'dart:core';
import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/peer_device.dart';
import 'package:file_share_application_frontend/repository/peer_device_repository.dart';
import 'package:flutter/cupertino.dart';

class Discoverynotifier extends ChangeNotifier{
  List<PeerDevice> _acceptedPeerDevices  = [];
  List<PeerDevice> _onlinePeerDevices  = [];

  final PeerDeviceRepository _repository;

  Discoverynotifier({
    required PeerDeviceRepository repository
  }): _repository = repository;
  // 🚪 Getters
  List<PeerDevice> get acceptedPeerDevices => _acceptedPeerDevices;
  List<PeerDevice> get onlinePeerDevices => _onlinePeerDevices;

  // 📥 Setters
  set acceptedPeerDevices(List<PeerDevice> devices) {
    _acceptedPeerDevices = devices;
    notifyListeners();
  }

  set onlinePeerDevices(List<PeerDevice> devices) {
    _onlinePeerDevices = devices;
    notifyListeners();
  }


  void addNewOnlinePeerDevice(PeerDevice peerDevice){
    _onlinePeerDevices .add(peerDevice);
    notifyListeners();
  }

  Future<void> _savePeerUserToDatabase(PeerDevice peerDevice)async{
    final result = await _repository.getPeerDevicesByDeviceId(peerDevice.deviceUniqueId);
    if (result is ResourceFailure) {
      final failure = result as ResourceFailure;
      debugPrint('Error persisting settings: ${failure.errorMessage}');
      return;
    }

    final successData = result as ResourceSuccess<List<PeerDevice>>;
    final peerDeviceData = successData.data;
    bool isPeerDevicePresent = peerDeviceData?.any((device) =>
      device.deviceUniqueId == peerDevice.deviceUniqueId
    ) ?? false;

    if(isPeerDevicePresent){
      await _repository.insertPeerDeviceData(peerDevice);
    }else{
      await _repository.updateGivenPeerDeviceData(peerDevice);
    }
  }


  Future<void> addAcceptedPeerDevices(PeerDevice peerDevice) async{
    _acceptedPeerDevices.add(peerDevice);
    notifyListeners();
    await _savePeerUserToDatabase(peerDevice);
  }


}