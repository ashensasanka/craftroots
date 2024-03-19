import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final String name;
  final String imageUrl;
  final Function onTap;

  const ProductCard({
    Key? key,
    required this.name,
    required this.imageUrl,
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 120,
              ),
              const SizedBox(height: 9),
              Text(
                firstPart,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
