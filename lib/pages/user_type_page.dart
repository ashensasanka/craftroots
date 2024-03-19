import 'package:craftroots/auth_pages/learner_auth.dart';
import 'package:craftroots/pages/disp_login_page.dart';
import 'package:craftroots/pages/learner_login_page.dart';
import 'package:craftroots/pages/vendor_login_page.dart';
import 'package:flutter/material.dart';
import 'admin_login_page.dart';
import 'learner_register_page.dart';

class UserTypePage extends StatefulWidget {
  const UserTypePage({super.key});

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(200), // Adjust the radius value to change the roundness
                  child: Image.asset('assets/logo.jpeg'),
                ),
                //Learner
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnerAuthPage(userType:'learner')),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 250,
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
                        gradient: LinearGradient(colors: [
                          Color(0xfff9efdb),
                          Color(0xffebd9b4)
                        ])),
                    child: Text('Learner',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.75),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //Dispatch Partner
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnerAuthPage(userType:'dispatch')),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 250,
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
                        gradient: LinearGradient(colors: [
                          Color(0xfff9efdb),
                          Color(0xffebd9b4)
                        ])),
                    child: Text('Dispatch Partner',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.75),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //Vendor
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnerAuthPage(userType:'vendor')),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 250,
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
                        gradient: LinearGradient(colors: [
                          Color(0xfff9efdb),
                          Color(0xffebd9b4)
                        ])),
                    child: Text('Vendor',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.75),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLoginPage()),
                    );
                  },
                  child: Text(
                    'Admin login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
