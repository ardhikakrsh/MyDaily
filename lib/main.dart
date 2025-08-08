import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:mydaily/pages/welcome_page.dart';

void main() async {
  // init hive
  await Hive.initFlutter();

  // create adapters
  Hive.registerAdapter(MoodEntryAdapter());

  // open box
  await Hive.openBox<MoodEntry>('moods');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      title: 'MyDaily',
      home: const WelcomePage(),
    );
  }
}
