import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/peer_device.dart';
import 'package:sqflite/sqflite.dart';

class PeerDeviceRepository {
  final Database database;
  final String tableName = "PeerDevice";

  PeerDeviceRepository({required this.database});

  // GET
  Future<Resource<List<PeerDevice>>> getPeerDevices() async {
    try {
      final List<Map<String, Object?>> peerDeviceData = await database.query(tableName);

      // Note: Removed 'await' here because .map and .toList() are synchronous
      final List<PeerDevice> parsedPeerDeviceData = peerDeviceData.map((data) => PeerDevice.fromMap(data)).toList();

      return ResourceSuccess(parsedPeerDeviceData);
    } catch(e) {
      return ResourceFailure('Failed to fetch peer device data', exception: e as Exception);
    }
  }

  // INSERT
  Future<Resource<bool>> insertPeerDeviceData(PeerDevice peerDevice) async {
    try {
      await database.insert(
        tableName,
        peerDevice.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to insert peer device data', exception: e as Exception);
    }
  }

  // UPDATE
  Future<Resource<bool>> updateGivenPeerDeviceData(PeerDevice peerDevice) async {
    try {
      await database.update(
        tableName,
        peerDevice.toMap(),
        where: 'id = ?',
        whereArgs: [peerDevice.id],
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to update peer device data', exception: e as Exception);
    }
  }

  // DELETE
  Future<Resource<bool>> deleteGivenPeerDeviceData(String deviceID) async {
    try {
      await database.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [deviceID],
      );

      return ResourceSuccess(true);
    } catch(e) {
      // Fixed the error message here so it doesn't say "Insert"
      return ResourceFailure('Failed to delete peer device data', exception: e as Exception);
    }
  }
}