import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/pages/vendor_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../auth_pages/learner_auth.dart';
import '../widget/multi_select_drop_down.dart';
import 'dashboard_learner.dart';

class VendorRegisterPage extends StatefulWidget {
  final String userType;
  const VendorRegisterPage({super.key, required this.userType});

  @override
  State<VendorRegisterPage> createState() => _VendorRegisterPageState();
}

class _VendorRegisterPageState extends State<VendorRegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController pass = TextEditingController();
  List<String> selectedItems = [];

  postDetailsToFirestore(List<String> selectedItems) async {
    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    // CollectionReference ref_rool = FirebaseFirestore.instance.collection('user_rool');
    CollectionReference learner_register = FirebaseFirestore.instance.collection('learner_users');
    // ref_rool.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
    learner_register.doc(user!.email).set({
      'email':emailctrl.text,
      'name':name.text,
      'password':pass.text,
      'address':'',
      'contact':'',
      'city':'',
      'cardholder_name':'',
      'card_number':'',
      'expire_date':'',
      'roal':widget.userType,
      'selectedItems':selectedItems.join(',')
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LearnerAuthPage(userType: widget.userType,)));
  }

  void signUserUp(List<String> selectedItems) async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // try creating the user
    try {
      // check if password is confirmed
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailctrl.text,
        password: pass.text,
      ).then((value) => {postDetailsToFirestore(selectedItems)}).catchError((e){});

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMesaage(e.code);
    }
  }

  // error message to user
  void showErrorMesaage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )),
          );
        });
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text('Register to get \nstarted with \nCraftRoots!',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),),
                const SizedBox(
                  height: 40,
                ),
                //Enter Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: name,
                    style: const TextStyle(color: Colors.black, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                        const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.alternate_email_outlined,
                          color: Colors.black,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Name',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                            const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                            const BorderSide(color: Colors.black))),
                  ),
                ),
                //Enter Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: emailctrl,
                    style: const TextStyle(color: Colors.black, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                        const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.alternate_email_outlined,
                          color: Colors.black,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                            const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                            const BorderSide(color: Colors.black))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Enter password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: pass,
                    style: const TextStyle(color: Colors.black, fontSize: 14.5),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIconConstraints:
                        const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 22,
                        ),
                        suffixIconConstraints:
                        const BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                            const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                            const BorderSide(color: Colors.black))),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(bottom: 5),
                  child: MultiSelectDropDown(
                    items: const [
                      'Knitting and crocheting (Yarn, Crochet Hook, Needle)',
                      'Batik (Fabric, Wax, Dye, Canting Pen)',
                      'Pottery (Potter Wheel, Clay, Glazes, Potter Needle, Cut-Off Wire, Application Brush)',
                      'Reed mat weaving (Reed Stalks, Jute Yarn, Wooden Mallet, Wooden Comb, Hand Loom)'
                    ],
                    onSelectionChanged: (selectedItems) {
                      setState(() {
                        this.selectedItems = selectedItems; // Update the list of selected items
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Signup Button
                GestureDetector(
                  onTap: () {
                    signUserUp(selectedItems);
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black),
                    child: Text('Signup',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Already have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 13)),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VendorLoginPage(userType: widget.userType,)),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
