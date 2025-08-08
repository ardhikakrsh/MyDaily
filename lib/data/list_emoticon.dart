import 'package:flutter/material.dart';
import 'package:mydaily/models/emoticon.dart';

const List<Emoticon> allEmoticons = [
  Emoticon(
    name: 'Spectacular',
    message: 'You are doing great! Keep it up!',
    imagePath: 'assets/images/facespectacular.png',
    color: Color(0xFFFFA7BC),
  ),
  Emoticon(
    name: 'Happy',
    message: 'Keep smiling and spreading joy!',
    imagePath: 'assets/images/facehappy.png',
    color: Color(0xFFDFEBFF),
  ),
  Emoticon(
    name: 'Good',
    message: 'You are doing well, stay positive!',
    imagePath: 'assets/images/facegood.png',
    color: Color(0xFFFDDD6F),
  ),
  Emoticon(
    name: 'Sad',
    message: 'It\'s okay to feel sad sometimes.',
    imagePath: 'assets/images/facesad.png',
    color: Color(0xFFA1E7EB),
  ),
  Emoticon(
    name: 'Upset',
    message: 'Take a deep breath, it will pass.',
    imagePath: 'assets/images/faceupset.png',
    color: Color(0xFF8CA4EE),
  ),
  Emoticon(
    name: 'Angry',
    message: 'It\'s okay to feel angry, just let it out.',
    imagePath: 'assets/images/faceangry.png',
    color: Color(0xFFFF843E),
  ),
];
