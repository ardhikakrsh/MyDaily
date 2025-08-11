import 'package:flutter/material.dart';

class DarkSecondaryBackground extends StatelessWidget {
  const DarkSecondaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xFFD0CFE9),
            Color.fromARGB(255, 223, 148, 178),
            // Color.fromARGB(255, 220, 133, 168),
            Color(0xFF8B4CFC),
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
