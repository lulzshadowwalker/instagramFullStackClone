import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/shared/feed_post_card.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                shrinkWrap: false,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  String docId = snapshot.data!.docs[index].id;

                  return StreamBuilder(
                      stream: _firestore
                          .collection('users')
                          .doc(docId)
                          .collection('posts')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic>? postData =
                                    snapshot.data?.docs[index].data();

                                if (postData == null ) {
                                  return Container();
                                }
                                return  FeedPostCard(postData);
                              });
                        } else {
                          return Container();
                        }
                      });
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
