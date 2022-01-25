import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_fullstack_clone/services/storage_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firestore insatance for storing user data when signing up
  // maybe use a function from DatabaseService just for the sake of organizing
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up with email and password
  Future<String> emailSignUp({
    required String username,
    required String bio,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String response = 'something went wrong';
    try {
      // register a new user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // before saving userdata in Firestore we have to make sure to save the pfp in the storage
      String photourl = await StorageService()
          .uploadImageToStorage(childName: 'profile pictures', file: file);

      // I think those two check are suffiecient because Firebase checks for the email and password and file cannot be null
      if (username.isNotEmpty && bio.isNotEmpty) {
        String? userId = userCredential.user?.uid;
        await _firestore.collection('users').doc(userId).set({
          'userId': userId,
          'username': username,
          'bio': bio,
          'email': email,
          'following': [],
          'followers': [],
          'photoUrl': photourl
        });

        response = 'Sign up successful';
      }
    } catch (err) {
      response = err.toString();
    }

    return response;
  }

  // sign in with email and password
  void emailSignIn({required String email, required String password}) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
