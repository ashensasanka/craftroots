import 'dart:async';

import 'package:craftroots/pages/dashboard_vendor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_)=>checkEmailVerified(),
      );
    }
  }
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) => isEmailVerified
      ? DashBoardVendor()
      : Scaffold(
          appBar: AppBar(
            title: Text('verify Email'),
        ),
          body: Center(
            child: SizedBox(
              height: 470,
              child: Container(
                width: 337,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                        children: [
                          Text(
                            'Alert!',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10), // Add some space between the texts
                          Text(
                            'Registration completed, Please \nwait for admin approval \n(an email will be sent)',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 19
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffEEEEEE).withOpacity(.8),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

  );
}
