import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_fullstack_clone/models/post.dart';
import 'package:instagram_fullstack_clone/services/storage_service.dart';
import 'package:instagram_fullstack_clone/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // * upload post
  Future<String> uploadPost({
    required String description,
    required Uint8List file,
    required String userId,
    required String username,
    required String pfpImage,
  }) async {
    String response = 'some error occurred';
    try {
      String postUrl = await StorageService()
          .uploadImageToStorage(childName: 'posts', file: file, isPost: true);

      // * generate unique post key based on current time
      String postId = const Uuid().v4();
      LulzPost post = LulzPost(
          description: description,
          userId: userId,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          pfpImage: pfpImage,
          postUrl: postUrl,
          likes: []);
      // * save the post in a sub-collection of userId
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('posts')
          .doc(postId)
          .set(post.toJson());

      // * probably better to use enum here
      response = 'Post upload successful!';
    } catch (err) {
      response = err.toString();
    }

    return response;
  }

  // register a like
  // this function wouldnt be called if postId is null
  Future<void> likePost(String userId, String? postId, bool isLiked) async {
    try {
      if (!isLiked) {
        print('liking post');
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayRemove([userId])
        });
        print('liked post');
      } else {
        print('unliking post');
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayUnion([userId])
        });
        print('unliked post');
      }
    } catch (e) {
      print({'[FOK] ${e.toString()}'});
    }
  }

  // upload comment
  // probably better to dynamically fetch the username using userId in-case some user changes the username
  Future<void> postComment({
    required String postUserId,
    required String commentUserId,
    required String profilePic,
    required String content,
    required String postId,
    required String username,
  }) async {
    try {
      if (content.isNotEmpty) {
        // generate doc id key
        String commentDocId = const Uuid().v1();

        // hehe ik
        _firestore
            .collection('users')
            .doc(postUserId)
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentDocId)
            .set({
          'username': username,
          'postUserId': postUserId,
          'commentUserId': commentUserId,
          'profilePic': profilePic,
          'content': content,
          'postId': postId,
          'datePublished': DateTime.now()
        });
        print('loolz all good');
      } else {
        print('no content in comment, comment is empty');
      }
    } catch (e) {
      print('fukfuk');
      print(e.toString());
    }
  }

  // delete a post
  Future<void> deletePost({
    required String userId,
    required String postId,
    required BuildContext context,
  }) async {
    String response = 'unknown error occured';
    try {
      // you might also wanna delete it from storage but im not gonna bother me lazy very
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('posts')
          .doc(postId)
          .delete();
      response = 'deleted post';
    } catch (e) {
      response = e.toString();
    }
    giveSnackBar(context, response);
    Navigator.of(context).pop();
  }
} // end firestore service
