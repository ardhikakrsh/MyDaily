import 'package:flutter/material.dart';
import 'package:mydaily/widgets/main_background.dart';
import 'package:mydaily/widgets/navigation_menu.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainBackground(),
          Center(
            child: Image.asset(
              'assets/images/logo_mydaily.png',
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavigationMenu()),
              );
            },
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
