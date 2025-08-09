import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mydaily/data/list_emoticon.dart';
import 'package:mydaily/models/emoticon.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:mydaily/widgets/secondary_background.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime? _selectedDate;

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Emoticon getEmoticonForMood(String moodName) {
    return allEmoticons.firstWhere(
      (emoticon) => emoticon.name == moodName,
      orElse: () => allEmoticons.first,
    );
  }

  void _deleteEntry(MoodEntry entry) {
    entry.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SecondaryBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Your History',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.rubik(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_selectedDate != null)
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.redAccent.withOpacity(0.1),
                            ),
                            child: ClipOval(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedDate = null;
                                  });
                                },
                                // 4. Icon di tengah
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),

                        GestureDetector(
                          onTap: () => _pickDate(context),
                          child: Text(
                            _selectedDate == null
                                ? 'All History'
                                : DateFormat(
                                    'd MMMM, yyyy',
                                  ).format(_selectedDate!),
                            style: GoogleFonts.rubik(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xFF8B4CFC),
                          ),
                          onPressed: () => _pickDate(context),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box<MoodEntry>(
                        'moods',
                      ).listenable(),
                      builder: (context, Box<MoodEntry> box, child) {
                        final allEntries = box.values
                            .toList()
                            .cast<MoodEntry>();

                        List<MoodEntry> filteredEntries;

                        if (_selectedDate == null) {
                          filteredEntries = allEntries;
                        } else {
                          filteredEntries = allEntries
                              .where(
                                (entry) =>
                                    isSameDay(entry.createdAt, _selectedDate!),
                              )
                              .toList();
                          filteredEntries.sort(
                            (a, b) => b.createdAt.compareTo(a.createdAt),
                          );
                        }

                        filteredEntries.sort(
                          (a, b) => b.createdAt.compareTo(a.createdAt),
                        );

                        if (filteredEntries.isEmpty) {
                          return Center(
                            child: Text(
                              _selectedDate == null
                                  ? 'You haven\'t recorded any moods yet.'
                                  : 'No mood entries found for this date.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rubik(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: filteredEntries.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final entry = filteredEntries[index];
                              final emoticon = getEmoticonForMood(entry.mood);
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
                                                  filteredEntries[index].mood,
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat(
                                                    'dd MMMM yyyy',
                                                  ).format(
                                                    filteredEntries[index]
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
                                                    text: filteredEntries[index]
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
                                                    text: filteredEntries[index]
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
                                                        ' ${filteredEntries[index].note}',
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
