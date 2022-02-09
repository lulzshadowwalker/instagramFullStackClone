import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(this.commentData, {Key? key}) : super(key: key);
  final dynamic commentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(commentData['profilePic']),
            radius: 18),
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText1,
            children: [
              TextSpan(
                text: '${commentData['username']}\t',
                style: Theme.of(context)
                    .textTheme  
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: commentData['content'])
            ],
          ),
        ),
        dense: true,
        subtitle: Text(
          DateFormat.yMMMd().format(commentData['datePublished'].toDate()),
          style: TextStyle(color: Colors.white.withOpacity(0.6)),
        ),
        trailing: const Icon(Icons.favorite_border),
      ),
    );
  }
}
