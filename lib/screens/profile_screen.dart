import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () => AuthService().signOut(),
      child: const Text('sign out'),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fixedSize: const Size.fromWidth(120)),
    ));
  }
}
