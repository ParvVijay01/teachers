import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:LNP_Guru/models/modules/classes..dart';
import 'package:LNP_Guru/models/modules/module_courses.dart';
import 'package:LNP_Guru/models/modules/module_subjects.dart';
import 'package:LNP_Guru/models/modules/module_topics.dart';
import 'package:LNP_Guru/service/dio_service.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';

class Modules extends StatefulWidget {
  const Modules({super.key});

  @override
  State<Modules> createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {
  final _formKey = GlobalKey<FormState>();
  final DioService dioService = DioService();
  final Dio dio = Dio();

  ModuleSubjects? selectedSubject;
  ModuleCourses? selectedCourse;
  ModuleTopics? selectedTopic;
  Classes? selectedClass;

  late Future<List<ModuleSubjects>> futureSubjects;
  late Future<List<Classes>> futureClasses;
  late Future<List<ModuleTopics>> futureTopics;
  late Future<List<ModuleCourses>> futureCourses;

  bool submitted = false;
  bool _isFormExpanded = false;

  @override
  void initState() {
    super.initState();
    futureSubjects = dioService.fetchModuleSubjects();
    futureClasses = dioService.fetchClasses();
    futureTopics = dioService.fetchModuleTopics();
    futureCourses = dioService.fetchModuleCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modules")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Toggle button
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFormExpanded = !_isFormExpanded;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Search Modules",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          _isFormExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Animated form section
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState:
                      _isFormExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  firstChild: Column(
                    children: [
                      /// Class dropdown
                      FutureBuilder<List<Classes>>(
                        future: futureClasses,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: IKColors.primary,
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No Classes available");
                          }

                          List<Classes> classList = snapshot.data!;
                          return DropdownButtonFormField<Classes>(
                            decoration: _inputDecoration("Select Class"),
                            value: selectedClass,
                            items:
                                classList.map((cls) {
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
                            validator:
                                (value) =>
                                    value == null
                                        ? 'Please select a class'
                                        : null,
                          );
                        },
                      ),
                      const SizedBox(height: 10),

                      /// Courses dropdown
                      FutureBuilder<List<ModuleCourses>>(
                        future: futureCourses,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: IKColors.primary,
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No Courses available");
                          }

                          List<ModuleCourses> courses = snapshot.data!;
                          return DropdownButtonFormField<ModuleCourses>(
                            decoration: _inputDecoration("Select Course"),
                            value: selectedCourse,
                            items:
                                courses.map((course) {
                                  return DropdownMenuItem(
                                    value: course,
                                    child: Text(course.courseName),
                                  );
                                }).toList(),
                            onChanged: (ModuleCourses? newValue) {
                              setState(() {
                                selectedCourse = newValue;
                              });
                            },
                            validator:
                                (value) =>
                                    value == null
                                        ? 'Please select a course'
                                        : null,
                          );
                        },
                      ),
                      const SizedBox(height: 10),

                      /// Subject dropdown
                      FutureBuilder<List<ModuleSubjects>>(
                        future: futureSubjects,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: IKColors.primary,
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No Subjects available");
                          }

                          List<ModuleSubjects> subjects = snapshot.data!;
                          return DropdownButtonFormField<ModuleSubjects>(
                            decoration: _inputDecoration("Select Subject"),
                            value: selectedSubject,
                            items:
                                subjects.map((subj) {
                                  return DropdownMenuItem(
                                    value: subj,
                                    child: Text(subj.subjectName),
                                  );
                                }).toList(),
                            onChanged: (ModuleSubjects? newValue) {
                              setState(() {
                                selectedSubject = newValue;
                              });
                            },
                            validator:
                                (value) =>
                                    value == null
                                        ? 'Please select a subject'
                                        : null,
                          );
                        },
                      ),
                      const SizedBox(height: 10),

                      /// Topic dropdown
                      FutureBuilder<List<ModuleTopics>>(
                        future: futureTopics,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: IKColors.primary,
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No Topics available");
                          }

                          List<ModuleTopics> topics = snapshot.data!;
                          return DropdownButtonFormField<ModuleTopics>(
                            decoration: _inputDecoration("Select Topic"),
                            value: selectedTopic,
                            items:
                                topics.map((topic) {
                                  return DropdownMenuItem(
                                    value: topic,
                                    child: Text(topic.subjectTopic),
                                  );
                                }).toList(),
                            onChanged: (ModuleTopics? newValue) {
                              setState(() {
                                selectedTopic = newValue;
                              });
                            },
                            validator:
                                (value) =>
                                    value == null
                                        ? 'Please select a topic'
                                        : null,
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      /// Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IKColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              submitted = true;
                              _isFormExpanded = false; // Collapse form
                            });
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      )
                    ],
                  ),
                  secondChild: const SizedBox.shrink(),
                ),

                const SizedBox(height: 20),

                /// Display Selected Values
                if (submitted)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selected Course: ${selectedCourse?.courseName ?? ''}",
                          ),
                          Text(
                            "Selected Class: ${selectedClass?.className ?? ''}",
                          ),
                          Text(
                            "Selected Subject: ${selectedSubject?.subjectName ?? ''}",
                          ),
                          Text(
                            "Selected Topic: ${selectedTopic?.subjectTopic ?? ''}",
                          ),
                        ],
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

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: Colors.grey.shade500),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: IKColors.primary, width: 3),
      ),
    );
  }
}
