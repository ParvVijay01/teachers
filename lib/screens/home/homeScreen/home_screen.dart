import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:LNP_Guru/screens/auth/login/components/gradient_text.dart';
import 'package:LNP_Guru/screens/home/components/drawer.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:LNP_Guru/widgets/profile_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> bannerImages = [
    'https://cdn.pixabay.com/photo/2016/09/04/20/14/sunset-1645105_1280.jpg',
    'https://img.freepik.com/premium-vector/abstract-technology-background-white-blue-gradient-modern-futuristic-blue-background-news-report-banner-cover-design_115973-8810.jpg',
    'https://graphicsfamily.com/wp-content/uploads/2020/11/Professional-Web-Banner-AD-in-Photoshop-scaled.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    //sizess
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        title: Text(
          "Home",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GradientText(
              text: "Welcome to LNP_Guru App",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Carousel Slider
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                ),
                items:
                    bannerImages.map((imageUrl) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ProfileCard(isHome: true),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/noticebox");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IKColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notification_add,
                          color: Colors.white,
                          size: 50,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Notice Box",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/tutorials");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IKColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_camera_back,
                          color: Colors.white,
                          size: 50,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Training Materials",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: height * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/fillform");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IKColors.primary,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dashboard, color: Colors.white, size: 40),
                    SizedBox(width: 10),
                    Text(
                      "Fill Daily Report",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Form Title
          ],
        ),
      ),
    );
  }
}
