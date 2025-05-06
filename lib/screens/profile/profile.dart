import 'package:LNP_Guru/utility/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:LNP_Guru/screens/home/components/drawer.dart';
import 'package:LNP_Guru/widgets/profile_card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Positioned.fill(child: AnimatedBackgroundIcons()),

          // Profile Card Centered
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(IKImages.logo),
                  ProfileCard(isHome: false),
                ],
              )
            ),

            
          ),
          
        ],
      ),
    );
  }
}


class AnimatedBackgroundIcons extends StatefulWidget {
  const AnimatedBackgroundIcons({super.key});

  @override
  _AnimatedBackgroundIconsState createState() =>
      _AnimatedBackgroundIconsState();
}

class _AnimatedBackgroundIconsState extends State<AnimatedBackgroundIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<IconData> icons = [
    Icons.menu_book,
    Icons.lightbulb_outline,
    Icons.school,
    Icons.edit,
    Icons.auto_stories,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _FlyingIconsPainter(_controller.value, icons),
        );
      },
    );
  }
}

class _FlyingIconsPainter extends CustomPainter {
  final double progress;
  final List<IconData> icons;
  final List<Color> iconColors = [
    Colors.amber,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.red,
  ];

  _FlyingIconsPainter(this.progress, this.icons);

  @override
  void paint(Canvas canvas, Size size) {
    final double iconSize = 40.0;

    for (int i = 0; i < icons.length; i++) {
      final double dx =
          (size.width / icons.length) * i + 20 * (i % 2 == 0 ? 1 : -1);
      final double dy = (size.height * ((progress + i * 0.2) % 1.0));

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icons[i].codePoint),
          style: TextStyle(
            fontSize: iconSize,
            fontFamily: icons[i].fontFamily,
            color: iconColors[i % iconColors.length].withOpacity(0.9),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(dx, dy));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
