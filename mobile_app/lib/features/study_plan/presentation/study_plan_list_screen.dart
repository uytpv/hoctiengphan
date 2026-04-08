import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/study_plan_repository.dart';
import '../domain/models/study_plan.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/common/widgets/bilingual_label.dart';
import '../../../core/common/widgets/status_chip.dart';
import '../../../core/localization/language_provider.dart';

class StudyPlanListScreen extends ConsumerWidget {
  const StudyPlanListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(studyPlansProvider);
    final lang = ref.watch(languageProvider);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Row(
          children: [
            Text(
              'Opi Suomea',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.surfaceDark,
              ),
            ),
          ],
        ),
        actions: [
          // Language quick toggle
          InkWell(
            onTap: () {
              ref.read(languageProvider.notifier).setLanguage(
                    lang == 'vi' ? 'en' : 'vi',
                  );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(lang == 'vi' ? '🇻🇳' : '🇬🇧', style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    lang == 'vi' ? 'Việt' : 'EN',
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // User avatar
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: AppColors.primary,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? Text(
                      (user?.displayName ?? 'U').substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
          ),
        ],
      ),
      body: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 12),
              Text('Virhe ladattaessa', style: AppTextStyles.headingSm),
              const SizedBox(height: 8),
              Text(err.toString(), style: AppTextStyles.caption),
            ],
          ),
        ),
        data: (plans) {
          if (plans.isEmpty) {
            return _EmptyState(lang: lang);
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BilingualLabel(
                        primary: 'Opiskelusuunnitelmat',
                        secondary: lang == 'vi'
                            ? 'Kế hoạch học tập'
                            : 'Study Plans',
                        axis: Axis.vertical,
                        primaryStyle: AppTextStyles.headingLg,
                        showParentheses: false,
                        spacing: 2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Valitse suunnitelma ',
                        style: AppTextStyles.bodyMd
                            .copyWith(color: AppColors.neutral),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                sliver: SliverList.separated(
                  itemCount: plans.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => _StudyPlanCard(
                    plan: plans[i],
                    lang: lang,
                    onTap: () =>
                        context.go('/study-plan/${plans[i].id}'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StudyPlanCard extends StatelessWidget {
  const _StudyPlanCard({
    required this.plan,
    required this.lang,
    required this.onTap,
  });

  final StudyPlan plan;
  final String lang;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gradients = AppColors.planGradients;
    final gradient =
        gradients[plan.colorIndex % gradients.length];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gradient header
              Container(
                height: 88,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Level badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              plan.level,
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            plan.titleFi,
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Progress indicator
                    ProgressBadge(
                      progress: plan.progress,
                      size: 52,
                      strokeWidth: 4,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ),

              // Plan body
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Secondary title
                    Text(
                      plan.titleFor(lang),
                      style: AppTextStyles.bodySm
                          .copyWith(color: AppColors.neutral),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    if (plan.descriptionFi.isNotEmpty) ...[
                      Text(
                        plan.descriptionFi,
                        style: AppTextStyles.bodyMd,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                    ],

                    // Stats row
                    Row(
                      children: [
                        _StatBadge(
                          icon: Icons.calendar_today_outlined,
                          value: '${plan.totalWeeks}',
                          label: 'vk',
                        ),
                        const SizedBox(width: 12),
                        _StatBadge(
                          icon: Icons.arrow_forward,
                          value: lang == 'vi'
                              ? 'Xem lộ trình'
                              : 'View roadmap',
                          isAction: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({
    required this.icon,
    required this.value,
    this.label = '',
    this.isAction = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool isAction;

  @override
  Widget build(BuildContext context) {
    if (isAction) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward,
              size: 14, color: AppColors.primary),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.neutral),
          const SizedBox(width: 4),
          Text(
            '$value $label',
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.neutral,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.lang});
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.book_outlined,
                size: 72, color: AppColors.borderLight),
            const SizedBox(height: 16),
            Text(
              'Ei suunnitelmia',
              style: AppTextStyles.headingMd,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              lang == 'vi'
                  ? 'Chưa có kế hoạch học tập nào.'
                  : 'No study plans available yet.',
              style: AppTextStyles.bodyMd
                  .copyWith(color: AppColors.neutral),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
