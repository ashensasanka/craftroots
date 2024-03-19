import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/replay_forum_page.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final messageCollection = FirebaseFirestore.instance.collection("replay_message");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Forum'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('community').snapshots(),
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
                              width: 280,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 280,
                                    height: 70,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(15, 10, 5, 0),
                                      child: Text(
                                        message,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: _firestore.collection('learner_users').snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text('Error: ${snapshot.error}'));
                                        }
                                        final List<DocumentSnapshot> documents = snapshot.data!.docs;
                                        return Padding(
                                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Text('${documents[index]['name']}'),
                                              SizedBox(width: 10),
                                              Text('${DateTime.now().toString().split(' ')[0]}'),
                                              SizedBox(width: 20),
                                              Text('${snapshot.data!.size} answers'),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 100,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReplayPage(message: message),
                                      ),
                                    );
                                    print('Reply to message: $message');
                                  },
                                  child: Text('Reply'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
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
                      _firestore.collection('community').add({
                        'message': message,
                        'timestamp': Timestamp.now(),
                      });
                      _messageController.clear();
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
