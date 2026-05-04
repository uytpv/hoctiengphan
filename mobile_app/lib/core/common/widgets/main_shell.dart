import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

/// Shell widget providing the Bottom Navigation Bar shared across main screens.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _tabs = [
    (path: '/', icon: Icons.home_outlined, activeIcon: Icons.home, labelFi: 'Koti'),
    (path: '/settings', icon: Icons.settings_outlined, activeIcon: Icons.settings, labelFi: 'Asetukset'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    int currentIndex = 0;
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path) && _tabs[i].path != '/') {
        currentIndex = i;
      } else if (location == '/' && _tabs[i].path == '/') {
        currentIndex = i;
      }
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => context.go(_tabs[index].path),
          items: _tabs
              .map(
                (tab) => BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  activeIcon: Icon(tab.activeIcon),
                  label: tab.labelFi,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
