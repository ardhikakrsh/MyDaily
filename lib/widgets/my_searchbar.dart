import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydaily/themes/app_colors.dart';

class MySearchBar extends StatelessWidget {
  final Color fillColor;
  const MySearchBar({super.key, required this.fillColor});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        filled: true,
        fillColor: fillColor,
        hintText: 'Search...',
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isDarkMode ? AppColors.black05 : AppColors.black04,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.black01.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xFFB2A5FF) : Color(0xFF8B4CFC),
            width: 1.2,
          ),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: isDarkMode ? AppColors.black05 : AppColors.black04,
        ),
      ),
    );
  }
}
