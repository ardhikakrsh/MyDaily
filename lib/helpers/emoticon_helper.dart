import 'package:mydaily/data/list_emoticon.dart';
import 'package:mydaily/models/emoticon.dart';

Emoticon getEmoticonForMood(String moodName) {
  return allEmoticons.firstWhere(
    (e) => e.name == moodName,
    orElse: () => allEmoticons.first,
  );
}
