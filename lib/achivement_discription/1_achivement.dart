import 'package:flutter/material.dart';

class FirstAchivement extends StatefulWidget {
  const FirstAchivement({super.key});

  @override
  State<FirstAchivement> createState() => _FirstAchivementState();
}

class _FirstAchivementState extends State<FirstAchivement> {
  List<bool> starPressedState = [false, false, false, false, false];
  void updateStarColors(int index) {
    setState(() {
      for (int i = 0; i <= index; i++) {
        starPressedState[i] = true;
      }
      for (int i = index + 1; i < starPressedState.length; i++) {
        starPressedState[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Achivement One',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/Picture1.png', // Replace 'imageName' with the key holding the image name in your data map
                fit: BoxFit.contain,
                width: double.infinity,
                height: 250,
              ),
            ),

            const SizedBox(height: 20),
            Text(
              'First Achivement',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  Icon(
                    Icons.star,
                    color: i < 3 ? Colors.yellow : Colors.grey.withOpacity(0.5),
                    size: 24,
                  ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    // product.description ?? '',
                    'Hi, I learned Batik through CraftRoots and this is how my first product came out',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Text('Rate this page'),
            Row(
              children: [
                for (int i = 0; i < starPressedState.length; i++)
                  GestureDetector(
                    onTap: () {
                      updateStarColors(i);
                    },
                    child: Icon(
                      Icons.star,
                      color: starPressedState[i]
                          ? Colors.yellow
                          : Colors.grey.withOpacity(0.5),
                      size: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
