import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth/users_auth_screens/profile_screen.dart';
import 'event_screen.dart';
import 'home_main_screen.dart';
import '../message_screen.dart';

class BottomNav extends StatefulWidget {

  const BottomNav({super.key,});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeMainScreen(),
    EventScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  final List<_NavItem> navItems = [
    _NavItem(iconPath: AppIcons.home_icon, label: 'Home'),
    _NavItem(iconPath: AppIcons.event_icon, label: 'Events'),
    _NavItem(iconPath: AppIcons.message_icon, label: 'Messages'),
    _NavItem(iconPath: AppIcons.profile_icon, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        // Minimize / exit app
        await SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final isSelected = currentIndex == index;
              final item = navItems[index];

              return GestureDetector(
                onTap: () => setState(() => currentIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ?  Colors.grey.shade200 : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child:  Row(
                children: [
                // Icon always first
                SvgPicture.asset(
                item.iconPath,
                  width: 35,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.bottomNavItemColor : Colors.black54,
                    BlendMode.srcIn,
                  ),
                ),

                  // Label appears to the right when selected
                  if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  item.label,
                  style: const TextStyle(
                    color: AppColors.bottomNavItemColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ],
              ),

              ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String iconPath;
  final String label;

  const _NavItem({required this.iconPath, required this.label});
}
