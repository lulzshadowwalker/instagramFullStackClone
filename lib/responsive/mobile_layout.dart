import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      'mobileLayout',
      style: Theme.of(context).textTheme.bodyText1,
    )));
  }
}
