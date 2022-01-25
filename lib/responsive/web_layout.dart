import 'package:flutter/material.dart';

// this layout is used for web/desktop
class WebLayout extends StatelessWidget {
  const WebLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      'webLayout',
      style: Theme.of(context).textTheme.bodyText1,
    )));
  }
}
