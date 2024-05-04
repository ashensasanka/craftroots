import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/firestor.dart';
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

                              StreamBuilder(
                                stream: Firestore_Datasource().stream(false),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    final noteslist = Firestore_Datasource().getNotes(snapshot);
                                    if (noteslist.length == 0) {
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
                                      return SizedBox(width: 10,);
                                    }
                                  }
                                },
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
                          int value = snapshot.data!.toInt();
                          return Stack(
                            children: [
                              SfCircularChart(
                                series: <CircularSeries>[
                                  RadialBarSeries<GDPData, String>(
                                    dataSource: _chartdata,
                                    xValueMapper: (GDPData data, _) =>
                                        data.continent,
                                    yValueMapper: (GDPData data, _) =>
                                        value,
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
                                  '${value}%', // Show the length as GDP value
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
