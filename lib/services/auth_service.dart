import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginUser(String username) async {
    try {
      SharedPreferences sharedPreferences = await _prefs;
      sharedPreferences.setString('username', username);
    } catch (e) {
      throw Exception(e);
    }
  }

  void logoutUser() async {
    SharedPreferences sharedPreferences = await _prefs;
    sharedPreferences.clear();
  }

  Future<String?> getUsername() async {
    SharedPreferences sharedPreferences = await _prefs;
    return sharedPreferences.getString('username') ?? 'default';
  }
}
