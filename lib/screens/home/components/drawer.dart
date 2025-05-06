import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    String userName = userProvider.user!["name"];
    String userEmail = userProvider.user!["email"];
    String userImage = userProvider.user!["secure_url"];

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
              onTap:
                  () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/home'),
                  },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text('Profile', style: TextStyle(color: Colors.black)),
              onTap:
                  () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/profile'),
                  },
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.black),
              title: Text('Reports', style: TextStyle(color: Colors.black)),
              onTap:
                  () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/report'),
                  },
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.black),
              title: Text('Module PDF', style: TextStyle(color: Colors.black)),
              onTap:
                  () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/module'),
                  },
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
              onTap:
                  () => {
                    userProvider.logout(),
                    Navigator.pushNamed(context, '/login'),
                  },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
