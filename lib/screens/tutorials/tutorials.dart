import 'package:flutter/material.dart';
import 'package:teachers_app/models/tutorials.dart';
import 'package:teachers_app/service/dio_service.dart';
import 'package:teachers_app/utility/constants/colors.dart';

class Tutorials extends StatefulWidget {
  const Tutorials({super.key});

  @override
  State<Tutorials> createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  late Future<List<Tutorial>> futureTutorial;

  final DioService dioService = DioService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureTutorial = dioService.fetchTutorials();
    print("fetchTutorials ---> $futureTutorial");
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
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Training Material Available"));
          }

          List<Tutorial> tutorials = snapshot.data!;
          print("tutorials ----> $tutorials");

          return ListView.builder(
            itemCount: tutorials.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {},
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      tutorials[index].title,
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
