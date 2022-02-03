# What I learned
- `LayoutBuilder` is used when you wanna know the size or `constraints` of the parents widget, so it can be used as the parents widget in the `Scaffold` when building a responsive layout
> `constraints.minWidth/height` are (usually) `0` so most of the work would be with `constraints.maxWidth\Height`
- When adding Firebase for web you would have to pass `options` when initializing Firebase but that would break it for mobile, so check for platform first ( you also have to pass `storageBucket` amongst the options if you were going to use FirebaseStorage )
> as-you-type TextEditingController: https://api.flutter.dev/flutter/widgets/TextEditingController-class.html#:~:text=Modifying%20the%20composing,type%20text%20modification.<br>
> set cursor position at the end of the text: https://stackoverflow.com/questions/56851701/how-to-set-cursor-position-at-the-end-of-the-value-in-flutter-in-textfield
- you can either "set" or "add" a document e.g.
```dart
// set
_firestore.collection('myCollection').doc('').set({}); 
// add
_firestore.collection('myCollection').add({}); 

```
and the main difference is that `doc` allows you to set the document id while add sets up a random id \\
- uploading to a FirestoreStorage ( https://flutteragency.com/how-to-upload-image-to-firebase-storage-in-flutter/ )
> summary
> get a reference to where you wanna save the file
> upload it
> wait till the uploadTask is done and return the downloadUrl
- using `Navigator` might be the best way ( especially with Firebase ) because the state would not presist one solution might be to use a `StreamProvider` that listens to `authStateChanges`
```dart
  Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ));
```
- command palette -> "dart: use recommended settings"


## notable packages

## vscode
### extensions
- (PubspecAssist: https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist) add multiple packages at once ez 
 
