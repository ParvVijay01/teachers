import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/utility/constants/colors.dart';
import 'package:teachers_app/utility/constants/images.dart';
import 'package:teachers_app/utility/constants/sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final List<Map<String, String>> images = [
    {
      'image': IKImages.onBoarding,
      'title': 'Track Your Teaching with Ease',
      'description':
          'Quickly fill out daily teaching logs. Record lesson topics, key points, and class progress—all in one place!',
    },
    {
      'image': IKImages.onBoarding2, // Fix key from 'images' to 'image'
      'title': 'Stay Organized, Teach Better',
      'description':
          'Keep a record of what you taught each day. Plan ahead and ensure a smooth learning experience for your students!',
    },
    {
      'image': IKImages.onBoarding3, // Fix key from 'images' to 'image'
      'title': 'Simple & Fast Lesson Logging',
      'description':
          'Fill out daily reports on your classroom lessons in just a few taps. No hassle, just efficient teaching documentation!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: IKSizes.container),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Fix: Wrap Swiper in a SizedBox with a defined height
            SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  0.8, // Adjust height as needed
              child: Swiper(
                itemBuilder: (context, index) {
                  final image = images[index]['image'];
                  final title = images[index]['title']!;
                  final description = images[index]['description']!;

                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        SvgPicture.asset(image!),
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
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).textTheme.titleMedium?.color,
                  side: const BorderSide(color: IKColors.secondary),
                  foregroundColor: Theme.of(context).cardColor,
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
