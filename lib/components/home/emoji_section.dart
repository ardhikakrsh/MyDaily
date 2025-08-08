import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydaily/components/home/emoticon_face.dart';
import 'package:mydaily/components/home/emoticon_message.dart';
import 'package:mydaily/data/list_emoticon.dart';

class EmojiSection extends StatelessWidget {
  const EmojiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How do you feel?',
          style: GoogleFonts.rubik(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: allEmoticons.sublist(0, 3).map((emoticon) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => EmoticonMessage(
                    bgcolor: emoticon.color,
                    title: emoticon.name,
                    message: emoticon.message,
                  ),
                );
              },
              child: EmoticonFace(
                urlEmoticon: emoticon.imagePath,
                color: emoticon.color,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: allEmoticons.sublist(3, 6).map((emoticon) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => EmoticonMessage(
                    bgcolor: emoticon.color,
                    title: emoticon.name,
                    message: emoticon.message,
                  ),
                );
              },
              child: EmoticonFace(
                urlEmoticon: emoticon.imagePath,
                color: emoticon.color,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
