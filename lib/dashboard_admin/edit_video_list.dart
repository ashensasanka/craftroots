import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/screens/play_video.dart';
import 'package:flutter/material.dart';

import '../screens/edit_video.dart';

class EditVideoList extends StatefulWidget {
  const EditVideoList({super.key});

  @override
  State<EditVideoList> createState() => _VideoListState();
}

class _VideoListState extends State<EditVideoList> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Videos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {}); // Refresh the UI when the text changes
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          30.0), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('videos')
                    .where('name',
                        isGreaterThanOrEqualTo: _searchController.text)
                    .where('name', isLessThan: _searchController.text + 'z')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Widget> videoWidgets = [];
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final videos = snapshot.data?.docs.reversed.toList();
                    for (var video in videos!) {
                      final videoWidget = Column(
                        children: [
                          SizedBox(height: 16), // Add space between rows
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              video['thumb'],
                                              fit: BoxFit.cover,
                                              width: double.maxFinite,
                                              height: 110,
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
                                            fontWeight: FontWeight.bold, // Make the text bold
                                            fontSize: 13, // Increase the font size
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text('( ${video['level']} )'),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (_) {
                                                          return EditVideo(
                                                            videoName: video['name'],
                                                            videoBy:video['by'],
                                                            videoURL: video['url'],
                                                            videoLevel: video['level'],
                                                            videoThumb: video['thumb'],
                                                            videoId:video.id
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Text('Edit',
                                                    style: TextStyle(
                                                      fontSize: 20, // Adjust the font size of the text as needed
                                                      fontWeight: FontWeight.bold, // Optionally adjust the font weight
                                                    ),),
                                                ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _deleteVideo(video.id); // Call the delete function with the document ID
                                              },
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                  color: Colors.red, // Optionally adjust the color of the icon
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
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
                  }
                  return Expanded(
                    child: ListView(
                      children: videoWidgets,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _deleteVideo(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('videos').doc(docId).delete();
      // Refresh the UI by resetting the stream
      setState(() {});
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
