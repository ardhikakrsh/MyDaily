import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mydaily/pages/history/history_page.dart';
import 'package:mydaily/pages/home/home_page.dart';
import 'package:mydaily/pages/sett/settings_page.dart';
import 'package:mydaily/pages/statistic/statistic_page.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    StatisticPage(),
    HistoryPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _currentIndex,
          enablePaddingAnimation: true,
          indicatorColor: Color(0xFF8B4CFC),
          unselectedItemColor: Color(0xFF8B4CFC).withOpacity(0.5),
          backgroundColor: Color(0xFFDED7FA).withOpacity(0.1),
          outlineBorderColor: Color(0xFF8B4CFC).withOpacity(0.1),
          borderWidth: 2,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Color(0xFF8B4CFC),
              badge: const Badge(
                label: Text("9+", style: TextStyle(color: Colors.white)),
              ),
            ),

            /// Statistics
            CrystalNavigationBarItem(
              icon: IconlyBold.chart,
              unselectedIcon: IconlyLight.chart,
              selectedColor: Color(0xFF8B4CFC),
            ),

            // History
            CrystalNavigationBarItem(
              icon: IconlyBold.bookmark,
              unselectedIcon: IconlyLight.bookmark,
              selectedColor: Color(0xFF8B4CFC),
            ),

            /// Settings
            CrystalNavigationBarItem(
              icon: IconlyBold.setting,
              unselectedIcon: IconlyLight.setting,
              selectedColor: Color(0xFF8B4CFC),
            ),
          ],
        ),
      ),
    );
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
