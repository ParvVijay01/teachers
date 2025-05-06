import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';
import 'package:LNP_Guru/models/schedule.dart';
import 'package:LNP_Guru/screens/home/components/drawer.dart';
import 'package:LNP_Guru/service/dio_service.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime? selectedDate;

  Future<List<Schedules>> fetchUserSchedules() async {
    try {
      List<Schedules> allSchedules = await DioService().getAllScheds();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      String currentUserId = userProvider.user!["_id"];

      // Filter schedules for the logged-in user
      List<Schedules> userSchedules =
          allSchedules
              .where((schedule) => schedule.userId.id == currentUserId)
              .toList();

      // Filter by selected date (if applicable)
      if (selectedDate != null) {
        return userSchedules.where((schedule) {
          return DateFormat(
                'yyyy-MM-dd',
              ).format(DateTime.parse(schedule.date)) ==
              DateFormat('yyyy-MM-dd').format(selectedDate!);
        }).toList();
      }

      return userSchedules;
    } catch (e) {
      print("Error fetching schedules: $e");
      return [];
    }
  }

  /// 📌 Function to pick a date
  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  /// 📌 Function to clear the selected date
  void _clearDate() {
    setState(() {
      selectedDate = null;
    });
  }

  /// 📌 Widget to show "No Entries" message in the center
  Widget _buildNoEntriesMessage() {
    String dateText =
        selectedDate != null
            ? DateFormat('dd/MM/yyyy').format(selectedDate!)
            : "selected date";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.event_busy, size: 60, color: Colors.redAccent),
        const SizedBox(height: 10),
        Text(
          "No entries on $dateText.",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Reports"),
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: IKColors.primary),
                  ),
                  onPressed: () => _pickDate(context),
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: IKColors.primary,
                  ),
                  label: Text(
                    selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : "Pick a Date",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: IKColors.primary,
                    ),
                  ),
                ),

                if (selectedDate !=
                    null) // Show Clear button only if a date is selected
                  InkWell(
                    onTap: _clearDate,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.close, size: 18, color: Colors.red),
                          SizedBox(width: 5),
                          Text(
                            "Clear",
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            /// 📌 FutureBuilder to Display Schedule Table
            Expanded(
              child: FutureBuilder<List<Schedules>>(
                future: fetchUserSchedules(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: _buildNoEntriesMessage());
                  }

                  List<Schedules> schedules = snapshot.data!;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columnSpacing: 20,
                        border: TableBorder.all(color: Colors.grey.shade300),
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        dataRowHeight: 50, // Adjust row height
                        columns: const [
                          DataColumn(label: Text("Center")),
                          DataColumn(label: Text("Batch")),
                          DataColumn(label: Text("Subject")),
                          DataColumn(label: Text("Chapter")),
                          DataColumn(label: Text("Topic")),
                          DataColumn(label: Text("Date")),
                        ],
                        rows:
                            schedules.map((schedule) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(schedule.centerName)),
                                  DataCell(Text(schedule.className)),
                                  DataCell(Text(schedule.subjectName)),
                                  DataCell(Text(schedule.chapterName)),
                                  DataCell(
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        schedule.topic,
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(DateTime.parse(schedule.date)),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
