import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydaily/widgets/dark_secondary_background.dart';
import 'package:mydaily/widgets/navigation_menu.dart';
import 'package:mydaily/widgets/secondary_background.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background sesuai tema
          isDarkMode
              ? const DarkSecondaryBackground()
              : const SecondaryBackground(),

          // Logo di tengah
          Center(
            child: Image.asset(
              'assets/images/logo_mydaily.png',
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
          ),

          // Slide button di bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0, left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: SlideAction(
                  sliderButtonIconPadding: 0.1,
                  innerColor: Colors.transparent,
                  outerColor: isDarkMode
                      ? Colors.deepPurple[200]
                      : Color(0xFFE5DFFB),

                  sliderButtonIcon: Image.asset(
                    'assets/images/facespectacular.png',
                    width: 50,
                    height: 50,
                  ),
                  text: 'Get Started',
                  textStyle: GoogleFonts.poppins(
                    color: Colors.deepPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  submittedIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                  onSubmit: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationMenu(),
                      ),
                    );
                    return null;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
