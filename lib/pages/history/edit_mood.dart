import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mydaily/data/list_emoticon.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:mydaily/widgets/cancel_button.dart';
import 'package:mydaily/widgets/main_icon_button.dart';

class EditMood extends StatefulWidget {
  final MoodEntry entry;
  final TextEditingController emoticonController;
  final TextEditingController feelingController;
  final TextEditingController reasonController;
  final TextEditingController noteController;
  final TextEditingController dateController;

  const EditMood({
    super.key,
    required this.entry,
    required this.dateController,
    required this.emoticonController,
    required this.feelingController,
    required this.reasonController,
    required this.noteController,
  });

  @override
  State<EditMood> createState() => _EditMoodState();
}

class _EditMoodState extends State<EditMood> {
  DateTime? editDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Mood Entry',
              style: GoogleFonts.rubik(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildMoodSelector(),
            const SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              controller: widget.dateController,
              decoration: InputDecoration(
                labelText: 'Select Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    final newDate = await showDatePicker(
                      context: context,
                      initialDate: editDate ?? widget.entry.createdAt,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );

                    if (newDate != null) {
                      if (!context.mounted) return;

                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          editDate ?? widget.entry.createdAt,
                        ),
                      );

                      if (newTime != null) {
                        final newDateTime = DateTime(
                          newDate.year,
                          newDate.month,
                          newDate.day,
                          newTime.hour,
                          newTime.minute,
                        );

                        setState(() {
                          editDate = newDateTime;
                          widget.dateController.text = DateFormat(
                            'd MMMM, yyyy HH:mm',
                          ).format(editDate!);
                        });
                      }
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: widget.feelingController,
              decoration: InputDecoration(
                labelText: 'You feel',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: widget.reasonController,
              decoration: InputDecoration(
                labelText: 'Reason Activity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: widget.noteController,
              decoration: InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // calendar
            Row(
              children: [
                CancelButton(),
                SizedBox(width: 8),
                Expanded(
                  child: MainIconButton(
                    icon: Icons.check,
                    title: 'Save',
                    onPressed: () {
                      widget.entry.mood = widget.emoticonController.text;
                      widget.entry.note = widget.noteController.text;
                      widget.entry.feeling = widget.feelingController.text;
                      widget.entry.reasonActivity =
                          widget.reasonController.text;
                      widget.entry.createdAt =
                          editDate ?? widget.entry.createdAt;
                      widget.entry.save();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allEmoticons.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final emoticon = allEmoticons[index];
          final isSelected = widget.emoticonController.text == emoticon.name;
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.emoticonController.text = emoticon.name;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? emoticon.color.withOpacity(0.3)
                    : emoticon.color,
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
    );
  }
}
