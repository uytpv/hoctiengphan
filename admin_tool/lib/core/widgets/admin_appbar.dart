import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/presentation/widgets/change_password_dialog.dart';

class AdminAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: const Text(
        'Học Tiếng Phần - CMS Admin Tools',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      actions: [
        if (user != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              user.email ?? '',
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.lock_outline, color: Colors.blueGrey),
          tooltip: 'Thay đổi mật khẩu',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ChangePasswordDialog(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.redAccent),
          tooltip: 'Sign Out',
          onPressed: () {
            ref.read(authNotifierProvider.notifier).signOut();
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
