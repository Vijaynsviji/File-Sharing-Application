

import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

class Currentusernotifier extends ChangeNotifier {
  User currentUser;

  Currentusernotifier({
    required this.currentUser
  });

}