import 'package:flutter/material.dart';
import 'package:LNP_Guru/models/tutorials.dart';
import 'package:LNP_Guru/service/dio_service.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Tutorials extends StatefulWidget {
  const Tutorials({super.key});

  @override
  State<Tutorials> createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  late Future<List<Tutorial>> futureTutorial;

  final DioService dioService = DioService();

  @override
  void initState() {
    super.initState();
    futureTutorial = dioService.fetchTutorials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tutorial Materials")),
      body: FutureBuilder<List<Tutorial>>(
        future: futureTutorial,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: IKColors.primary),
            );
          } else if (snapshot.hasError) {
            print("Error in FutureBuilder: ${snapshot.error}"); // Debugging
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Training Material Available"));
          }

          List<Tutorial> tutorials = snapshot.data!;
          print(
            "Tutorials List: ${tutorials.map((e) => e.title).toList()}",
          ); // Debugging

          return ListView.builder(
            itemCount: tutorials.length,
            itemBuilder: (context, index) {
              // Ensure null safety when displaying text
              return GestureDetector(
                onTap: () => _launchYoutube(tutorials[index].secureUrl),
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      tutorials[index].title, // Handle null
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.video_camera_back,
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

Future<void> _launchYoutube(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw "Could not launch $url";
  }
}
