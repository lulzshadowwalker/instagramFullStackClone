import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  // using StreamProvider and accessign everything from the children is way easier and better imo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
            color: Colors.white,
            height: kToolbarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange,
                )
              ],
            )),
      ),
    );
  }
}
