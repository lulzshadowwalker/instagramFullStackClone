import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/services/auth_service.dart';

// this layout is used for web/desktop
class WebLayout extends StatelessWidget {
  const WebLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: TextButton(
      onPressed: () => AuthService().signOut(),
      child: Text(
        'webLayout',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    )));
  }
}
