import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LulzUser {
  final String username;
  final String bio;
  final String email;
  final String userId;
  final String photoUrl;
  final List<String> following;
  final List<String> followers;

  LulzUser({
    required this.username,
    required this.bio,
    required this.email,
    required this.userId,
    required this.photoUrl,
    required this.following,
    required this.followers,
  });

  // LulzUser to Json
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'bio': bio,
        'email': email,
        'following': following,
        'followers': followers,
        'photoUrl': photoUrl,
      };

  // DocumentSnapshot to LulzUser
  // static so we don't have to instantiate it late and pass all the parameters because it ultimately defeats the point of this function
  static LulzUser fromSnap(DocumentSnapshot snapshot) {
    // or
    // (doc.data() as Map<String, dynamic>) ['username'];
    return LulzUser(
      username: snapshot['username'],
      bio: snapshot['bio'],
      email: snapshot['email'],
      userId: snapshot['userId'],
      photoUrl: snapshot['photoUrl'],
      following: snapshot['following'],
      followers: snapshot['followers'],
    );
  }
}
