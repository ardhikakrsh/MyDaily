import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mydaily/components/home/emoji_section.dart';
import 'package:mydaily/components/home/header.dart';
import 'package:mydaily/helpers/emoticon_helper.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:mydaily/pages/mood/mood_page.dart';
import 'package:mydaily/widgets/dark_secondary_background.dart';
import 'package:mydaily/widgets/main_icon_button.dart';
import 'package:mydaily/widgets/secondary_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _deleteEntry(MoodEntry entry) {
    entry.delete();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          isDarkMode ? DarkSecondaryBackground() : SecondaryBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // Header section
                  Header(),
                  SizedBox(height: 30),

                  // Search bar
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      // fillColor: Color(0xFFFADDE7).withOpacity(0.4),
                      fillColor: isDarkMode
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.4),
                      hintText: 'Search...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDarkMode ? Colors.white54 : Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Emoji section
                  EmojiSection(),
                  SizedBox(height: 20),

                  // Add my mood button
                  MainIconButton(
                    icon: Icons.add,
                    title: 'Add My Mood',
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (context) {
                        return MoodPage();
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  // Card section
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box<MoodEntry>(
                        'moods',
                      ).listenable(),
                      builder: (context, Box<MoodEntry> box, child) {
                        final entries = box.values.toList().cast<MoodEntry>();
                        final todayEntries = entries.where((entry) {
                          final now = DateTime.now();
                          return entry.createdAt.year == now.year &&
                              entry.createdAt.month == now.month &&
                              entry.createdAt.day == now.day;
                        }).toList();
                        todayEntries.sort(
                          (a, b) => b.createdAt.compareTo(a.createdAt),
                        );
                        if (todayEntries.isEmpty) {
                          return Center(
                            child: Text(
                              'No mood entries found today',
                              style: GoogleFonts.rubik(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: todayEntries.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final entry = todayEntries[index];
                              final emoticon = getEmoticonForMood(
                                todayEntries[index].mood,
                              );
                              return Card(
                                color: Colors.white,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              emoticon.imagePath,
                                              height: 50,
                                              width: 50,
                                            ),
                                            SizedBox(width: 4),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  todayEntries[index].mood,
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat(
                                                    'd MMMM, yyyy',
                                                  ).format(
                                                    todayEntries[index]
                                                        .createdAt,
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _deleteEntry(entry);
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: GoogleFonts.rubik(
                                                      color: Colors.redAccent,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Container(
                                                  height: 14,
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ),
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                GestureDetector(
                                                  onTap: () {
                                                    print('edit');
                                                  },
                                                  child: Text(
                                                    'Edit',
                                                    style: GoogleFonts.rubik(
                                                      color: Color(0xFF8B4CFC),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'You felt ',
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: todayEntries[index]
                                                        .feeling,
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Because of ',
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: todayEntries[index]
                                                        .reasonActivity,
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Note:',
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${todayEntries[index].note}',
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
