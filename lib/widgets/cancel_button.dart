import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        side: BorderSide(
          color: isDarkMode ? Color(0xFFB2A5FF) : Color(0xFF8B4CFC),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'Cancel',
        style: GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
