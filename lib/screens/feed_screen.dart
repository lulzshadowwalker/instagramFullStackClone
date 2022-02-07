import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/shared/feed_post_card.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: CachedNetworkImage(
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/2560px-Instagram_logo.svg.png',
            filterQuality: FilterQuality.low,
            fit: BoxFit.fill,
            height: AppBar().preferredSize.height * 0.8,
            color: Colors.white,
          ),
          actions: const [
            Icon(Icons.messenger_outline),
            SizedBox(width: 10),
          ],
        ),
        // not the best way ik
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  // or simply use var or dynamic
                  QueryDocumentSnapshot<Map<String, dynamic>> doc =
                      snapshot.data!.docs[index];

                  return FeedPostCard();
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
