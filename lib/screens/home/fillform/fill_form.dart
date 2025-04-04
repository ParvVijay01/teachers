import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';
import 'package:LNP_Guru/models/chapter.dart';
import 'package:LNP_Guru/models/classes.dart';
import 'package:LNP_Guru/models/subject.dart';
import 'package:LNP_Guru/service/dio_service.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:dio/dio.dart';

class FillForm extends StatefulWidget {
  const FillForm({super.key});

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final DioService dioService = DioService();
  final Dio dio = Dio();

  bool _isLoading = false;
  TextEditingController topicController = TextEditingController();

  List<Chapter> availableChapters = [];
  Subject? selectedSubject;
  Chapter? selectedChapter;
  Classes? selectedClass;

  late Future<List<Classes>> futureClasses;
  late Future<List<Subject>> futureSubjects;

  @override
  void initState() {
    super.initState();
    futureSubjects = dioService.fetchSubjects();
    futureClasses = dioService.fetchClasses(); // Assign it once
  }

  Future<void> submitReport() async {
    if (selectedSubject == null ||
        selectedChapter == null ||
        selectedClass == null ||
        topicController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields!")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserProvider userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      final userId = userProvider.user?["_id"];

      Response response = await dio.post(
        'https://teacher-backend-fxy3.onrender.com/api/schedule/schedule',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "userId": userId,
          "subjectName": selectedSubject!.subjectName,
          "chapterName": selectedChapter!.chapterName,
          "topic": topicController.text.trim(),
          "date": date,
          "className": selectedClass!.className,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Report submitted successfully!")),
        );
        topicController.clear();
        selectedChapter = null;
        selectedClass = null;
        selectedSubject = null;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to submit report!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Fill Form")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Daily Report",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: IKColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, color: IKColors.primary),
                        const SizedBox(width: 8),
                        const Text(
                          "Current date:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// **Class Dropdown**
                FutureBuilder<List<Classes>>(
                  future: futureClasses,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: IKColors.primary,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No Batches available"));
                    }

                    List<Classes> classes = snapshot.data!;

                    if (selectedClass != null &&
                        !classes.any((cls) => cls.id == selectedClass!.id)) {
                      selectedClass = null;
                    }

                    return DropdownButtonFormField<Classes>(
                      decoration: InputDecoration(
                        hintText: "Select Batch",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: IKColors.primary,
                            width: 3,
                          ),
                        ),
                      ),
                      value: selectedClass,
                      items:
                          classes.map((cls) {
                            return DropdownMenuItem(
                              value: cls,
                              child: Text(cls.className),
                            );
                          }).toList(),
                      onChanged: (Classes? newValue) {
                        setState(() {
                          selectedClass = newValue;
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),

                /// **Subject Dropdown**
                FutureBuilder<List<Subject>>(
                  future: futureSubjects,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: IKColors.primary,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No Subjects available"));
                    }

                    List<Subject> subjects = snapshot.data!;

                    if (selectedSubject != null &&
                        !subjects.any((sub) => sub.id == selectedSubject!.id)) {
                      selectedSubject = null;
                    }

                    return DropdownButtonFormField<Subject>(
                      decoration: InputDecoration(
                        hintText: "Select Subject",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: IKColors.primary,
                            width: 3,
                          ),
                        ),
                      ),
                      value: selectedSubject,
                      items:
                          subjects.map((subject) {
                            return DropdownMenuItem(
                              value: subject,
                              child: Text(subject.subjectName),
                            );
                          }).toList(),
                      onChanged: (Subject? newValue) {
                        setState(() {
                          selectedSubject = newValue;
                          availableChapters = newValue?.chapters ?? [];
                          selectedChapter = null;
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),

                /// **Chapter Dropdown**
                DropdownButtonFormField<Chapter>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: IKColors.primary, width: 3),
                    ),
                  ),
                  value: selectedChapter,
                  items:
                      availableChapters.map((chapter) {
                        return DropdownMenuItem(
                          value: chapter,
                          child: Text(chapter.chapterName),
                        );
                      }).toList(),
                  onChanged:
                      availableChapters.isNotEmpty
                          ? (Chapter? newValue) {
                            setState(() {
                              selectedChapter = newValue;
                            });
                          }
                          : null,
                  hint: const Text("Select Chapter"),
                ),

                const SizedBox(height: 10),

                /// **Topic TextField**
                TextField(
                  controller: topicController,
                  minLines: 5,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2),
                    ),
                    hintText: "Topics Discussed",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: IKColors.primary, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : submitReport,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IKColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: IKColors.primary,
                            )
                            : const Text(
                              "Submit Report",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
