import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_fullstack_clone/providers/user_provider.dart';
import 'package:instagram_fullstack_clone/responsive/mobile_layout.dart';
import 'package:instagram_fullstack_clone/responsive/responsive_layout.dart';
import 'package:instagram_fullstack_clone/responsive/web_layout.dart';
import 'package:instagram_fullstack_clone/screens/sign_in_screen.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Instagram Fullstack Clone',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
            textTheme: TextTheme(bodyText1: GoogleFonts.ubuntu())),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // if connection is active and snapshot has data (signed in)
                // alternatively we can probably just null-check the [User] that is being returned
                // which is better because without it (which is what we're doing here) we'll end up with
                // redundant code for showing home screen on sign-in/up so using a wrapper on main is better imo
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    mobileLayout: MobileLayout(),
                    webLayout: WebLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SigninScreen();
            }),
      ),
    );
  }
}
