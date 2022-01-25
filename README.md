# What I learned
- `LayoutBuilder` is used when you wanna know the size or `constraints` of the parents widget, so it can be used as the parents widget in the `Scaffold` when building a responsive layout
> `constraints.minWidth/height` are (usually) `0` so most of the work would be with `constraints.maxWidth\Height`
- When adding Firebase for web you would have to pass `options` when initializing Firebase but that would break it for mobile, so check for platform first ( you also have to pass `storageBucket` amongst the options if you were going to use FirebaseStorage )
> as-you-type TextEditingController: https://api.flutter.dev/flutter/widgets/TextEditingController-class.html#:~:text=Modifying%20the%20composing,type%20text%20modification. 
> set cursor position at the end of the text: https://stackoverflow.com/questions/56851701/how-to-set-cursor-position-at-the-end-of-the-value-in-flutter-in-textfield


## notable packages

## vscode
### extensions
- (PubspecAssist: https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist) add multiple packages at once ez 
 