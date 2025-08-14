import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydaily/widgets/dark_secondary_background.dart';
import 'package:mydaily/widgets/navigation_menu.dart';
import 'package:mydaily/widgets/secondary_background.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          isDarkMode
              ? const DarkSecondaryBackground()
              : const SecondaryBackground(),
          Center(
            child: Image.asset(
              'assets/images/logo_mydaily.png',
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60.0, left: 30, right: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationMenu(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      letterSpacing: 2,
                      color: isDarkMode ? Color(0xFFB2A5FF) : Color(0xFF8B4CFC),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
