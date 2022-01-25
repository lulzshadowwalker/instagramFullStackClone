import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    // we did not use e.g. File(_file.path) because it's from dart:io which is not accessible on web
    return await _file.readAsBytes();
  }
  return null;
  print('No image selcted');
}
