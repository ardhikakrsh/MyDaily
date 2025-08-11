import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const MainIconButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: isDarkMode ? Colors.black : Colors.white),
        label: Text(
          title,
          style: GoogleFonts.rubik(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.black : Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Color(0xFFB2A5FF) : Color(0xFF8B4CFC),
          shadowColor: isDarkMode
              ? Color(0xFFB2A5FF).withOpacity(0.6)
              : Color(0xFF8B4CFC).withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: GoogleFonts.rubik(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
