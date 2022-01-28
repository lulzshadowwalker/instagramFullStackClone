import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/providers/user_provider.dart';
import 'package:instagram_fullstack_clone/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    Key? key,
    required this.webLayout,
    required this.mobileLayout,
  }) : super(key: key);

  final Widget webLayout;
  final Widget mobileLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webLayoutWidth) {
          // Web layout
          return widget.webLayout;
        }
        // otherwise, return Mobile Layout
        return widget.mobileLayout;
      },
    );
  }
}
