import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';

class ProfileCard extends StatefulWidget {
  final bool isHome;
  const ProfileCard({super.key, required this.isHome});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return widget.isHome
        ? Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    userProvider.user!["secure_url"],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    userProvider.user!["name"],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        )
        : Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: IKColors.primary, width: 2),
              ),
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        userProvider.user!["secure_url"],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      userProvider.user!["name"],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.email,
                          size: 25,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          userProvider.user!['email'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          userProvider.user!['phoneNumber'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
  }
}
