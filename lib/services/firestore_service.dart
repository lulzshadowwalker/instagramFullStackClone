import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_fullstack_clone/models/post.dart';
import 'package:instagram_fullstack_clone/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      String postId = const Uuid().v1();
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
          .doc()
          .set(post.toJson());

      // * probably better to use enum here
      response = 'Post upload successful!';
    } catch (err) {
      response = err.toString();
    }

    return response;
  }
}
