import 'package:flutter/material.dart';
import 'package:teachers_app/utility/constants/colors.dart';

class MyDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userImage;
  final VoidCallback onLogout;

  const MyDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: IKColors.light, // Background color for the entire drawer
        child: Column(
          children: [
            SizedBox(height: 50), // Spacing from top
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(userImage),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Divider(
              color: Colors.black54,
              thickness: 1,
              indent: 40,
              endIndent: 40,
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.black),
              title: Text('Home', style: TextStyle(color: Colors.black)),
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text('Profile', style: TextStyle(color: Colors.black)),
              onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
            ),
            Spacer(), // Push logout button to the bottom
            Divider(
              color: Colors.black54,
              thickness: 1,
              indent: 40,
              endIndent: 40,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: onLogout,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
