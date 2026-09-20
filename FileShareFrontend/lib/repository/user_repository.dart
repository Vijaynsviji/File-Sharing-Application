
import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final Database database;
  final String tableName = "User";

  UserRepository({required this.database});

  Future<Resource<User>> getUserData() async {
    try{
      // final db = await database;

      final List<Map<String, Object?>> userMaps = await database.query(tableName);

      final List<User> usersData = userMaps.map((map) => User.fromMap(map)).toList();

      return ResourceSuccess(usersData.first);
    }catch(e){
      return ResourceFailure('Failed to fetch user data', exception: e as Exception);
    }

  }

  Future<Resource<bool>> insertUserData(User userData) async {
    try{

      await database.insert(tableName,
          userData.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace
      );

      return ResourceSuccess(true);
    }catch(e){
      return ResourceFailure('Failed to Insert user data', exception: e as Exception);
    }
  }

  Future<Resource<bool>> updateGivenUserData(User userData)async{
    try{

      await database.update(tableName, userData.toMap(),
        where: 'id=?',
        whereArgs: [userData.id]
      );

      return ResourceSuccess(true);
    }catch(e){
      return ResourceFailure('Failed to Update user data', exception: e as Exception);
    }
  }

  Future<Resource<bool>> deleteGivenUserData(int userID)async{
    try{
      await database.delete(tableName,where: 'id=?',whereArgs: [userID]);
      return ResourceSuccess(true);
    }catch(e){
      return ResourceFailure('Failed to Insert user data', exception: e as Exception);
    }
  }
}