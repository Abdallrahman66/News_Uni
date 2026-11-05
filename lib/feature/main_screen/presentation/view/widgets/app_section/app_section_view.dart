import 'package:flutter/material.dart';
import 'package:news_uni/feature/main_screen/presentation/view/widgets/app_section/floating_bottom_navbar.dart';
import 'package:news_uni/core/utils/app_colors.dart';

import '../../screens/all_news_screen.dart';
import '../../screens/bitcoin_screen.dart';
import '../../screens/business_screen.dart';
import '../../screens/entertainment_screen.dart';
import '../../screens/sports_screen.dart';

class AppSectionView extends StatefulWidget {
  const AppSectionView({super.key});

  @override
  State<AppSectionView> createState() => _AppSectionViewState();
}

class _AppSectionViewState extends State<AppSectionView> {
  int _selectedIndex = 2;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = const [
      SportsScreen(),
      BitcoinScreen(),
      AllNewsScreen(),
      EntertainmentScreen(),
      BusinessScreen(),
    ];
  }

  void _onNavigationChanged(int index) {
    if (index < 0 || index >= _screens.length) return;

    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,

      body: IndexedStack(index: _selectedIndex, children: _screens),

      bottomNavigationBar: FloatingBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavigationChanged,
      ),
    );
  }
}
