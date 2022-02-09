import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_fullstack_clone/models/user_model.dart';
import 'package:instagram_fullstack_clone/providers/user_provider.dart';
import 'package:instagram_fullstack_clone/services/firestore_service.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:instagram_fullstack_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  LulzUser? _user;
  bool _isLoading = false;

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

  getFuckingUser() {
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    _user = _userProvider.getUser;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (mounted) {
        getFuckingUser();
      }
    });
  }

  void _uploadPost() async {
    setState(() => _isLoading = true);

    String response = await FirestoreService().uploadPost(
        description: _descriptionController.text,
        file: _file!,
        userId: _user!.userId,
        username: _user!.username,
        pfpImage: _user!.photoUrl);

    setState(() {
      _isLoading = false;
      _file = null;
    });
    giveSnackBar(context, response);
  }

  @override
  Widget build(BuildContext context) {
    getFuckingUser();
    // todo there might be a better way not to enst scaffold's within each other
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _file = null),
        ),
        title: Text('add post', style: Theme.of(context).textTheme.bodyText1),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _uploadPost,
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
                _isLoading == true
                    ? const LinearProgressIndicator()
                    : Container(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        _user!.photoUrl,
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
