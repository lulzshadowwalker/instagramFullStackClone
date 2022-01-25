import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/shared/input_field.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:instagram_fullstack_clone/utils/image_links.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // using a [Form] and [FormTextFields would be more efficient here but no harm in trying new stuff ^^
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void asYouType(TextEditingController controller) {
    // "Modifying the composing region from within a listener can also have a bad interaction with some input methods.
    // Gboard, for example, will try to restore the composing region of the text if it was modified programmatically,
    // creating an infinite loop of communications between the framework and the input method. Consider using
    // TextInputFormatters instead for as-you-type text modification."
    String cutieString = controller.value.text;
    cutieString = cutieString.replaceAll('aus', 'Cutie');
    controller.value = controller.value.copyWith(
        text: cutieString,
        selection: TextSelection.fromPosition(
            TextPosition(offset: cutieString.length)),
        composing: TextRange(start: 0, end: cutieString.length));
  }

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() => asYouType(_userNameController));
    _bioController.addListener(() => asYouType(_bioController));
    _emailController.addListener(() => asYouType(_emailController));
  }

  // clear up resources when controllers are no longer needed
  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      // * Circular avatar profilePicture
                      Stack(children: [
                        const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              NetworkImage('https://bit.ly/3tYoz5V'),
                        ),
                        Positioned(
                            child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo),
                        ))
                      ]),
                      const SizedBox(height: 28),
                      // * userName
                      InputField(
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        hintText: 'username',
                      ),
                      const SizedBox(height: 24),
                      // * bio
                      InputField(
                        controller: _bioController,
                        keyboardType: TextInputType.text,
                        hintText: 'bio',
                      ),
                      const SizedBox(height: 24),
                      // * e-mail
                      InputField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'e-mail',
                      ),
                      const SizedBox(height: 24),
                      // * password
                      InputField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        hintText: 'password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      // todo hehe maybe change it to an [ElevatedButton]
                      InkWell(
                          onTap: () {},
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                              child: const Text('Sign up'))),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'already have an account ? ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              // todo maake it a textbutton im lazy now
                              Text(
                                'Sign in ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: blueColor),
                              ),
                            ]),
                      )
                    ],
                  ),
                ))));
  }
}
