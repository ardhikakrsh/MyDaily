import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mydaily/data/notifiers.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Dhika!',
              style: GoogleFonts.rubik(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              DateFormat('d MMMM, yyyy').format(DateTime.now()),
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.6)
                    : Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),

        Row(
          children: [
            _buildIconButton(
              onPressed: () {
                isDarkModeNotifier.value = !isDarkModeNotifier.value;
              },
              icon: ValueListenableBuilder(
                valueListenable: isDarkModeNotifier,
                builder: (context, isDarkMode, child) {
                  return Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: const Color(0xFF8B4CFC),
                  );
                },
              ),
            ),
            SizedBox(width: 10),
            _buildIconButton(
              onPressed: () {
                print('Notification icon tapped!');
              },
              icon: const Icon(Icons.notifications, color: Color(0xFF8B4CFC)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required VoidCallback onPressed,
    required Widget icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IconButton(onPressed: onPressed, icon: icon, iconSize: 24),
      ),
    );
  }
}
