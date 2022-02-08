import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_fullstack_clone/models/user_model.dart';
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
      String photoUrl = await StorageService()
          .uploadImageToStorage(childName: 'profile pictures', file: file);

      LulzUser _user = LulzUser(
        username: username,
        bio: bio,
        email: email,
        userId: userCredential.user!.uid,
        photoUrl: photoUrl,
        following: [],
        followers: [],
      );

      // I think those two check are suffiecient because Firebase checks for the email and password and file cannot be null
      if (username.isNotEmpty && bio.isNotEmpty) {
        String? userId = userCredential.user?.uid;
        await _firestore.collection('users').doc(userId).set(_user.toJson());

        response = 'Sign up successful';
      }
    } catch (err) {
      response = err.toString();
    }

    return response;
  }

  // sign in with email and password
  Future<String> emailSignIn({
    required String email,
    required String password,
  }) async {
    // this deafult value is very unlikely to be ever returned but good practice
    String response = 'some error occured';
    try {
      // field checking can be done using form validators from the UI but whatever
      if (email.isNotEmpty && password.isNotEmpty) {
        // no need to store userCerdentials in this project
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        response = 'rawr, sign in successful';
      } else {
        response = 'provide email/password';
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  // sign out
  void signOut() async {
    await _auth.signOut();
  }

  // get user details
  Future<LulzUser> getUserDetails() async {
    User? currentUser = _auth.currentUser;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    return LulzUser.fromSnap(doc);
  }

  // test to replace change notifier
  // ! depricated
  Stream<LulzUser?> get userDetails {
    String userId = _auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map(LulzUser.fromSnap);
  }
}
