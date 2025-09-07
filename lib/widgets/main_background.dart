import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 134, 139, 151).withOpacity(0.6),
            Color(0xFFFFCEB7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
