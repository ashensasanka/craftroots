import 'package:craftroots/dashboard_learner/view_com_achive_page.dart';
import 'package:flutter/material.dart';

import 'add_achivement_page.dart';

class GetInspiredPage extends StatefulWidget {
  const GetInspiredPage({super.key});

  @override
  State<GetInspiredPage> createState() => _GetInspiredPageState();
}

class _GetInspiredPageState extends State<GetInspiredPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Inspired!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your existing content here
            SizedBox(
              height: 80,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewComAchivPage(),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                        Center(
                          child: Text(
                            "View Community Achievement",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffebd9b4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        spreadRadius: 3, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 3), // Offset of shadow
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 80,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAchivementPage(),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          "Add your Achievement",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffebd9b4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        spreadRadius: 3, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 3), // Offset of shadow
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
