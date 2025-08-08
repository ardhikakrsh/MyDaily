import 'dart:ui';

import 'package:mydaily/models/emoticon.dart';

class ListEmoticon {
  final List<Emoticon> allEmoticons = [
    Emoticon(
      name: 'Spectacular',
      message: 'You are doing great! Keep it up!',
      imagePath: 'assets/images/spectacular.png',
      color: Color(0xFFFFA7BC),
    ),
    Emoticon(
      name: 'Happy',
      message: 'Keep smiling and spreading joy!',
      imagePath: 'assets/images/happy.png',
      color: Color(0xFFDFEBFF),
    ),
    Emoticon(
      name: 'Good',
      message: 'You are doing well, stay positive!',
      imagePath: 'assets/images/good.png',
      color: Color(0xFFFDDD6F),
    ),
    Emoticon(
      name: 'Sad',
      message: 'It\'s okay to feel sad sometimes.',
      imagePath: 'assets/images/sad.png',
      color: Color(0xFFA1E7EB),
    ),
    Emoticon(
      name: 'Upset',
      message: 'Take a deep breath, it will pass.',
      imagePath: 'assets/images/upset.png',
      color: Color(0xFF8CA4EE),
    ),
    Emoticon(
      name: 'Angry',
      message: 'It\'s okay to feel angry, just let it out.',
      imagePath: 'assets/images/angry.png',
      color: Color(0xFFFF843E),
    ),
  ];
}
