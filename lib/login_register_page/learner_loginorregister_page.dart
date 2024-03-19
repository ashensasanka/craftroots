import 'package:craftroots/pages/learner_login_page.dart';
import 'package:flutter/material.dart';

import '../pages/learner_register_page.dart';
import '../pages/vendor_login_page.dart';


class LearnerLoginOrRegisterPage extends StatefulWidget {
  final String userType;
  const LearnerLoginOrRegisterPage({super.key, required this.userType});

  @override
  State<LearnerLoginOrRegisterPage> createState() => _LearnerLoginOrRegisterPageState();
}


class _LearnerLoginOrRegisterPageState extends State<LearnerLoginOrRegisterPage> {
  // initially  show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userType=='vendor') {
      return VendorLoginPage(userType: widget.userType);
    } else {
      return LearnerLoginPage(onTop: togglePages, userType: widget.userType,);
    }
  }
}
