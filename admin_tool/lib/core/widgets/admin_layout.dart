import 'package:flutter/material.dart';
import 'admin_sidebar.dart';
import 'admin_appbar.dart';

class AdminLayout extends StatelessWidget {
  final Widget child; // The content from matched Route

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed Sidebar on the left
          const AdminSidebar(),
          // Expanded dynamic content area on the right
          Expanded(
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(24.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
