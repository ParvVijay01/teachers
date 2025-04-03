import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/notice.dart';
import 'package:teachers_app/service/dio_service.dart';
import 'package:teachers_app/utility/constants/colors.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:teachers_app/utility/constants/constants.dart';


class NoticeBox extends StatefulWidget {
  const NoticeBox({super.key});

  @override
  State<NoticeBox> createState() => _NoticeBoxState();
}

class _NoticeBoxState extends State<NoticeBox> {
  late Future<List<Notice>> futureNotice;

  final DioService dioService = DioService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureNotice = dioService.fetchNotice();
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
                onTap: () async {
                  String baseUrl = MAIN_URL;
                  String fileUrl = "$baseUrl${notices[index].secureUrl}";

                  try {
                    // Get temporary directory
                    Directory tempDir = await getTemporaryDirectory();
                    String filePath =
                        "${tempDir.path}/${notices[index].name}.pdf";

                    print("Downloading PDF from: $fileUrl");

                    // Download the PDF
                    await Dio().download(fileUrl, filePath);

                    print("PDF saved at: $filePath");

                    // Open the downloaded file
                    await OpenFilex.open(filePath);
                  } catch (e) {
                    print("Error opening PDF: $e");
                  }
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
