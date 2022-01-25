import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.webLayout,
    required this.mobileLayout,
  }) : super(key: key);

  final Widget webLayout;
  final Widget mobileLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webLayoutWidth) {
          // Web layout
          return webLayout;
        }
        // otherwise, return Mobile Layout
        return mobileLayout;
      },
    );
  }
}
