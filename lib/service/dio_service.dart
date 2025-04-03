import 'package:dio/dio.dart';
import 'package:teachers_app/models/classes.dart';
import 'package:teachers_app/models/notice.dart';
import 'package:teachers_app/models/subject.dart';
import 'package:teachers_app/models/tutorials.dart';
import 'package:teachers_app/utility/constants/constants.dart';

class DioService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: MAIN_URL, // Change to actual API URL
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        return {
          "success": true,
          "data": response.data, // Token & user details
        };
      } else {
        return {
          "success": false,
          "message": "Invalid response: ${response.statusCode}",
        };
      }
    } on DioException catch (e) {
      String errorMessage = "Something went wrong. Please try again.";
      if (e.response != null) {
        errorMessage = e.response!.data["message"] ?? "Login Failed";
      } else {
        errorMessage = "Network Error: ${e.message}";
      }

      return {"success": false, "message": errorMessage};
    }
  }

  Future<List<Subject>> fetchSubjects() async {
    try {
      final response = await _dio.get('/subject/get-subjects');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Subject.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Classes>> fetchClasses() async {
    try {
      final response = await _dio.get("/class/classes");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Classes.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Notice>> fetchNotice() async {
    try {
      final response = await _dio.get("/pdf/pdfs");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Notice.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Tutorial>> fetchTutorials() async {
    try {
      final response = await _dio.get("/links/links");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print("data ---> $data");
        return data.map((json) => Tutorial.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
