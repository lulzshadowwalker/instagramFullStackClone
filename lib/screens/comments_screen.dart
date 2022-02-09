import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/models/user_model.dart';
import 'package:instagram_fullstack_clone/providers/user_provider.dart';
import 'package:instagram_fullstack_clone/services/firestore_service.dart';
import 'package:instagram_fullstack_clone/shared/comment_card.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);
  final snap;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  LulzUser? _user;

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  // using StreamProvider and accessign everything from the children is way easier and better imo
  @override
  Widget build(BuildContext context) {
    // probably not the best practice to do it in build but fuk
    _user = Provider.of<UserProvider>(context, listen: false).getUser;

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
              color: mobileBackgroundColor,
              height: kToolbarHeight,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        CachedNetworkImageProvider(_user!.photoUrl),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'comment as ${_user!.username}',
                      hintStyle: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await FirestoreService().postComment(
                        postUserId: widget.snap['userId'],
                        commentUserId: _user!.userId,
                        profilePic: _user!.photoUrl,
                        content: _commentController.text,
                        postId: widget.snap['postId'],
                        username: _user!.username,
                      );
                      _commentController.clear();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Post',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: blueColor),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        body:
            // such a fucking mess hehe + idt its good to do this in the body or build in general
            StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.snap['userId'])
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              print(
                  'users -> ${widget.snap['useId']} -> posts -> ${widget.snap['postId']} -> comments');

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CommentCard(snapshot.data!.docs[index].data());
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ));
  }
}
