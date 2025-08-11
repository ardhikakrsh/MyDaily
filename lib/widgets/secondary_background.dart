import 'package:flutter/material.dart';

class SecondaryBackground extends StatelessWidget {
  const SecondaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE5DFFB),
            Color(0xFFDBE8EF),
            Color(0xFFE8E2EB),
            Color(0xFFF2E2E2),
            Color(0xFFFAF8F7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
