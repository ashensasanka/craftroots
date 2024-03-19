import 'package:flutter/material.dart';
// Here we defined the textBox to type the texts in the app
class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({super.key,required this.onPressed, required this.text, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.only(
          left: 15,
          bottom: 15
      ),
      margin: const EdgeInsets.only(left: 10, right: 10,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName,
                style: TextStyle(color: Colors.grey[900]),),
              IconButton(onPressed: onPressed, icon: const Icon(Icons.settings))
            ],
          ),
          Text(text,style: TextStyle(color: Colors.black),)
        ],
      ),
    );
  }
}
