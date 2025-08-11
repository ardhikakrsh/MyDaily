import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mydaily/data/notifiers.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:mydaily/pages/welcome_page.dart';
import 'package:mydaily/theme/dark_theme.dart';
import 'package:mydaily/theme/light_theme.dart';

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
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          theme: isDarkMode ? lightTheme : darkTheme,
          debugShowCheckedModeBanner: false,
          title: 'MyDaily',
          home: const WelcomePage(),
        );
      },
    );
  }
}
