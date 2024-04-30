import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  final CollectionReference community = FirebaseFirestore.instance.collection('community');

  Future<void> deleteNote(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return community.doc(docID).delete();
  }
}
