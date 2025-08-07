import 'package:flutter/material.dart';

class SecondaryBackground extends StatelessWidget {
  const SecondaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEBE8F2).withOpacity(0.6),
            Color(0xFFE8E2EB),
            Color(0xFFFAF8F7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
