import 'package:flutter/material.dart';
import 'package:LNP_Guru/service/dio_service.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _user;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;

  final DioService _dioService = DioService();

  // Login function
  Future<bool> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    var data = await _dioService.loginUser(email, password);

    if (data["success"]) {
      _token = data["data"]["token"];
      _user = data["data"]["user"];
      notifyListeners();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login Successful!"),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      // Show error message from API response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"]), backgroundColor: Colors.red),
      );
      return false;
    }
  }

  // Logout function
  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}
