import 'package:flutter/foundation.dart';
import '../model/user.dart'; // Asegúrate de importar el archivo donde está tu modelo User

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void login(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
