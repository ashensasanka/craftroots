import 'package:flutter/material.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  final List<Map<String, dynamic>> users = [
    {'name': 'Ashvin', 'score': 100},
    {'name': 'Aakeef', 'score': 90},
    {'name': 'Marickar', 'score': 80},
    {'name': 'Kaveesha', 'score': 70},
    {'name': 'User 5', 'score': 60},
    {'name': 'User 6', 'score': 50},
    {'name': 'User 7', 'score': 40},
    {'name': 'User 8', 'score': 30},
    {'name': 'User 9', 'score': 20},
    {'name': 'User 10', 'score': 10},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leader Board'),
      ),
      body: Column(
        children: [// Add space for the AppBar
          _buildLeaderCard(1, users[0]),
          Row(
            children: [
              SizedBox(width: 30.0),
              _buildLeaderCard(2, users[1]),
              SizedBox(width: 40.0),
              _buildLeaderCard(3, users[2]),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: users.length-3,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index+3];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 4).toString()),
                  ),
                  title: Text(user['name']),
                  trailing: Text('${user['score']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderCard(int place, Map<String, dynamic> user) {
    return Container(
      width: 150,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with user profile picture
              ),
              Container(
                padding: EdgeInsets.all(9.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  place.toString(),
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            user['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Score: ${user['score']}',
          ),
        ],
      ),
    );
  }

}
