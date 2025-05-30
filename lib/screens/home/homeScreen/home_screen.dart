import 'package:LNP_Guru/service/dio_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:LNP_Guru/screens/auth/login/components/gradient_text.dart';
import 'package:LNP_Guru/screens/home/components/drawer.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:LNP_Guru/widgets/profile_card.dart';
import 'package:LNP_Guru/models/banners.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Banners> banners = [];
  bool isLoadingBanners = true;

  @override
  void initState() {
    super.initState();
    fetchBannerImages();
  }

  Future<void> fetchBannerImages() async {
    try {
      final dioService = DioService();
      List<Banners> fetchedBanners = await dioService.fetAllBanners();
      setState(() {
        banners = fetchedBanners;
        isLoadingBanners = false;
      });
    } catch (e) {
      print("Error loading banners: $e");
      setState(() {
        isLoadingBanners = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
              text: "Welcome to LNP Guru App",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Carousel Slider for banners
            isLoadingBanners
                ? Center(child: CircularProgressIndicator())
                : banners.isEmpty
                ? Center(child: Text('No banners available'))
                : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 4.7,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                    ),
                    items:
                        banners.map((banner) {
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
                                banner.secureUrl, // Make sure it's full URL
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        Center(child: Icon(Icons.broken_image)),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),

            SizedBox(height: 20),
            ProfileCard(isHome: true),
            SizedBox(height: 20),

            // Two buttons
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
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Daily report button
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
          ],
        ),
      ),
    );
  }
}
