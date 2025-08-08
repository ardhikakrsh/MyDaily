// lib/pages/mood/mood_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mydaily/components/mood/my_dialog.dart';
import 'package:mydaily/data/list_emoticon.dart';
import 'package:mydaily/models/emoticon.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:intl/intl.dart';
import 'package:mydaily/widgets/main_icon_button.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  final _pageController = PageController();
  final _feelingController = TextEditingController();
  final _reasonActivityController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Emoticon? _selectedEmoticon;
  int _currentPageIndex = 0;
  final int _totalPages = 5;

  @override
  void dispose() {
    _pageController.dispose();
    _feelingController.dispose();
    _reasonActivityController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _nextPage() {
    if (_currentPageIndex == 1 && _selectedEmoticon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood first!')),
      );
      return;
    }

    if (_currentPageIndex == 2 && _feelingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your feeling!')),
      );
      return;
    }

    if (_currentPageIndex == 3 && _reasonActivityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please describe the reason or activity!'),
        ),
      );
      return;
    }

    if (_currentPageIndex == 4 && _noteController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please write your note!')));
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _saveMoodEntry() {
    final newEntry = MoodEntry(
      mood: _selectedEmoticon!.name,
      feeling: _feelingController.text,
      reasonActivity: _reasonActivityController.text,
      note: _noteController.text,
      createdAt: _selectedDate,
    );
    final box = Hive.box<MoodEntry>('moods');
    box.add(newEntry);
    showDialog(context: context, builder: (context) => MyDialog());
  }

  Widget _buildNavigationButton() {
    bool isLastPage = _currentPageIndex == _totalPages - 1;
    return MainIconButton(
      icon: isLastPage ? Icons.emoji_emotions : Icons.navigate_next,
      title: isLastPage ? 'Save My Mood' : 'Next',
      onPressed: isLastPage ? _saveMoodEntry : _nextPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Color(0xFFE7F0F3),
            Color(0xFFDBE8EF),
            Color(0xFFD8DEF6),
            Color(0xFFE5E2F4),
            Color(0xFFF8F9FE),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                _buildDatePickerPage(),
                _buildMoodSelectionPage(),
                _buildTextFieldPage(
                  question: 'What did you feel?',
                  description:
                      'After selecting your mood that reflects how you felt, please describe it in more detail.',
                  controller: _feelingController,
                  hint: 'e.g., Disappointed',
                ),
                _buildTextFieldPage(
                  question:
                      'What was the reason or activity that led to this mood?',
                  description: 'Please describe the reason or activity',
                  controller: _reasonActivityController,
                  hint: 'e.g., Work',
                ),
                _buildTextFieldPage(
                  question: 'Your Note',
                  description:
                      'If you have any additional notes or thoughts about your mood today, please write them here.',
                  controller: _noteController,
                  hint: 'Tell me more...',
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                if (_currentPageIndex > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        const SizedBox(width: 40),
        Text(
          '${_currentPageIndex + 1}/$_totalPages',
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerPage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Date & Time',
                      style: GoogleFonts.rubik(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      // Format Aug 8, 2025, 10:30 AM
                      DateFormat.yMMMd().add_jm().format(_selectedDate),
                      style: GoogleFonts.rubik(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // Tombol untuk mengubah waktu
                IconButton(
                  icon: const Icon(
                    Icons.edit_calendar_outlined,
                    color: Color(0xFF8B4CFC),
                  ),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
          ),
          CalendarDatePicker(
            initialDate: _selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
            onDateChanged: (newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
          _buildNavigationButton(),
        ],
      ),
    );
  }

  Widget _buildMoodSelectionPage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'What is your mood today?',
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Select an emoticon that reflects the most how',
                style: GoogleFonts.rubik(color: Colors.grey[600]),
              ),
              Text(
                'you are feeling at this moment.',
                style: GoogleFonts.rubik(color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(
            height: 80,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 16,
              ),
              itemCount: allEmoticons.length,
              itemBuilder: (context, index) {
                final emoticon = allEmoticons[index];
                final isSelected = _selectedEmoticon?.name == emoticon.name;
                return GestureDetector(
                  onTap: () => setState(() => _selectedEmoticon = emoticon),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? emoticon.color.withOpacity(0.5)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(color: emoticon.color, width: 2)
                          : null,
                    ),
                    child: Image.asset(emoticon.imagePath),
                  ),
                );
              },
            ),
          ),
          _buildNavigationButton(),
        ],
      ),
    );
  }

  Widget _buildTextFieldPage({
    required String question,
    required String description,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                question,
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: GoogleFonts.rubik(color: Colors.grey[600]),
              ),
            ],
          ),
          TextField(
            controller: controller,
            minLines: 1,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            autofocus: true,
          ),
          _buildNavigationButton(),
        ],
      ),
    );
  }
}
