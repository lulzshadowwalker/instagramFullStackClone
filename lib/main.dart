import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_fullstack_clone/screens/sign_in_screen.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Checking for playtform because passing [options] when running on mobile would break it
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyA5eiWtlcgXvOOkFwv8_K7hPOTPi6AuIJI',
            appId: '1:1036285357733:web:8fee7368b9adc12f38674c',
            messagingSenderId: '1036285357733',
            projectId: 'instagramfullstackclone',
            storageBucket: 'instagramfullstackclone.appspot.com'));
  }
  // considering that the project isnt going to be deployed for desktop, atm at least
  else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Instagram Fullstack Clone',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
            textTheme: TextTheme(bodyText1: GoogleFonts.ubuntu())),
        debugShowCheckedModeBanner: false,
        // home: const ResponsiveLayout(
        //   mobileLayout: MobileLayout(),
        //   webLayout: WebLayout(),
        home: const SigninScreen());
  }
}
