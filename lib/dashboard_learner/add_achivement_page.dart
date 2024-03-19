import 'dart:io';

import 'package:craftroots/dashboard_learner/view_com_achive_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/home_controller.dart';
import 'checkout_page.dart';
import 'get_inspired_page.dart';

class AddAchivementPage extends StatefulWidget {
  const AddAchivementPage({Key? key});

  @override
  State<AddAchivementPage> createState() => _AddAchivementPageState();
}

class _AddAchivementPageState extends State<AddAchivementPage> {
  TextEditingController _textFieldController = TextEditingController();
  File? _image;

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) =>GetBuilder<HomeController>(
  builder: (ctrl){
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Inspired!'),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.grey[300], // Set background color to gray
            borderRadius: BorderRadius.circular(20), // Round the borders
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Text(
                    'Make Your Post',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 130,),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetInspiredPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 60,),
              Text(
                'Add a name to your achievement',
                style: TextStyle(
                  fontSize: 16, // Change the font size to your desired value
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: ctrl.achivementNameCtrl,
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                    filled: true, // Set to true to fill the background
                    fillColor: Colors.white, // Set the background color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5), // Adjust the padding (left, top, right, bottom)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: _getImageFromGallery,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color
                    borderRadius: BorderRadius.circular(20), // Round the borders
                  ),
                  child: _image != null
                      ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  )
                      : Icon(
                    Icons.add_photo_alternate, // Add an icon for image selection
                    size: 100,
                    color: Colors.grey, // Set the icon color
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 55,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetInspiredPage(),
                        ),
                      );
                    },
                    child: Text(
                      '    Clear   ',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black), // Add border color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Add border radius here
                      ),
                    ),
                  ),
                  SizedBox(width: 40,),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.addPost(_image, 'image');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Post Added !'),
                            content: Text('Wait for Admin Aproval'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewComAchivPage(),
                                    ),
                                  );
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      '    Post    ',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffebd9b4),
                      side: BorderSide(color: Colors.white), // Add border color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Add border radius here
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text('Posting as Learner1')
            ],
          ),
        ),
      ),
    );
  });


  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
