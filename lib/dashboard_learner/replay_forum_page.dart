import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'forum_page.dart';

class ReplayPage extends StatefulWidget {
  final String message;
  const ReplayPage({Key? key, required this.message}) : super(key: key);

  @override
  State<ReplayPage> createState() => _ReplayPageState();
}

class _ReplayPageState extends State<ReplayPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final messageCollection = FirebaseFirestore.instance.collection("replay_message");

  void editMessage(int index, String field) async {
    String newValue = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit Message",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          controller: TextEditingController(text: newValue),
          decoration: InputDecoration(
            hintText: "Enter new message",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context, newValue); // Pop with newValue as result
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ).then((value) async { // Wait for dialog result
      if (value != null && value.trim().isNotEmpty) {
        await messageCollection.doc(field).update({'message': value});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Forum'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ), // Add your icon here
              label: Text(
                'Back to all question',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffebd9b4), // Change button color to black
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 5, 10),
            child: Container(
              width: 370,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(
                  20,
                ), // Adjust the radius as needed
              ), // Gray background color for sent messages
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 280,
                    height: 70,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                      child: Text(widget.message),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Text('data'),
                        SizedBox(
                          width: 20,
                        ),
                        Text('data'),
                        SizedBox(
                          width: 20,
                        ),
                        Text('data'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('replay_message').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final List<DocumentSnapshot> documents1 = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents1.length,
                  itemBuilder: (context, index) {
                    final message = documents1[index]['message'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ), // Adjust the radius as needed
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person_pin,
                                      size: 50, // Adjust the size of the icon as needed
                                      color: Colors.black, // Adjust the color of the icon as needed
                                    ),
                                    Text('data'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 280,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(
                                  20,
                                ), // Adjust the radius as needed
                              ), // Gray background color for sent messages
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 70,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
                                          child: Text(message),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => editMessage(index,message),
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text('data'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('data'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('data'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                );
              },
          ),


          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.person_pin_circle_outlined, size: 35),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final message = _messageController.text;
                    if (message.isNotEmpty) {
                      _firestore.collection('replay_message').doc(message).set({
                        'message': message,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      _messageController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffebd9b4), // Change button color to black
                  ),
                  child: Text('Send',style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
