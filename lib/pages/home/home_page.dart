import 'package:flutter/material.dart';
import 'package:mydaily/components/home/emoji_section.dart';
import 'package:mydaily/components/home/header.dart';
import 'package:mydaily/widgets/secondary_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SecondaryBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 60.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Header(),
                SizedBox(height: 30),

                // Search bar
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: Color(0xFFFADDE7).withOpacity(0.4),
                    fillColor: Colors.white.withOpacity(0.4),
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Emoji section
                EmojiSection(),

                // Card section
              ],
            ),
          ),
        ],
      ),
    );
  }
}
