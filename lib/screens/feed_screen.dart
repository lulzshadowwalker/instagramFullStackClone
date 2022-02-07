import 'package:cached_network_image/cached_network_image.dart';
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
      body: const FeedPostCard(),
    );
  }
}
