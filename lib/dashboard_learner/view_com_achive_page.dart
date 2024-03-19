import 'package:flutter/material.dart';

import '../achivement_discription/1_achivement.dart';
import '../achivement_discription/2_achivement.dart';
import '../achivement_discription/3_achivement.dart';
import 'confirm_order_page.dart';
import 'leader_board_page.dart';

class ViewComAchivPage extends StatefulWidget {
  const ViewComAchivPage({Key? key});

  @override
  State<ViewComAchivPage> createState() => _ViewComAchivPageState();
}

class _ViewComAchivPageState extends State<ViewComAchivPage> {
  List<bool> starPressedState1 = [false, false, false, false, false];
  List<bool> starPressedState2 = [false, false, false, false, false];
  List<bool> starPressedState3 = [false, false, false, false, false];
  int touchedStarIndex1 = -1;
  int touchedStarIndex2 = -1;
  int touchedStarIndex3 = -1;
  void updateStarColors1(int index) {
    setState(() {
      for (int i = 0; i <= index; i++) {
        starPressedState1[i] = true;
      }
      for (int i = index + 1; i < starPressedState1.length; i++) {
        starPressedState1[i] = false;
      }
    });
  }
  void updateStarColors2(int index) {
    setState(() {
      for (int i = 0; i <= index; i++) {
        starPressedState2[i] = true;
      }
      for (int i = index + 1; i < starPressedState2.length; i++) {
        starPressedState2[i] = false;
      }
    });
  }
  void updateStarColors3(int index) {
    setState(() {
      for (int i = 0; i <= index; i++) {
        starPressedState3[i] = true;
      }
      for (int i = index + 1; i < starPressedState3.length; i++) {
        starPressedState3[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Inspired!'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 190,),
              Container(
                width: 195,
                height: 25,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaderBoardPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffebd9b4), // Change button color to black
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Set the desired border radius
                    ),
                  ),
                  child: Row(// Align children to start and end
                    children: [
                      Text(
                        'View Leader Board ',
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text('Post Made by You',
            style: TextStyle(fontSize: 17),),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 400,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: Image
                    Container(
                      width: 100,
                      height: 110,
                      child:
                          Image.asset('assets/Picture1.png', fit: BoxFit.cover),
                    ),
                    SizedBox(width: 16),

                    // Right side: Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            'Learner1',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Description
                          Text(
                            'Hi, I learned Batik through CraftRoots and this is how my first product came out',
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // updateStarColors(i);
                                        // touchedStarIndex = i;
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: i < 3 ? Colors.yellow : Colors.grey.withOpacity(0.5),
                                            size: 24,
                                          ),
                                          SizedBox(height: 10),
                                          // if (i == touchedStarIndex)
                                          //   Container(
                                          //     width: 40,
                                          //     height: 4,
                                          //     color: Colors.black,
                                          //   ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 10),
                                    // Text(touchedStarIndex == i ? '${(i + 1) * 20}%' : ''),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Text('Community Post'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FirstAchivement()),
                          );
                        },
                        child: Container(
                          width: 360,
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left side: Image
                                Container(
                                  width: 100,
                                  height: 110,
                                  child:
                                  Image.asset('assets/Picture1.png', fit: BoxFit.cover),
                                ),
                                SizedBox(width: 16),
                                // Right side: Description
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        'Learner1',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      // Description
                                      Text(
                                        'Hi, I learned Batik through CraftRoots and this is how my first product came out',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 0; i < starPressedState1.length; i++)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    updateStarColors1(i);
                                                    touchedStarIndex1 = i;
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: starPressedState1[i]
                                                            ? Colors.yellow
                                                            : Colors.grey.withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      SizedBox(height: 10),
                                                      if (starPressedState1[i])
                                                        Container(
                                                          width: 40,
                                                          height: 4,
                                                          color: Colors.black,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(touchedStarIndex1 == i
                                                    ? '${(i + 1) * 20}%'
                                                    : ''),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SecondAchivement()),
                          );
                        },
                        child: Container(
                          width: 360,
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left side: Image
                                Container(
                                  width: 100,
                                  height: 110,
                                  child:
                                  Image.asset('assets/Picture1.png', fit: BoxFit.cover),
                                ),
                                SizedBox(width: 16),

                                // Right side: Description
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        'Learner1',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      // Description
                                      Text(
                                        'Hi, I learned Batik through CraftRoots and this is how my first product came out',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 0; i < starPressedState2.length; i++)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    updateStarColors2(i);
                                                    touchedStarIndex2 = i;
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: starPressedState2[i]
                                                            ? Colors.yellow
                                                            : Colors.grey.withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      SizedBox(height: 10),
                                                      if (starPressedState2[i])
                                                        Container(
                                                          width: 40,
                                                          height: 4,
                                                          color: Colors.black,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(touchedStarIndex2 == i
                                                    ? '${(i + 1) * 20}%'
                                                    : ''),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ThirdAchivement()),
                          );
                        },
                        child: Container(
                          width: 360,
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left side: Image
                                Container(
                                  width: 100,
                                  height: 110,
                                  child:
                                  Image.asset('assets/Picture1.png', fit: BoxFit.cover),
                                ),
                                SizedBox(width: 16),

                                // Right side: Description
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        'Learner1',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      // Description
                                      Text(
                                        'Hi, I learned Batik through CraftRoots and this is how my first product came out',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 0; i < starPressedState3.length; i++)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    updateStarColors3(i);
                                                    touchedStarIndex3 = i;
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: starPressedState3[i]
                                                            ? Colors.yellow
                                                            : Colors.grey.withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      SizedBox(height: 10),
                                                      if (starPressedState3[i])
                                                        Container(
                                                          width: 40,
                                                          height: 4,
                                                          color: Colors.black,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(touchedStarIndex3 == i
                                                    ? '${(i + 1) * 20}%'
                                                    : ''),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
