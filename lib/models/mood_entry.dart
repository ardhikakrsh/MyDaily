import 'package:hive/hive.dart';

// Jalankan `flutter packages pub run build_runner build` untuk generate file ini
part 'mood_entry.g.dart';

@HiveType(typeId: 0)
class MoodEntry extends HiveObject {
  @HiveField(0)
  late String mood;

  @HiveField(1)
  late String feeling;

  @HiveField(2)
  late String reasonActivity;

  @HiveField(3)
  late String note;

  @HiveField(4)
  late DateTime createdAt;

  MoodEntry({
    required this.mood,
    required this.feeling,
    required this.reasonActivity,
    required this.note,
    required this.createdAt,
  });
}
