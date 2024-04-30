import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/play_video.dart';
import '../widget/stream_note.dart';
import 'add_note_screen.dart';

class TrackLearningPage extends StatefulWidget {
  const TrackLearningPage({super.key});

  @override
  State<TrackLearningPage> createState() => _TrackLearningPageState();
}

bool show = true;

class _TrackLearningPageState extends State<TrackLearningPage> {
  late List<GDPData> _chartdata;
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    _chartdata = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Learning',
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Add_creen(),
            ),
          );
        },
        backgroundColor: Color(0xffebd9b4),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('videos${user?.uid}')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    final videos =
                                        snapshot.data?.docs.reversed.toList();
                                    if (videos == null || videos.isEmpty) {
                                      // If the videos list is empty, display the text
                                      return Column(
                                        children: [
                                          Text(
                                              "Buy a package to access this feature"),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShopPage(),
                                                ),
                                              );
                                            },
                                            child: Text('Go to Shop'),
                                          )
                                        ],
                                      );
                                    } else {
                                      // If the videos list is not empty, display the list of videos
                                      List<Widget> videoWidgets = [];
                                      for (var video in videos) {
                                        final videoWidget = Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    16), // Add space between rows
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: 180,
                                                        height: 115,
                                                        child: Stack(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child:
                                                                  Image.network(
                                                                video['thumb'],
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: double
                                                                    .maxFinite,
                                                                height: 110,
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top:
                                                                  25, // Adjust the position of the icon as needed
                                                              left: 55,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  // Navigate to the video page
                                                                  // Navigator.of(context).push(
                                                                  //   MaterialPageRoute(
                                                                  //     builder: (_) {
                                                                  //       return PlayVideo(
                                                                  //         videoName: video['name'],
                                                                  //         videoURL: video['url'],
                                                                  //       );
                                                                  //     },
                                                                  //   ),
                                                                  // );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .play_circle_fill, // Choose the icon you want
                                                                  size:
                                                                      50, // Adjust the size of the icon as needed
                                                                  color: Colors
                                                                      .white, // Adjust the color of the icon as needed
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            video['name'],
                                                            style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold, // Make the text bold
                                                              fontSize:
                                                                  13, // Increase the font size
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              '( ${video['level']} )'),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              'By : ${video['by']}'),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                        videoWidgets.add(videoWidget);
                                      }
                                      return Expanded(
                                        child: ListView(
                                          children: videoWidgets,
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stream_note(false),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Task You have Completed',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold),
                    ),
                    Stream_note(true),
                    FutureBuilder<int>(
                      future: _fetchUserDataLength(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Stack(
                            children: [
                              SfCircularChart(
                                series: <CircularSeries>[
                                  RadialBarSeries<GDPData, String>(
                                    dataSource: _chartdata,
                                    xValueMapper: (GDPData data, _) =>
                                        data.continent,
                                    yValueMapper: (GDPData data, _) =>
                                        snapshot.data!.toDouble(),
                                    pointColorMapper: (GDPData data, _) =>
                                        data.color,
                                    maximumValue: 100,
                                    innerRadius: '85%',
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 140,
                                left: 170,
                                child: Text(
                                  '${snapshot.data}%', // Show the length as GDP value
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<int> _fetchUserDataLength() async {
    // Fetch data from Firestore and return its length
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('notecount${user?.uid}')
        .get();
    return querySnapshot.size;
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData(
          'TASK', 70, Colors.black), // Set color for each data point if needed
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp, this.color);
  final String continent;
  final int gdp;
  final Color color; // Add a color property
}
