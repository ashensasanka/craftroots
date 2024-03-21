import 'dart:io';
import 'package:craftroots/pages/user_type_page.dart';
import 'package:craftroots/resources/save_video.dart';
import 'package:craftroots/screens/video_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

import '../dashboard_admin/add_package_page.dart';
import '../dashboard_admin/add_video_page.dart';
import '../dashboard_admin/approve_post.dart';
import '../dashboard_admin/artisan_report_page.dart';
import '../dashboard_admin/artisan_selection_page.dart';
import '../dashboard_admin/dp_report_page.dart';
import '../dashboard_admin/dp_selection_page.dart';
import '../dashboard_admin/edit_video_list.dart';
import '../dashboard_admin/vendor_report_page.dart';
import '../dashboard_admin/vendor_selection_page.dart';
import '../utils/utils.dart';

class DashBoardAdmin extends StatefulWidget {
  const DashBoardAdmin({super.key});

  @override
  State<DashBoardAdmin> createState() => _DashBoardAdminState();
}

class _DashBoardAdminState extends State<DashBoardAdmin> {
  String? _videoURL;
  VideoPlayerController? _controller;
  String? _downloadURL;
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin_Dashboard'),
        actions: [
          IconButton(
            onPressed: () async {
              // Sign out the current user
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to the login screen or home screen after sign out
                // Example:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserTypePage(),
                  ),
                );
              } catch (e) {
                print('Error signing out: $e');
                // Handle signout error
              }
            },
            icon: const Icon(Icons.logout), // Change the icon to your signout icon
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Shop
            Text(
              'Shop',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: 5),
            //Add Package
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPackagePage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Add Package',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8,),
            //Update Package
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AddPackagePage()), // Replace NextPage with the name of your next page widget
                  // );
                },
                child: Text(
                  'Update Package',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8,),
            //Delete Package
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AddPackagePage()), // Replace NextPage with the name of your next page widget
                  // );
                },
                child: Text(
                  'Delete Package',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            Divider(thickness: 2,endIndent: 30,indent: 30,color: Colors.black,),
            //Reimbursement Report
            Text(
              'Reimbursement Report',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: 10),
            //Generate Vendor Report
            Container(
              height: 30,
              width: 203,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VendorSelectionPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Generate Vendor Report',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8,),
            //Generate Artisan Report
            Container(
              height: 30,
              width: 203,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArtisanSelectionPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Generate Artisan Report',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8,),
            //Generate DP Report
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DPSelectionPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Generate DP Report',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            Divider(thickness: 2,endIndent: 30,indent: 30,color: Colors.black,),
            //Learning Material
            Text(
              'Learning Material',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: 10),
            //Add video
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddVideoPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Add video',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8,),
            //Update video
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditVideoList()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Update video',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8,),
            //Delete video
            Divider(thickness: 2,endIndent: 30,indent: 30,color: Colors.black,),
            //Approve Account
            Text(
              'Approve Account',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: 10),
            //Add video
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPackagePage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Vendor',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            Divider(thickness: 2,endIndent: 30,indent: 30,color: Colors.black,),
            Text(
              'Community Activities',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApprovePostPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Approve Posts',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffebd9b4)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            // _videoURL != null ? _videoPreviewWidget() : Text('No Video Selected'),
          ],
        ),
      ),
    );
  }

  void _pickVideo() async {
    _videoURL = await pickVideo();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }
}
