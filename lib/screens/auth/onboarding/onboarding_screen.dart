import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/utility/constants/colors.dart';
import 'package:teachers_app/utility/constants/images.dart';
import 'package:teachers_app/utility/constants/sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, String>> images = [
    {
      'image': IKImages.onBoarding,
      'title': 'Track Your Teaching with Ease',
      'description':
          'Quickly fill out daily teaching logs. Record lesson topics, key points, and class progress—all in one place!',
    },
    {
      'image': IKImages.onBoarding2,
      'title': 'Stay Organized, Teach Better',
      'description':
          'Keep a record of what you taught each day. Plan ahead and ensure a smooth learning experience for your students!',
    },
    {
      'image': IKImages.onBoarding3,
      'title': 'Simple & Fast Lesson Logging',
      'description':
          'Fill out daily reports on your classroom lessons in just a few taps. No hassle, just efficient teaching documentation!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: IKSizes.container),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Swiper occupies available space
              Expanded(
                child: Swiper(
                  itemBuilder: (context, index) {
                    final image = images[index]['image'];
                    final title = images[index]['title']!;
                    final description = images[index]['description']!;

                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(image!),
                          const SizedBox(height: 20),
                          Text(
                            title,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge?.merge(
                              const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: Theme.of(context).textTheme.bodyLarge?.merge(
                              TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.color,
                                fontSize: 15,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    );
                  },
                  autoplay: true,
                  itemCount: images.length,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      size: 6,
                      activeSize: 8,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? IKColors.background
                              : const Color.fromARGB(47, 0, 0, 0),
                      activeColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? IKColors.card
                              : IKColors.secondary,
                      space: 4,
                    ),
                  ),
                ),
              ),

              // Elevated Button at the Bottom
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: IKColors.primary, width: 3),
                      ),
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
