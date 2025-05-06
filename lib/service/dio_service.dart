import 'package:LNP_Guru/models/banners.dart';
import 'package:LNP_Guru/models/centers.dart';
import 'package:LNP_Guru/models/modules/classes..dart';
import 'package:LNP_Guru/models/modules/module_courses.dart';
import 'package:LNP_Guru/models/modules/module_pdf.dart';
import 'package:LNP_Guru/models/modules/module_subjects.dart';
import 'package:LNP_Guru/models/modules/module_topics.dart';
import 'package:dio/dio.dart';
import 'package:LNP_Guru/models/batches.dart';
import 'package:LNP_Guru/models/notice.dart';
import 'package:LNP_Guru/models/schedule.dart';
import 'package:LNP_Guru/models/subject.dart';
import 'package:LNP_Guru/models/tutorials.dart';
import 'package:LNP_Guru/utility/constants/constants.dart';

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

  Future<List<Batches>> fetchBatches() async {
    try {
      final response = await _dio.get("/class/classes");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Batches.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Classes>> fetchClasses() async {
    try {
      final response = await _dio.get("/module/get-classess");
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

  Future<List<ModuleSubjects>> fetchModuleSubjects() async {
    try {
      final response = await _dio.get("/module/get-subjects");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ModuleSubjects.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<ModuleTopics>> fetchModuleTopics() async {
    try {
      final response = await _dio.get("/module/get-topics");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ModuleTopics.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<ModuleCourses>> fetchModuleCourses() async {
    try {
      final response = await _dio.get("/module/get-courses");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ModuleCourses.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<ModulePDF>> fetchModulePDF() async {
    try {
      final response = await _dio.get("/module/get-modules");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ModulePDF.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Centers>> fetchCenters() async {
    try {
      final response = await _dio.get("/center/centers");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Centers.fromJson(json)).toList();
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
        List<Tutorial> tutorials =
            data.map((json) => Tutorial.fromJson(json)).toList();
        return tutorials;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Schedules>> getAllScheds() async {
    try {
      final response = await _dio.get("/schedule/schedules");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Schedules> schedules =
            data.map((json) => Schedules.fromJson(json)).toList();
        return schedules;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Banners>> fetAllBanners() async {
    try {
      final response = await _dio.get("/banners/banners");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Banners> banners =
            data.map((json) => Banners.fromJson(json)).toList();
        return banners;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
