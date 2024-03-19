import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final int index;
  final String name;
  final Function onTap;

  const UserCard({
    Key? key,
    required this.name,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> nameParts = name.split(',');
    String firstPart = nameParts[0].trim();
    String secondPart = nameParts.length > 1 ? nameParts[1].trim() : '';

    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                firstPart,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              if (secondPart.isNotEmpty)
                Text(
                  secondPart,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
