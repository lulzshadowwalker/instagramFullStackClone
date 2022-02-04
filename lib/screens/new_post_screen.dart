import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_fullstack_clone/services/storage_service.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:instagram_fullstack_clone/utils/utils.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage() async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: Colors.blue.shade600,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              contentPadding: const EdgeInsets.all(20),
              title: Text(
                'Pick an image',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              children: <SimpleDialogOption>[
                SimpleDialogOption(
                  child: const Text('Camera'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List? file = await pickImage(ImageSource.camera);
                    setState(() =>
                        // because you cant make setState async
                        _file = file);
                  },
                ),
                SimpleDialogOption(
                  child: const Text('Gallery'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List? file = await pickImage(ImageSource.gallery);
                    setState(() =>
                        // because you cant make setState async
                        _file = file);
                  },
                ),
                SimpleDialogOption(
                  child: const Text(
                    'cancel',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    // todo there might be a better way not to enst scaffold's within each other
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('add post', style: Theme.of(context).textTheme.bodyText1),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => StorageService().uploadImageToStorage(
              childName: 'posts',
              file: _file!,
              isPost: true,
            ),
            child: Text(
              'Post',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
        ],
      ),
      body: _file == null
          // * image not yet selected
          ? Center(
              child: IconButton(
                  icon: Icon(
                    Icons.upload_rounded,
                    color: Colors.blue.shade600,
                  ),
                  iconSize: 75,
                  onPressed: () => _selectImage()))
          :
          // * image selected
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        'https://cdn.discordapp.com/attachments/883805503564705803/939057131037003786/RDT_20220203_1021064234842342618388185.jpg',
                      ),
                      radius: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'tell us more!',
                            border: OutlineInputBorder(),
                            // filled: true,
                            // fillColor: Colors.grey[850],
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                // * post-image
                Container(
                  margin: const EdgeInsets.all(12),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(_file!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
    );
  }
}
