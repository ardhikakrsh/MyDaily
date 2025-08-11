import 'package:flutter/material.dart';
import 'package:mydaily/pages/statistic/statistic_page.dart';

class FilteredToogleButton extends StatelessWidget {
  final TimeRange selectedRange;
  final ValueChanged<TimeRange> onRangeSelected;

  const FilteredToogleButton({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: ToggleButtons(
        isSelected: [
          selectedRange == TimeRange.weekly,
          selectedRange == TimeRange.monthly,
          selectedRange == TimeRange.allTime,
        ],
        onPressed: (index) {
          if (index == 0) onRangeSelected(TimeRange.weekly);
          if (index == 1) onRangeSelected(TimeRange.monthly);
          if (index == 2) onRangeSelected(TimeRange.allTime);
        },
        borderRadius: BorderRadius.circular(12),
        selectedColor: isDarkMode ? Colors.black : Colors.white,
        fillColor: isDarkMode ? Color(0xFFB2A5FF) : const Color(0xFF8B4CFC),
        color: isDarkMode ? Colors.white : const Color(0xFF8B4CFC),
        constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
        children: const [Text('Weekly'), Text('Monthly'), Text('All Time')],
      ),
    );
  }
}
