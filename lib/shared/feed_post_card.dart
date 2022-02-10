import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/screens/comments_screen.dart';
import 'package:instagram_fullstack_clone/services/firestore_service.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class FeedPostCard extends StatefulWidget {
  const FeedPostCard(this.postData, this.postDocId, {Key? key})
      : super(key: key);
  final Map<String, dynamic>? postData;
  final String? postDocId;

  @override
  State<FeedPostCard> createState() => _FeedPostCardState();
}

class _FeedPostCardState extends State<FeedPostCard> {
  bool _like = false;
  int _commentLength = 0;

  @override
  void initState() {
    super.initState();
    print(
        'users -> ${widget.postData?['userId']} -> posts -> ${widget.postData?['postId']} -> comments ');

    getCommentLength();
  }

  void getCommentLength() async {
    // listening to a stream is better because it'd be real time
    QuerySnapshot comments = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.postData?['userId'])
        .collection('posts')
        .doc(widget.postData?['postId'])
        .collection('comments')
        .get();

    _commentLength = comments.docs.length;
    setState(() {});
  }

  void _likePost() async {
    setState(() => _like = !_like);
    await FirestoreService()
        .likePost(widget.postData?['userId'], widget.postDocId, _like);
    print('doc new value: ${widget.postData?['likes']}');
    print(
        'uid: ${widget.postData?['userId']}, postId: ${widget.postData?['postId']}');
  }

  void _feedMoreButton(BuildContext context) {
    List<Widget> actions = [
      InkWell(
        onTap: () async => await FirestoreService().deletePost(
          userId: widget.postData?['userId'],
          postId: widget.postData?['postId'],
          context: context,
        ),
        child: ListTile(
            leading: const Icon(Icons.delete, color: Colors.black),
            title: Text('delete',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold))),
      ),
      InkWell(
        // * this one should be available only to the post owner but who cares it doesnt work anyway hehe :D
        onTap: () {},
        child: ListTile(
            leading: const Icon(Icons.edit, color: Colors.black),
            title: Text('edit',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold))),
      )
    ];

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Container(
            height: 380,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: false,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: actions,
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * header section
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                    .copyWith(right: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: CachedNetworkImageProvider(
                        widget.postData?['pfpImage'] ??
                            'https://bit.ly/3HDtqOd',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.postData?['username'] ?? 'username',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert_rounded),
                      onPressed: () => _feedMoreButton(context),
                    )
                  ],
                )),
            // * Image Section

            SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: CachedNetworkImage(
                    imageUrl:
                        widget.postData?['postUrl'] ?? 'https://bit.ly/3HDtqOd',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover)),
            // * interaction section

            Row(
              children: [
                IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: _likePost,
                    icon: Icon(
                      widget.postData?['likes']
                              .contains(widget.postData?['userId'])
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.postData?['likes']
                              .contains(widget.postData?['userId'])
                          ? Colors.red
                          : Colors.grey[300],
                    )),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CommentsScreen(snap: widget.postData))),
                  icon: const Icon(
                    Icons.comment,
                  ),
                ),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                  ),
                ),
              ],
            ),
            // * description
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Text(
                  '${widget.postData?['likes'].length} likes',
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(
                        text: '${widget.postData?['username']}\t',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: widget.postData?['description'] ??
                              'everything in life seems to be stuttering'),
                    ]),
              ),
            ),
            const SizedBox(height: 5),

            InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CommentsScreen(snap: widget.postData))),
                    child: Text(
                      'view all $_commentLength comments',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: secondaryColor),
                    ),
                  ),
                )),
            // * code and paddings here are very messy ik whatever
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                DateFormat.yMMMd()
                    .format(widget.postData?['datePublished'].toDate() ?? ''),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: secondaryColor.withOpacity(0.6), fontSize: 12),
              ),
            )
          ],
        ));
  }
}
