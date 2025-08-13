import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mydaily/pages/history/edit_mood.dart';
import 'package:mydaily/helpers/emoticon_helper.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:mydaily/widgets/dark_secondary_background.dart';
import 'package:mydaily/widgets/secondary_background.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime? _selectedDate;
  DateTime? editDate;

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

  void _deleteEntry(MoodEntry entry) {
    entry.delete();
  }

  void _editEntry(MoodEntry entry) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController emoticonController = TextEditingController(
          text: entry.mood,
        );
        final TextEditingController feelingController = TextEditingController(
          text: entry.feeling,
        );
        final TextEditingController reasonController = TextEditingController(
          text: entry.reasonActivity,
        );
        final TextEditingController noteController = TextEditingController(
          text: entry.note,
        );
        final dateController = TextEditingController(
          text: DateFormat('d MMMM, yyyy').format(entry.createdAt),
        );
        return EditMood(
          entry: entry,
          dateController: dateController,
          emoticonController: emoticonController,
          feelingController: feelingController,
          reasonController: reasonController,
          noteController: noteController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBody: true,
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
                      color: isDarkMode
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.4),
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
                          icon: Icon(
                            Icons.calendar_month_rounded,
                            color: isDarkMode
                                ? Color(0xFFB2A5FF)
                                : Color(0xFF8B4CFC),
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
                                color: isDarkMode ? Colors.white : Colors.black,
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
                                color: isDarkMode
                                    ? Color(0xFF1E1E2E)
                                    : Colors.white,
                                elevation: 5,
                                margin: EdgeInsets.symmetric(vertical: 8),
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
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('HH:mm').format(
                                                  filteredEntries[index]
                                                      .createdAt,
                                                ),
                                                style: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.white
                                                            .withOpacity(0.8)
                                                      : Colors.black
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
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                height: 14,
                                                width: 2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: isDarkMode
                                                      ? Colors.white
                                                            .withOpacity(0.6)
                                                      : Colors.black
                                                            .withOpacity(0.4),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              GestureDetector(
                                                onTap: () {
                                                  _editEntry(entry);
                                                },
                                                child: Text(
                                                  'Edit',
                                                  style: GoogleFonts.rubik(
                                                    color: isDarkMode
                                                        ? Color(0xFFB2A5FF)
                                                        : Color(0xFF8B4CFC),
                                                    fontWeight: FontWeight.w500,
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
                                          Text(
                                            DateFormat('d MMMM yyyy').format(
                                              filteredEntries[index].createdAt,
                                            ),
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white.withOpacity(
                                                      0.8,
                                                    )
                                                  : Colors.black.withOpacity(
                                                      0.4,
                                                    ),
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'You felt ',
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 14,
                                                    color: isDarkMode
                                                        ? Colors.white
                                                              .withOpacity(0.8)
                                                        : Colors.black
                                                              .withOpacity(0.6),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: filteredEntries[index]
                                                      .feeling,
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
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
                                                    color: isDarkMode
                                                        ? Colors.white
                                                              .withOpacity(0.8)
                                                        : Colors.black
                                                              .withOpacity(0.6),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: filteredEntries[index]
                                                      .reasonActivity,
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
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
                                                    fontWeight: FontWeight.w500,
                                                    color: isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' ${filteredEntries[index].note}',
                                                  style: GoogleFonts.rubik(
                                                    fontSize: 14,
                                                    color: isDarkMode
                                                        ? Colors.white
                                                              .withOpacity(0.8)
                                                        : Colors.black
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
