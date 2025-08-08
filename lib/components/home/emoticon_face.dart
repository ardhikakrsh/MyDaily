import 'package:flutter/material.dart';

class EmoticonFace extends StatelessWidget {
  final String urlEmoticon;
  final Color color;

  const EmoticonFace({
    super.key,
    required this.urlEmoticon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(urlEmoticon, width: 100, height: 100),
    );
  }
}
