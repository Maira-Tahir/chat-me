import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_me/components/rounded_button.dart';
import 'package:chat_me/constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: 'Log In',
                onPressed: () async {
                  try {
                    await _auth
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((result) async {
                      debugPrint('uID: ' + result.user!.uid.toString());
                      debugPrint('email: ' + result.user!.email.toString());
                      //create the new user object
                      UserModel _newUser = UserModel(
                          uid: result.user!.uid,
                          email: result.user!.email!,
                          name: nameController.text);
                      //create the user in firestore
                      _createUserFirestore(_newUser, result.user!);
                      emailController.clear();
                      passwordController.clear();
                      // hideLoadingIndicator();
                    });
                  } on FirebaseAuthException catch (error) {
                    // hideLoadingIndicator();
                    debugPrint("The error isss: " + error.message!);
                    // Get.snackbar('auth.signUpErrorTitle'.tr, error.message!,
                    //     snackPosition: SnackPosition.BOTTOM,
                    //     duration: const Duration(seconds: 3),
                    //     backgroundColor:
                    //         Get.theme.snackBarTheme.backgroundColor,
                    //     colorText: Get.theme.snackBarTheme.actionTextColor);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
