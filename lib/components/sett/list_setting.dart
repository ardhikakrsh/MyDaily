import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListSetting extends StatelessWidget {
  final IconData icon;
  final String text;
  const ListSetting({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF1E1E2E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Color(0xFF1E1E2E).withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDarkMode ? Colors.white : Color(0xFF8B4CFC),
        ),
        title: Text(
          text,
          style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        onTap: () {},
      ),
    );
  }
}
