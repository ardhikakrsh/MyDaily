import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mydaily/components/statistic/bottom_titles.dart';
import 'package:mydaily/components/statistic/filtered_toogle_button.dart';
import 'package:mydaily/data/list_emoticon.dart';
import 'package:mydaily/helpers/emoticon_helper.dart';
import 'package:mydaily/models/mood_entry.dart';
import 'package:mydaily/widgets/dark_secondary_background.dart';
import 'package:mydaily/widgets/secondary_background.dart';

enum TimeRange { weekly, monthly, allTime }

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  TimeRange _selectedRange = TimeRange.weekly;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          isDarkMode ? DarkSecondaryBackground() : SecondaryBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mood Chart',
                    style: GoogleFonts.rubik(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your mood paterns from:\n${_selectedRange == TimeRange.weekly
                        ? "${DateFormat('d MMM, yyyy').format(DateTime.now().subtract(const Duration(days: 7)))} - ${DateFormat('d MMM, yyyy').format(DateTime.now())}"
                        : _selectedRange == TimeRange.monthly
                        ? "${DateFormat('d MMM, yyyy').format(DateTime.now().subtract(const Duration(days: 30)))} - ${DateFormat('d MMM, yyyy').format(DateTime.now())}"
                        : "Semua waktu"}',
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilteredToogleButton(
                    selectedRange: _selectedRange,
                    onRangeSelected: (range) {
                      setState(() {
                        _selectedRange = range;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xFF2C2A3A) : Color(0xFFE5DFFB),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF8B4CFC).withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box<MoodEntry>(
                          'moods',
                        ).listenable(),
                        builder: (context, Box<MoodEntry> box, _) {
                          final allEntries = box.values.toList();
                          List<MoodEntry> filteredEntries;

                          switch (_selectedRange) {
                            case TimeRange.weekly:
                              final sevenDaysAgo = DateTime.now().subtract(
                                const Duration(days: 7),
                              );
                              filteredEntries = allEntries.where((entry) {
                                return entry.createdAt.isAfter(sevenDaysAgo);
                              }).toList();
                              break;

                            case TimeRange.monthly:
                              final thirtyDaysAgo = DateTime.now().subtract(
                                const Duration(days: 30),
                              );
                              filteredEntries = allEntries.where((entry) {
                                return entry.createdAt.isAfter(thirtyDaysAgo);
                              }).toList();
                              break;

                            case TimeRange.allTime:
                              filteredEntries = allEntries;
                              break;
                          }

                          // 2. hitung jumlah tiap mood
                          final moodScores = <String, int>{};
                          for (var emoticon in allEmoticons) {
                            moodScores[emoticon.name] = 0;
                          }

                          // 3. Hitung skor untuk setiap mood
                          for (var entry in filteredEntries) {
                            moodScores.update(entry.mood, (value) => value + 1);
                          }

                          if (filteredEntries.isEmpty) {
                            return const Center(
                              child: Text("No data in the last 7 days."),
                            );
                          }

                          return BarChart(
                            buildChartData(moodScores),
                            swapAnimationDuration: const Duration(
                              milliseconds: 250,
                            ),
                          );
                        },
                      ),
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

  // 5. Fungsi utama untuk membangun data chart
  BarChartData buildChartData(Map<String, int> moodScores) {
    final orderedMoodNames = allEmoticons.map((e) => e.name).toList();
    final maxValue = moodScores.values.isEmpty
        ? 1
        : moodScores.values.reduce((a, b) => a > b ? a : b);

    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) =>
              getEmoticonForMood(orderedMoodNames[group.x.toInt()]).color,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: 10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final moodName = orderedMoodNames[group.x.toInt()];
            final count = rod.toY.toInt();
            return BarTooltipItem(
              '$moodName\n',
              GoogleFonts.rubik(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: '$count ${count > 1 ? "times" : "time"}',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
      alignment: BarChartAlignment.spaceAround,
      maxY: (maxValue == 0 ? 5 : maxValue).toDouble() + 2,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            getTitlesWidget: (value, meta) => BottomTitles(
              value: value,
              meta: meta,
              moodNames: orderedMoodNames,
            ),
          ),
        ),
      ),
      barGroups: List.generate(orderedMoodNames.length, (index) {
        final moodName = orderedMoodNames[index];
        final emoticonData = getEmoticonForMood(moodName);
        final count = moodScores[moodName] ?? 0;

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: emoticonData.color,
              width: 25,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: moodScores.values.reduce((a, b) => a > b ? a : b) + 1,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        );
      }),
    );
  }
}
