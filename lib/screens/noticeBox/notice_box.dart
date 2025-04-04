import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:LNP_Guru/models/notice.dart';
import 'package:LNP_Guru/service/dio_service.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NoticeBox extends StatefulWidget {
  const NoticeBox({super.key});

  @override
  State<NoticeBox> createState() => _NoticeBoxState();
}

class _NoticeBoxState extends State<NoticeBox> {
  late Future<List<Notice>> futureNotice;
  final DioService dioService = DioService();
  Map<int, bool> isLoadingMap = {}; // Track loading state for each notice

  @override
  void initState() {
    super.initState();
    futureNotice = dioService.fetchNotice();
  }

  Future<void> _downloadAndOpenPdf(
    String fileUrl,
    String fileName,
    int index,
  ) async {
    setState(() {
      isLoadingMap[index] = true; // Set loading state for the clicked item
    });

    try {
      // Get temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String filePath = "${tempDir.path}/$fileName.pdf";

      // Download the PDF
      await Dio().download(fileUrl, filePath);

      // Open the downloaded file
      await OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Can't open PDF"), backgroundColor: Colors.red),
      );
    }

    setState(() {
      isLoadingMap[index] = false; // Reset loading state after completion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notice Box")),
      body: FutureBuilder<List<Notice>>(
        future: futureNotice,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: IKColors.primary),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Notices Available"));
          }

          List<Notice> notices = snapshot.data!;

          return ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  String baseUrl = "https://teacher-backend-fxy3.onrender.com";
                  String fileUrl = "$baseUrl/${notices[index].secureUrl}";
                  _downloadAndOpenPdf(fileUrl, notices[index].name, index);
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      notices[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.picture_as_pdf,
                      color: IKColors.primary,
                    ),
                    trailing:
                        isLoadingMap[index] == true
                            ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: IKColors.primary,
                              ),
                            )
                            : null, // No icon when not loading
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
