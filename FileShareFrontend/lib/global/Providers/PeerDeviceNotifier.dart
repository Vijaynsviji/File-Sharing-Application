import 'package:flutter/cupertino.dart';
import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/peer_device.dart';
import '../../repository/peer_device_repository.dart'; // Adjust path as needed

class PeerDeviceNotifier extends ChangeNotifier {
  final PeerDeviceRepository _repository;

  List<PeerDevice> _peerDevices = [];
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  PeerDeviceNotifier({required PeerDeviceRepository repository})
    : _repository = repository {
    // Automatically load all peer devices on initialization
    Future.microtask(() {
      loadAllPeerDevices();
    });
  }

  // Getters
  List<PeerDevice> get peerDevices => _peerDevices;
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  // Setters
  set isError(bool value) => _isError = value;
  set isLoading(bool value) => _isLoading = value;

  /// Fetch all peer devices from local database
  Future<void> loadAllPeerDevices() async {
    _setLoadingState();
    try {
      Resource<List<PeerDevice>> resource = await _repository.getPeerDevices();
      _handleListResult(resource);
    } catch (e) {
      _handleFailure("An unexpected error occurred while loading devices");
    }
  }

  /// Fetch devices filtered by specific device ID
  Future<void> loadPeerDevicesById(String deviceId) async {
    _setLoadingState();
    try {
      Resource<List<PeerDevice>> resource = await _repository
          .getPeerDevicesByDeviceId(deviceId);
      _handleListResult(resource);
    } catch (e) {
      _handleFailure("An unexpected error occurred while filtering devices");
    }
  }

  /// Add a new device and refresh the local list cache automatically
  Future<bool> addPeerDevice(PeerDevice peerDevice) async {
    try {
      Resource<bool> result = await _repository.insertPeerDeviceData(
        peerDevice,
      );
      if (result is ResourceSuccess<bool>) {
        await loadAllPeerDevices(); // Auto-refresh state
        return true;
      }
    } catch (_) {}
    return false;
  }

  /// Update device details and refresh the list
  Future<bool> updatePeerDevice(PeerDevice peerDevice) async {
    try {
      Resource<bool> result = await _repository.updateGivenPeerDeviceData(
        peerDevice,
      );
      if (result is ResourceSuccess<bool>) {
        await loadAllPeerDevices(); // Auto-refresh state
        return true;
      }
    } catch (_) {}
    return false;
  }

  /// Remove a device and refresh the list
  Future<bool> removePeerDevice(String deviceId) async {
    try {
      Resource<bool> result = await _repository.deleteGivenPeerDeviceData(
        deviceId,
      );
      if (result is ResourceSuccess<bool>) {
        await loadAllPeerDevices(); // Auto-refresh state
        return true;
      }
    } catch (_) {}
    return false;
  }

  // Helper methods to keep the data actions DRY (Don't Repeat Yourself)
  void _setLoadingState() {
    _isLoading = true;
    _isError = false;
    _errorMessage = '';
    notifyListeners();
  }

  void _handleListResult(Resource<List<PeerDevice>> resource) {
    // if (resource is ResourceFailure) {
    //   final failureResourceData = resource as ResourceFailure;
    //   final parsedFailureResourceData = failureResourceData.
    //   _handleFailure(resource. ?? "Failed to fetch peer devices");
    //   return;
    // }

    final successData = resource as ResourceSuccess<List<PeerDevice>>;
    _peerDevices = successData.data;
    _isError = false;
    _isLoading = false;
    notifyListeners();
  }

  void _handleFailure(String completeMessage) {
    _isError = true;
    _isLoading = false;
    _errorMessage = completeMessage;
    notifyListeners();
  }
}
