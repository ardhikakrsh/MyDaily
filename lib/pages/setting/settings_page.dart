import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydaily/components/sett/list_setting.dart';
import 'package:mydaily/pages/welcome_page.dart';
import 'package:mydaily/widgets/dark_secondary_background.dart';
import 'package:mydaily/widgets/secondary_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          isDarkMode ? DarkSecondaryBackground() : SecondaryBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Color(0xFF1E1E2E) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: isDarkMode
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.grey[200],
                              radius: 30,
                              child: Icon(
                                Icons.person,
                                size: 30,
                                color: isDarkMode
                                    ? Colors.white
                                    : Color(0xFF8B4CFC),
                              ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ardhika Krishna',
                                  style: GoogleFonts.rubik(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'ardhikakrsh@gmail.com',
                                  style: GoogleFonts.rubik(
                                    fontSize: 14,
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.8)
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://i.pinimg.com/1200x/4c/d1/62/4cd162b615c01128fc6d33f7f0317fe6.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(
                                255,
                                219,
                                120,
                                54,
                              ).withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enjoy an ad-free experience and access to exclusive features.',
                              style: GoogleFonts.rubik(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle premium subscription
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Upgrade to Pro',
                                  style: GoogleFonts.rubik(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'General',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListSetting(icon: Icons.account_circle, text: 'Account'),
                      SizedBox(height: 12),
                      ListSetting(
                        icon: Icons.wallet,
                        text: 'Biling & Subscription',
                      ),
                      SizedBox(height: 12),
                      ListSetting(
                        icon: Icons.notifications,
                        text: 'Notifications',
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Alerts',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListSetting(icon: Icons.lock, text: 'Security'),
                      SizedBox(height: 12),
                      ListSetting(icon: Icons.privacy_tip, text: 'Privacy'),
                      SizedBox(height: 20),
                      Text(
                        'Support',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListSetting(icon: Icons.help, text: 'Help Center'),
                      SizedBox(height: 12),
                      ListSetting(icon: Icons.feedback, text: 'Feedback'),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomePage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.redAccent,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Logout',
                                    style: GoogleFonts.rubik(
                                      fontSize: 20,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
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
