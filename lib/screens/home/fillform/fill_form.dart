import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/models/chapter.dart';
import 'package:teachers_app/models/classes.dart';
import 'package:teachers_app/models/subject.dart';
import 'package:teachers_app/service/dio_service.dart';
import 'package:teachers_app/utility/constants/colors.dart';

class FillForm extends StatefulWidget {
  const FillForm({super.key});

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final bool _isEditable = true;
  late Future<List<Classes>> futureClasses;
  late Future<List<Subject>> futureSubjects;
  final DioService dioService = DioService();

  List<Chapter> availableChapters = [];
  Subject? selectedSubject;
  Chapter? selectedChapters;
  Classes? selectedClasses;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureSubjects = dioService.fetchSubjects(); // Ensure it's initialized
    futureClasses = dioService.fetchClasses(); // Ensure it's initialized
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Fill Form")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // "Form" text at the top
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Daily Report",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: IKColors.primary,
                  ),
                ),
              ),

              // Center remaining content
              SizedBox(
                height: height * 0.8,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Pick Date Button
                        SizedBox(height: 10),

                        // Date Picker UI
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: IKColors.primary,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Current date:",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder<List<Classes>>(
                          future: futureClasses,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: IKColors.primary,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("No Batches available"),
                              );
                            }
                            List<Classes> classes = snapshot.data!;

                            return DropdownButtonFormField<Classes>(
                              decoration: InputDecoration(
                                hintText: "Select Batch",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: IKColors.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: selectedClasses,
                              items:
                                  classes.map((classes) {
                                    return DropdownMenuItem(
                                      value: classes,
                                      child: Text(classes.className),
                                    );
                                  }).toList(),
                              onChanged: (Classes? newValue) {
                                selectedClasses = newValue;
                              },
                            );
                          },
                        ),
                        FutureBuilder<List<Subject>>(
                          future: futureSubjects,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: IKColors.primary,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("No Subjects available"),
                              );
                            }

                            List<Subject> subjects = snapshot.data!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 20),
                                DropdownButtonFormField<Subject>(
                                  decoration: InputDecoration(
                                    hintText: "Select Subject",
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: IKColors.primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
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
                                      availableChapters =
                                          newValue?.chapters ?? [];
                                      selectedChapters = null;
                                    });
                                  },
                                ),
                                SizedBox(height: 10),
                                DropdownButtonFormField<Chapter>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: IKColors.primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  value: selectedChapters,
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
                                              selectedChapters = newValue;
                                            });
                                          }
                                          : null,
                                  hint: Text(
                                    selectedSubject == null
                                        ? "Select a Subject First"
                                        : availableChapters.isEmpty
                                        ? "No Chapters Found"
                                        : "Select Chapter",
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                ),
                                SizedBox(height: 10),
                                // Topics Discussed TextField
                                TextField(
                                  enabled:
                                      _isEditable, // Disable if date is not today
                                  minLines: 5,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: IKColors.primary,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: IKColors.primary,
                                        width: 2,
                                      ),
                                    ),
                                    hintText: "Topics Discussed",
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  height: height * 0.06,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: IKColors.primary,
                                      shadowColor: Colors.black,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "Submit Report",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        // Dropdown fields
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
