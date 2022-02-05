import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/screens/home_screen.dart';
import 'package:instagram_fullstack_clone/screens/sign_up_screen.dart';
import 'package:instagram_fullstack_clone/services/auth_service.dart';
import 'package:instagram_fullstack_clone/shared/input_field.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:instagram_fullstack_clone/utils/image_links.dart';
import 'package:instagram_fullstack_clone/utils/utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // using a [Form] and [FormTextFields would be more efficient here but no harm in trying new stuff ^^
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  // @override
  // void initState() {
  //   super.initState();
  //   _emailController.addListener(() {
  //     // "Modifying the composing region from within a listener can also have a bad interaction with some input methods.
  //     // Gboard, for example, will try to restore the composing region of the text if it was modified programmatically,
  //     // creating an infinite loop of communications between the framework and the input method. Consider using
  //     // TextInputFormatters instead for as-you-type text modification."
  //     String cutieString = _emailController.value.text;
  //     cutieString = cutieString.replaceAll('aus', 'Cutie');
  //     cutieString =
  //         cutieString.replaceAll('Taye', 'dat girl from zouth africa');
  //     cutieString = cutieString.replaceAll('alex', 'english fookin twat');

  //     _emailController.value = _emailController.value.copyWith(
  //         text: cutieString,
  //         selection: TextSelection.fromPosition(
  //             TextPosition(offset: cutieString.length)),
  //         composing: TextRange(start: 0, end: cutieString.length));
  //   });
  // }

  // clear up resources when controllers are no longer needed
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void signInUser() async {
      setState(() => _isLoading = true);

      String response = await AuthService().emailSignIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() => _isLoading = false);
      if (response == 'rawr, sign in successful') {
        // todo something :D
      }
      giveSnackBar(context, response);
    }

    // todo remove Scaffold when no longer needed
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: logoInstagram,
                        height: 256,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      InputField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'e-mail',
                      ),
                      const SizedBox(height: 24),
                      InputField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        hintText: 'password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      // todo hehe maybe change it to an [ElevatedButton]
                      InkWell(
                          onTap: signInUser,
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive())
                              : Container(
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  width: double.infinity,
                                  decoration: ShapeDecoration(
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      )),
                                  child: const Text('Sign in'))),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Don\'t have an account ? ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              // inkwell aligns better with the other text than a TextButton
                              InkWell(
                                onTap: () => navigateReplacementTo(
                                    context, const SignUpScreen()),
                                child: Text(
                                  'Sign up ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: blueColor),
                                ),
                              ),
                            ]),
                      ))
                    ],
                  ),
                ))));
  }
}
