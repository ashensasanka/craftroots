import 'package:flutter/material.dart';

// Here we defined the textBox to type the texts in the app
class ProfileTextBox extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const ProfileTextBox(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
