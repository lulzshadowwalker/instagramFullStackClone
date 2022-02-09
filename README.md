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
> > get a reference to where you wanna save the file
> > upload it
> > wait till the uploadTask is done and return the downloadUrl
- using `Navigator` might be the best way ( especially with Firebase ) because the state would not presist one solution might be to use a `StreamProvider` that listens to `authStateChanges`
```dart
  Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ));
```
- command palette -> "dart: use recommended settings"
- when debugging on e.g. Chrome or Edge Sign-in state wouldn't be persistent unlike ios simulator or android emulator because it simply creates a new instance every time <br>
- to use e.g. Provider in `initState` which needs a `BuildContext` you need to make sure that it has been inserted into the widget tree first
> for more info: https://stackoverflow.com/questions/56395081/unhandled-exception-inheritfromwidgetofexacttype-localizationsscope-or-inheri <br>
> https://stackoverflow.com/questions/64186001/what-is-the-difference-between-future-delayedduration-zero-and-schedul <br> 
- `MultiProvider` takes a list of providers and you can basically `create` and instantiate a provider and pass it down or "provide" it to the children. also, when creating a new instance of a provider in the providers list, its better to use `create` rather than `value`. You can access the provider from a child widget through e.g. `context.read<T>()` which is similar to `Provider.of<T>(context, listens: false)` except that it cannot be used within a `build` function.
> for more info: https://stackoverflow.com/questions/62432759/why-cant-i-use-context-read-in-build-but-i-can-use-provider-of-with-listen <br> 
or `context.watch<T>()` which is similar to `Provider.of<T>(context, listens: true)` (it's `true` by default) except that unlike `read` it has to be used within the `build` function
> for a little more info about ChangeNotifier and Provider: https://youtu.be/NeAMD0lQ5jw <br> 
> for more info about accessing the `BuildContext` from `initState`: https://youtu.be/NeAMD0lQ5jw <br>
- [interesting, flutter pub add](https://dart.dev/tools/pub/cmd/pub-add)
- one problem with the way you fetch data for the post card is that e.g. the username isnt dynamic meaning that it wouldnt update if the user updates his username, one fix would be to go through all posts and changing the username or simply saving the userId which is immutable and fetch the username from the user document
> `~/` operator means divide and then convert or cast to `int`
- [`viewInsets, 'The parts of the display that are completely obscured by system UI, typically by the device's keyboard.'](https://api.flutter.dev/flutter/widgets/MediaQueryData/viewInsets.html)
## notable packages
- [cached network image](https://pub.dev/packages/cached_network_image)
- [uuid to generate new key values](https://pub.dev/packages/uuid)
- [intl for handling date formats by dart.dev](https://pub.dev/packages/intl)
## vscode
### extensions
- (PubspecAssist: https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist) add multiple packages at once ez 
 
