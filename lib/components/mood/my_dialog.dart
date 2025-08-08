import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydaily/widgets/navigation_menu.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/love.png'),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "You're on a",
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' good way!',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Color(0xFF8B4CFC),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "Your day is going",
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                ' amazing',
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Color(0xFF8B4CFC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Keep tracking your mood to know how to',
                style: GoogleFonts.rubik(color: Colors.grey[600]),
              ),
            ),
            Center(
              child: Text(
                ' improve your mental health.',
                style: GoogleFonts.rubik(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationMenu(),
                  ),
                );
              },
              child: const Text('Got it'),
            ),
          ],
        ),
      ),
    );
  }
}
