import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // Current URI to highlight the selected menu item
    final location = GoRouterState.of(context).uri.toString();

    return Container(
      width: 200,
      color: Colors.blueGrey[900],
      child: Column(
        children: [
          const SizedBox(height: 10),
          _SidebarItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            isSelected: location == '/' || location == '/dashboard',
            onTap: () => context.go('/dashboard'),
          ),
          _SidebarItem(
            icon: Icons.library_books,
            title: 'Vocabulary',
            isSelected: location.startsWith('/vocabulary'),
            onTap: () => context.go('/vocabulary'),
          ),
          _SidebarItem(
            icon: Icons.school,
            title: 'Lessons',
            isSelected: location.startsWith('/lessons'),
            onTap: () => context.go('/lessons'),
          ),
          _SidebarItem(
            icon: Icons.local_activity,
            title: 'Activities',
            isSelected: location.startsWith('/activities'),
            onTap: () => context.go('/activities'),
          ),
          _SidebarItem(
            icon: Icons.text_snippet,
            title: 'Grammar',
            isSelected: location.startsWith('/grammar'),
            onTap: () => context.go('/grammar'),
          ),
          _SidebarItem(
            icon: Icons.assignment,
            title: 'Exercises',
            isSelected: location.startsWith('/exercises'),
            onTap: () => context.go('/exercises'),
          ),
          _SidebarItem(
            icon: Icons.map,
            title: 'Study Plans',
            isSelected: location.startsWith('/study-plans'),
            onTap: () => context.go('/study-plans'),
          ),
          _SidebarItem(
            icon: Icons.group,
            title: 'Students',
            isSelected: location.startsWith('/students'),
            onTap: () => context.go('/students'),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.white : Colors.white54),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white54),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blueGrey[800],
      onTap: onTap,
    );
  }
}
