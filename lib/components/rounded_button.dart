import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  // const RoundedButton({
  //   Key? key,
  // }) : super(key: key);

  RoundedButton(
      {required this.color, required this.title, required this.onPressed});

  final Color color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        // color: Colors.lightBlueAccent,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          // onPressed: () {
          //   //Go to login screen.
          //   Navigator.pushNamed(context, LoginScreen.id);
          // },
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            // 'Log In',
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
