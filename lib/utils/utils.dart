import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// pick an image
Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    // we did not use e.g. File(_file.path) because it's from dart:io which is not accessible on web
    return await _file.readAsBytes();
  }
  print('No image selcted');
  return null;
}

// snackbar
giveSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

// navigate to page ( to avoid the repetition of the boilerplate code )
void navigateReplacementTo(BuildContext context, Widget widget) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}
