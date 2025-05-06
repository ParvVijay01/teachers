import 'package:LNP_Guru/models/centers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';
import 'package:LNP_Guru/models/chapter.dart';
import 'package:LNP_Guru/models/batches.dart';
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
  final _formKey = GlobalKey<FormState>();
  final DioService dioService = DioService();
  final Dio dio = Dio();

  bool _isLoading = false;
  TextEditingController topicController = TextEditingController();

  List<Chapter> availableChapters = [];
  Subject? selectedSubject;
  Chapter? selectedChapter;
  Batches? selectedClass;
  Centers? selectedCenter;

  late Future<List<Batches>> futureClasses;
  late Future<List<Subject>> futureSubjects;
  late Future<List<Centers>> futureCenters;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureSubjects = dioService.fetchSubjects();
    futureClasses = dioService.fetchBatches();
    futureCenters = dioService.fetchCenters();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> submitReport() async {
    if (selectedSubject == null ||
        selectedChapter == null ||
        selectedClass == null ||
        selectedCenter == null ||
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
          "date": DateFormat('yyyy-MM-dd').format(selectedDate),
          "className": selectedClass!.className,
          "centerName": selectedCenter!.name,
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
        selectedCenter = null;
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

                /// Date Picker
                InkWell(
                  onTap: () => _selectDate(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: IKColors.primary, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: IKColors.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Select Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Center Dropdown
                FutureBuilder<List<Centers>>(
                  future: futureCenters,
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

                    List<Centers> centers = snapshot.data!;

                    return DropdownButtonFormField<Centers>(
                      decoration: InputDecoration(
                        hintText: "Select Center",
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
                      value: selectedCenter,
                      items:
                          centers.map((center) {
                            return DropdownMenuItem(
                              value: center,
                              child: Text(center.name),
                            );
                          }).toList(),
                      onChanged: (Centers? newValue) {
                        setState(() {
                          selectedCenter = newValue;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),

                /// Class Dropdown
                FutureBuilder<List<Batches>>(
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

                    List<Batches> classes = snapshot.data!;

                    return DropdownButtonFormField<Batches>(
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
                      onChanged: (Batches? newValue) {
                        setState(() {
                          selectedClass = newValue;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),

                /// Subject Dropdown
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

                /// Chapter Dropdown
                DropdownButtonFormField<Chapter>(
                  decoration: InputDecoration(
                    hintText: "Select Chapter",
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
                ),
                const SizedBox(height: 10),

                /// Topic Text Field
                TextField(
                  controller: topicController,
                  minLines: 5,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: "Topics Discussed",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: IKColors.primary, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Submit Button
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
                              color: Colors.white,
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
