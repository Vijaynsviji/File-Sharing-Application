import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/transfer.dart';
import 'package:sqflite/sqflite.dart';

class TransferRepository {
  final Database database;
  final String tableName = "Transfer";

  TransferRepository({required this.database});

  // GET
  Future<Resource<List<Transfer>>> getTransfers() async {
    try {
      final List<Map<String, Object?>> transferMaps = await database.query(tableName);

      final List<Transfer> transfersData = transferMaps.map((map) => Transfer.fromMap(map)).toList();

      return ResourceSuccess(transfersData);
    } catch(e) {
      return ResourceFailure('Failed to fetch transfer data', exception: e as Exception);
    }
  }

  // INSERT
  Future<Resource<bool>> insertTransferData(Transfer transferData) async {
    try {
      await database.insert(
        tableName,
        transferData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to insert transfer data', exception: e as Exception);
    }
  }

  // UPDATE
  Future<Resource<bool>> updateGivenTransferData(Transfer transferData) async {
    try {
      await database.update(
        tableName,
        transferData.toMap(),
        where: 'id = ?',
        whereArgs: [transferData.id],
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to update transfer data', exception: e as Exception);
    }
  }

  // DELETE
  Future<Resource<bool>> deleteGivenTransferData(String transferID) async {
    try {
      await database.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [transferID],
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to delete transfer data', exception: e as Exception);
    }
  }
}