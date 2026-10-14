import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

class Currentusernotifier extends ChangeNotifier {
  final UserRepository _repository;
  User? _currentUser;
  bool _isLoading = true;
  bool _isError = false;

  Currentusernotifier({required UserRepository repository})
    : _repository = repository {
    Future.microtask(() {
      _loadCurrentUserData();
    });
  }

  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
  }

  bool get isLoading => _isLoading;

  User? get currentUser => _currentUser;
  UserRepository get userRepo => _repository;

  set currentUser(User value) {
    _currentUser = value;
  }

  set isLoading(bool value) {
    _isLoading = value;
  }

  Future<void> _loadCurrentUserData() async {
    try {
      Resource<User> currentUser = await _repository.getUserData();
      if (currentUser is ResourceFailure) {
        throw ("Not able to fetch current User");
      }

      final successData = currentUser as ResourceSuccess<User>;
      final parsedUserData = successData.data;
      _currentUser = parsedUserData;
      _isLoading = false;
    } catch (e) {
      _isError = true;
    } finally {
      notifyListeners();
    }
  }

  Future<void> saveUserData(User user) async {
    final result = await _repository.insertUserData(user);
    _currentUser = user;
    notifyListeners();
    if (result is ResourceFailure) {
      debugPrint('Error Saving User Data: ${result}');
    }
  }
}
