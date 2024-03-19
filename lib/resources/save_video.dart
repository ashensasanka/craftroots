import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{
  Future<String> uploadVideo(String videoUrl) async{
    Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoUrl));
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
  
  Future<void> saveVideoData(String videoDownloadUrl,
      String name,
      String level,
      String by,
      String thumb)async{
    await _firestore.collection('videos').add({
      'url':videoDownloadUrl,
      'timeStamp': FieldValue.serverTimestamp(),
      'name':name,
      'level':level,
      'by':by,
      'thumb':thumb
    });
  }
}