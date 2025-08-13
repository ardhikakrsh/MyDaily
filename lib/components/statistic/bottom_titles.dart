import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mydaily/helpers/emoticon_helper.dart';

class BottomTitles extends StatelessWidget {
  final double value;
  final TitleMeta meta;
  final List<String> moodNames;
  const BottomTitles({
    super.key,
    required this.value,
    required this.meta,
    required this.moodNames,
  });

  @override
  Widget build(BuildContext context) {
    final index = value.toInt();
    if (index >= moodNames.length) return const SizedBox.shrink();

    final moodName = moodNames[index];
    final emoticon = getEmoticonForMood(moodName);

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Image.asset(emoticon.imagePath),
    );
  }
}
