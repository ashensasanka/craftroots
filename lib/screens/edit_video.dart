import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

import '../components/text_box.dart';

class EditVideo extends StatefulWidget {
  const EditVideo({super.key, required this.videoURL, required this.videoName, required this.videoBy, required this.videoLevel, required this.videoThumb, required this.videoId});
  final String videoURL;
  final String videoName;
  final String videoBy;
  final String videoLevel;
  final String videoThumb;
  final String videoId;

  @override
  State<EditVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<EditVideo> {
  final userCollection = FirebaseFirestore.instance.collection("videos");
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Edit $field",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: const TextStyle(color: Colors.grey)
            ),
            onChanged: (value){
              newValue = value;
            },
          ),
          actions: [
            TextButton(
                onPressed: ()=> Navigator.pop(context),
                child: const Text('Cancel',
                  style: TextStyle(color: Colors.white),)),
            TextButton(
                onPressed: ()=> Navigator.of(context).pop(newValue),
                child: const Text('Save',
                  style: TextStyle(color: Colors.white),)),
          ],
        ));

    if (newValue.trim().isNotEmpty){
      await userCollection.doc(widget.videoId).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit video'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20,),
                MyTextBox(
                  text: widget.videoName,
                  sectionName: 'name',
                  onPressed: ()=> editField('name'),),
                MyTextBox(
                  text: widget.videoBy,
                  sectionName: 'by',
                  onPressed: ()=> editField('by'),),
                MyTextBox(
                  text: widget.videoLevel,
                  sectionName: 'level',
                  onPressed: ()=> editField('level'),),
                MyTextBox(
                  text: widget.videoThumb,
                  sectionName: 'thumb',
                  onPressed: ()=> editField('thumb'),),
                MyTextBox(
                  text: widget.videoURL,
                  sectionName: 'url',
                  onPressed: ()=> editField('url'),),
                MyTextBox(
                  text: widget.videoId,
                  sectionName: 'ID',
                  onPressed: ()=> editField('id'),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
