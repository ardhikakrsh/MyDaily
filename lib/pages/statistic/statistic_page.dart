import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Statistics Page Content',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
