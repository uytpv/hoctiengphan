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
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Lỗi kết nối / Connection Error',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  err.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => ref.invalidate(studyPlansProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Thử lại / Try Again'),
              ),
            ],
          ),
        ),
        data: (plans) {
          if (plans.isEmpty) {
            return _EmptyState(lang: lang);
          }
          final activePlan = plans.firstWhere(
            (p) => p.progress > 0 && p.progress < 1.0,
            orElse: () => plans.first,
          );
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ResumeHeroCard(plan: activePlan, lang: lang),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
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

class _ResumeHeroCard extends StatelessWidget {
  const _ResumeHeroCard({required this.plan, required this.lang});

  final StudyPlan plan;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final progressPercent = (plan.progress * 100).toInt();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0048B0), Color(0xFF0056D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt_rounded, size: 16, color: Color(0xFFFFD166)),
                    const SizedBox(width: 4),
                    Text(
                      'Päivittäinen oppiminen',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => context.go('/vocabulary'),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.style_outlined, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        'Sanasto',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            plan.titleFi,
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Oppia ikä kaikki! • Học tập là hành trình suốt đời',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 16),
          // Progress bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: plan.progress.clamp(0.05, 1.0),
                    minHeight: 8,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF32AE88)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$progressPercent%',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.go('/study-plan/${plan.id}'),
              icon: const Icon(Icons.play_arrow_rounded, color: AppColors.primary),
              label: Text(
                lang == 'vi' ? 'Tiếp tục bài học' : 'Jatka opiskelua',
                style: AppTextStyles.buttonMd.copyWith(color: AppColors.primary),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
