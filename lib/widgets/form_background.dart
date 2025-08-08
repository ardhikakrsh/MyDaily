import 'package:flutter/material.dart';

class FormBackground extends StatelessWidget {
  const FormBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE7F0F3),
            Color(0xFFDBE8EF),
            Color(0xFFD8DEF6),
            Color(0xFFE5E2F4),
            Color(0xFFF8F9FE),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
