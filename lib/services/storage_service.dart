import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage({
    required String childName,
    required Uint8List file,
    bool isPost = false,
  }) async {
  // get a reference to the folder structure you wanna save the file in
    Reference reference =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // UploadTask uploadTask =  reference.putData(file);
    // TaskSnapshot snapshot = await uploadTask; this doesnt make sense huh

    TaskSnapshot snapshot = await reference.putData(file);
    return snapshot.ref.getDownloadURL();
  }
}

// create a ref
// upload UploadTask 
// await when its downloaded then return the url
// ( https://flutteragency.com/how-to-upload-image-to-firebase-storage-in-flutter/ )