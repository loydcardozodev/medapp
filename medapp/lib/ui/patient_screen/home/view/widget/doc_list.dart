import 'package:flutter/material.dart';

class DocList extends StatelessWidget {
  final String name;
  final String type;
  final String image;

  const DocList({
    super.key,
    required this.name,
    required this.type,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        child: Row(
          children: [
            const SizedBox(width: 10),

            CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),

            const SizedBox(width: 15),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  type,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
