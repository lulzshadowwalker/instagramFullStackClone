import 'package:cloud_firestore/cloud_firestore.dart';

class LulzPost {
  final String description;
  final String userId;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String pfpImage;
  final String postUrl;
  final likes;

  LulzPost({
    required this.description,
    required this.userId,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.pfpImage,
    required this.postUrl,
    required this.likes,
  });

  // LulzPost to Json
  Map<String, dynamic> toJson() => {
        'description': description,
        'userId': userId,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
        'pfpImage': pfpImage,
        'postUrl': postUrl,
        'likes': likes
      };

  // DocumentSnapshot to LulzPost
  // static so we don't have to instantiate it late and pass all the parameters because it ultimately defeats the point of this function
  static LulzPost fromSnap(DocumentSnapshot snapshot) {
    // or

    // (doc.data() as Map<String, dynamic>) ['username'];
    return LulzPost(
      description: snapshot['description'],
      userId: snapshot['userId'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      pfpImage: snapshot['pfpImage'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
    );
  }
}
