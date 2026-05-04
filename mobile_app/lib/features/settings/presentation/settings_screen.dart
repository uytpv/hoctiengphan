import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/localization/language_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Asetukset', style: AppTextStyles.headingSm),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  child: user?.photoURL == null
                      ? Text(
                          (user?.displayName ?? 'U')
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'Opiskelija',
                        style: AppTextStyles.headingSm,
                      ),
                      Text(
                        user?.email ?? '',
                        style: AppTextStyles.bodyMd
                            .copyWith(color: AppColors.neutral),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Language selection
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang == 'vi' ? 'Ngôn ngữ hỗ trợ' : 'Secondary language',
                  style: AppTextStyles.headingSm,
                ),
                const SizedBox(height: 4),
                Text(
                  lang == 'vi'
                      ? 'Chọn ngôn ngữ hiển thị bên cạnh tiếng Phần Lan'
                      : 'Choose the language displayed alongside Finnish',
                  style: AppTextStyles.bodyMd
                      .copyWith(color: AppColors.neutral),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _LangOption(
                      flag: '🇻🇳',
                      label: 'Tiếng Việt',
                      selected: lang == 'vi',
                      onTap: () => ref
                          .read(languageProvider.notifier)
                          .setLanguage('vi'),
                    ),
                    const SizedBox(width: 10),
                    _LangOption(
                      flag: '🇬🇧',
                      label: 'English',
                      selected: lang == 'en',
                      onTap: () => ref
                          .read(languageProvider.notifier)
                          .setLanguage('en'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Sign out
          OutlinedButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) context.go('/login');
            },
            icon: const Icon(Icons.logout, color: AppColors.error),
            label: Text(
              lang == 'vi' ? 'Đăng xuất' : 'Sign out',
              style: AppTextStyles.labelLg
                  .copyWith(color: AppColors.error),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _LangOption extends StatelessWidget {
  const _LangOption({
    required this.flag,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String flag;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(flag, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.labelMd.copyWith(
                  color:
                      selected ? AppColors.primary : AppColors.neutral,
                ),
              ),
              if (selected)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(Icons.check_circle,
                      size: 16, color: AppColors.primary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
