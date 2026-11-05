import 'package:flutter/material.dart';
import 'package:glassmotion_navbar/glassmotion_navbar.dart';

class FloatingBottomNavBar extends StatelessWidget {
  const FloatingBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  static const Color _primaryColor = Color(0xFF52796F);
  static const Color _inactiveColor = Color(0xFF929C96);
  static const Color _backgroundColor = Color(0xF0E3E9E3);

  static const List<GlassNavItem> _items = [
    GlassNavItem(icon: Icons.sports_soccer_rounded, label: 'Sports'),
    GlassNavItem(icon: Icons.currency_bitcoin_rounded, label: 'Bitcoin'),
    GlassNavItem(icon: Icons.newspaper_rounded, label: 'All News'),
    GlassNavItem(icon: Icons.movie_filter_rounded, label: 'Entertainment'),
    GlassNavItem(icon: Icons.business_center_rounded, label: 'Business'),
  ];

  Widget _buildCenterWidget() {
    final bool isSelected = selectedIndex == 2;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Icon(
        Icons.newspaper_rounded,
        key: ValueKey(isSelected),
        color: isSelected ? Colors.white : _inactiveColor,
        size: 27,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassMotionNavBar(
      items: _items,
      selectedIndex: selectedIndex,

      onItemTapped: onItemSelected,
      onCenterTap: () => onItemSelected(2),

      centerWidget: _buildCenterWidget(),

      accentColor: _primaryColor,
      inactiveColor: _inactiveColor,
      backgroundColor: _backgroundColor,

      height: 72,
      fabDiameter: 62,
      horizontalPadding: 16,
      borderRadius: BorderRadius.circular(30),

      showLabels: true,
      labelStyle: const TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),

      iconAnimationDuration: const Duration(milliseconds: 350),
      enableHaptics: true,
    );
  }
}
