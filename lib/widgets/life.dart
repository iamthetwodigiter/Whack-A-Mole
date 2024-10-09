import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Life extends StatelessWidget {
  final int lifeCount;
  const Life({
    super.key,
    required this.lifeCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 72,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return index < lifeCount
              ? const Icon(Ionicons.heart, color: Colors.red)
              : const Icon(Icons.heart_broken, color: Colors.red);
        },
      ),
    );
  }
}
