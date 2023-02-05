import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  Future<void> loginUser(String username) async {
    try {
      _prefs.setString('username', username);
    } catch (e) {
      throw Exception(e);
    }
  }

  void logoutUser() {
    _prefs.clear();
  }

  String? getUsername() {
    return _prefs.getString('username') ?? 'default';
  }
}
