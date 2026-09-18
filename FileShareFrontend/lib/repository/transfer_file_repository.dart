import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/transfer_file.dart';
import 'package:sqflite/sqflite.dart';

class TransferFileRepository {
  final Database database;
  final String tableName = "TransferFile";

  TransferFileRepository({required this.database});

  // GET
  Future<Resource<List<TransferFile>>> getTransferFiles() async {
    try {
      final List<Map<String, Object?>> transferFileMaps = await database.query(tableName);

      final List<TransferFile> transferFilesData = transferFileMaps.map((map) => TransferFile.fromMap(map)).toList();

      return ResourceSuccess(transferFilesData);
    } catch(e) {
      return ResourceFailure('Failed to fetch transfer file data', exception: e as Exception);
    }
  }

  // INSERT
  Future<Resource<bool>> insertTransferFileData(TransferFile transferFile) async {
    try {
      await database.insert(
        tableName,
        transferFile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to insert transfer file data', exception: e as Exception);
    }
  }

  // UPDATE
  Future<Resource<bool>> updateGivenTransferFileData(TransferFile transferFile) async {
    try {
      await database.update(
        tableName,
        transferFile.toMap(),
        where: 'id = ?',
        whereArgs: [transferFile.id],
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to update transfer file data', exception: e as Exception);
    }
  }

  // DELETE
  Future<Resource<bool>> deleteGivenTransferFileData(String fileID) async {
    try {
      await database.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [fileID],
      );

      return ResourceSuccess(true);
    } catch(e) {
      return ResourceFailure('Failed to delete transfer file data', exception: e as Exception);
    }
  }
}