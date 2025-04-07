import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:LNP_Guru/service/dio_service.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _user;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;

  final DioService _dioService = DioService();

  // Login
  Future<bool> login(BuildContext context, String email, String password) async {
    var data = await _dioService.loginUser(email, password);

    if (data["success"]) {
      _token = data["data"]["token"];
      _user = data["data"]["user"];
      notifyListeners();

      // Store in SharedPreferences for 7-day login
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", _token!);
      await prefs.setString("user", jsonEncode(_user));
      await prefs.setInt("loginTimestamp", DateTime.now().millisecondsSinceEpoch);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!"), backgroundColor: Colors.green),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"]), backgroundColor: Colors.red),
      );
      return false;
    }
  }

  // Auto-login
  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString("token");
    String? storedUser = prefs.getString("user");
    int? loginTimestamp = prefs.getInt("loginTimestamp");

    if (storedToken == null || storedUser == null || loginTimestamp == null) {
      return false;
    }

    // Check if 7 days have passed
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final sevenDays = 7 * 24 * 60 * 60 * 1000;

    if (currentTime - loginTimestamp > sevenDays) {
      // Expired
      await logout(); // Clear expired session
      return false;
    }

    _token = storedToken;
    _user = jsonDecode(storedUser);
    notifyListeners();
    return true;
  }

  // Logout
  Future<void> logout() async {
    _token = null;
    _user = null;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved login data
  }
}
