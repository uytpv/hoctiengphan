import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/common/widgets/quill_content_renderer.dart';
import '../../study_plan/data/study_plan_repository.dart';

// ─────────────────────────────────────────────
// Section index constants
// ─────────────────────────────────────────────
enum _LessonSection { overview, content, speaking, grammar, exercise }

// ─────────────────────────────────────────────
// Main screen widget
// ─────────────────────────────────────────────
class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({
    super.key,
    required this.lessonId,
    required this.planId,
    required this.weekId,
    required this.dayId,
    required this.activityId,
  });

  final String lessonId;
  final String planId;
  final String weekId;
  final String dayId;
  final String activityId;

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _lesson;
  List<Map<String, dynamic>> _grammars = [];
  List<Map<String, dynamic>> _exercises = [];

  bool _loading = true;
  bool _marking = false;
  bool _done = false;

  late TabController _tabController;
  _LessonSection _activeSection = _LessonSection.overview;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _LessonSection.values.length,
      vsync: this,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _activeSection = _LessonSection.values[_tabController.index];
        });
      }
    });
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── Data loading ─────────────────────────────
  Future<void> _load() async {
    // Guard: empty lessonId means navigation bug upstream
    if (widget.lessonId.isEmpty) {
      debugPrint('[LessonScreen] ERROR: lessonId is empty!');
      if (mounted) setState(() => _loading = false);
      return;
    }
    debugPrint('[LessonScreen] Loading lesson: ${widget.lessonId}');
    try {
      final db = FirebaseFirestore.instance;
      final doc = await db.collection('lessons').doc(widget.lessonId).get();
      debugPrint('[LessonScreen] Doc exists: ${doc.exists}, id: ${doc.id}');
      final data = doc.data();
      if (data == null || !mounted) {
        debugPrint('[LessonScreen] No data found for lessonId: ${widget.lessonId}');
        if (mounted) setState(() => _loading = false); // ← fix: set loading false
        return;
      }

      // Load linked grammars
      final grammarIds = data['grammarIds'] is List
          ? (data['grammarIds'] as List).cast<String>()
          : <String>[];
      final exercises_ = data['exerciseIds'] is List
          ? (data['exerciseIds'] as List).cast<String>()
          : <String>[];

      // NOTE: seed uses 'grammars' (plural), exercises uses 'exercises'
      final grammarDocs = await Future.wait(grammarIds.map(
        (id) => db.collection('grammars').doc(id).get(),
      ));
      final exerciseDocs = await Future.wait(exercises_.map(
        (id) => db.collection('exercises').doc(id).get(),
      ));

      if (!mounted) return;
      setState(() {
        _lesson = data;
        _grammars = grammarDocs
            .where((d) => d.exists)
            .map((d) => {'id': d.id, ...d.data()!})
            .toList();
        _exercises = exerciseDocs
            .where((d) => d.exists)
            .map((d) => {'id': d.id, ...d.data()!})
            .toList();
        _loading = false;
      });
    } catch (e, st) {
      debugPrint('[LessonScreen] ERROR loading lesson: $e\n$st');
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _markDone() async {
    setState(() => _marking = true);
    final repo = ref.read(studyPlanRepositoryProvider);
    await repo.markActivityDone(
      planId: widget.planId,
      weekId: widget.weekId,
      dayId: widget.dayId,
      activityId: widget.activityId,
    );
    if (mounted) setState(() { _marking = false; _done = true; });
  }

  // ── Build ─────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _loading
          ? const _LoadingShimmer()
          : _lesson == null
              ? _ErrorState(lang: lang, onBack: () => context.go('/'))
              : _LessonContent(
                  lesson: _lesson!,
                  grammars: _grammars,
                  exercises: _exercises,
                  lang: lang,
                  done: _done,
                  marking: _marking,
                  activeSection: _activeSection,
                  tabController: _tabController,
                  planId: widget.planId,
                  weekId: widget.weekId,
                  dayId: widget.dayId,
                  activityId: widget.activityId,
                  onMarkDone: _markDone,
                  onBack: () => context.go('/study-plan/${widget.planId}'),
                ),
    );
  }
}

// ─────────────────────────────────────────────
// Main content layout
// ─────────────────────────────────────────────
class _LessonContent extends StatelessWidget {
  const _LessonContent({
    required this.lesson,
    required this.grammars,
    required this.exercises,
    required this.lang,
    required this.done,
    required this.marking,
    required this.activeSection,
    required this.tabController,
    required this.planId,
    required this.weekId,
    required this.dayId,
    required this.activityId,
    required this.onMarkDone,
    required this.onBack,
  });

  final Map<String, dynamic> lesson;
  final List<Map<String, dynamic>> grammars;
  final List<Map<String, dynamic>> exercises;
  final String lang;
  final bool done;
  final bool marking;
  final _LessonSection activeSection;
  final TabController tabController;
  final String planId, weekId, dayId, activityId;
  final VoidCallback onMarkDone;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final title = lesson['title'] as String? ?? lesson['titleFi'] as String? ?? '';
    final weekNum = (lesson['weekNumber'] as num?)?.toInt();
    final chapter = lesson['chapter'] as String?;

    return Column(
      children: [
        // ── Top header with gradient ──────────────
        _LessonHeader(
          title: title,
          weekNum: weekNum,
          chapter: chapter,
          done: done,
          lang: lang,
          onBack: onBack,
        ),

        // ── Tab bar ──────────────────────────────
        _SectionTabBar(
          tabController: tabController,
          lang: lang,
          grammarsCount: grammars.length,
          exercisesCount: exercises.length,
        ),

        // ── Tab content ──────────────────────────
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // 1. Overview / Description
              _OverviewSection(lesson: lesson, lang: lang),

              // 2. Lesson Content
              _LessonContentSection(lesson: lesson, lang: lang),

              // 3. Speaking / Dialogue
              _SpeakingSection(lesson: lesson, lang: lang),

              // 4. Grammar
              _GrammarSection(grammars: grammars, lang: lang),

              // 5. Exercises
              _ExerciseSection(
                exercises: exercises,
                lang: lang,
                planId: planId,
                weekId: weekId,
                dayId: dayId,
                activityId: activityId,
                context: context,
              ),
            ],
          ),
        ),

        // ── Complete button ───────────────────────
        _CompleteBar(
          done: done,
          marking: marking,
          lang: lang,
          onMarkDone: onMarkDone,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Header with gradient
// ─────────────────────────────────────────────
class _LessonHeader extends StatelessWidget {
  const _LessonHeader({
    required this.title,
    required this.weekNum,
    required this.chapter,
    required this.done,
    required this.lang,
    required this.onBack,
  });

  final String title;
  final int? weekNum;
  final String? chapter;
  final bool done;
  final String lang;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0056D2), Color(0xFF3587FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back + status
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: onBack,
                    tooltip: lang == 'vi' ? 'Quay lại' : 'Back',
                  ),
                  const Spacer(),
                  if (done)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            lang == 'vi' ? 'Đã hoàn thành' : 'Completed',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 4),

              // Breadcrumb chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 6,
                  children: [
                    if (weekNum != null)
                      _WhiteChip(label: 'Viikko $weekNum'),
                    if (chapter != null && chapter!.isNotEmpty)
                      _WhiteChip(label: chapter!),
                    _WhiteChip(
                      label: lang == 'vi' ? 'Bài học' : 'Lesson',
                      icon: Icons.menu_book_rounded,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhiteChip extends StatelessWidget {
  const _WhiteChip({required this.label, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: Colors.white.withValues(alpha: 0.9)),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section tab bar
// ─────────────────────────────────────────────
class _SectionTabBar extends StatelessWidget {
  const _SectionTabBar({
    required this.tabController,
    required this.lang,
    required this.grammarsCount,
    required this.exercisesCount,
  });

  final TabController tabController;
  final String lang;
  final int grammarsCount;
  final int exercisesCount;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _tabItem(icon: Icons.info_outline, label: lang == 'vi' ? 'Tổng quan' : 'Overview'),
      _tabItem(icon: Icons.menu_book_rounded, label: lang == 'vi' ? 'Nội dung' : 'Content'),
      _tabItem(icon: Icons.record_voice_over_rounded, label: lang == 'vi' ? 'Hội thoại' : 'Speaking'),
      _tabItem(
        icon: Icons.auto_stories_rounded,
        label: lang == 'vi' ? 'Ngữ pháp' : 'Grammar',
        badge: grammarsCount,
      ),
      _tabItem(
        icon: Icons.edit_note_rounded,
        label: lang == 'vi' ? 'Bài tập' : 'Exercises',
        badge: exercisesCount,
      ),
    ];

    return Container(
      color: AppColors.surface,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.neutral,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2.5,
        dividerColor: AppColors.border,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        tabs: tabs,
      ),
    );
  }

  Widget _tabItem({
    required IconData icon,
    required String label,
    int badge = 0,
  }) {
    return Tab(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12.5)),
            if (badge > 0) ...[
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badge',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section 1 — Overview / Description
// ─────────────────────────────────────────────
class _OverviewSection extends StatelessWidget {
  const _OverviewSection({required this.lesson, required this.lang});
  final Map<String, dynamic> lesson;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final description = lesson['description'] as String? ?? '';

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Short description card
        if (description.isNotEmpty) ...[
          _SectionCard(
            icon: Icons.info_outline,
            iconColor: AppColors.primary,
            title: lang == 'vi' ? 'Mô tả bài học' : 'Lesson Description',
            child: Text(
              description,
              style: AppTextStyles.bodyLg.copyWith(height: 1.7),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // ── Legend card (Merkkien selitykset) ────
        _LegendCard(lang: lang),

        const SizedBox(height: 16),

        // Quick stats
        _SectionCard(
          icon: Icons.list_alt_rounded,
          iconColor: const Color(0xFF6C63FF),
          title: lang == 'vi' ? 'Nội dung bài học' : 'What\'s in this lesson',
          child: Column(
            children: [
              _QuickStatRow(
                icon: Icons.menu_book_rounded,
                color: const Color(0xFF0056D2),
                label: lang == 'vi' ? 'Nội dung học' : 'Reading content',
              ),
              const SizedBox(height: 10),
              _QuickStatRow(
                icon: Icons.record_voice_over_rounded,
                color: const Color(0xFF32AE88),
                label: lang == 'vi' ? 'Hội thoại mẫu' : 'Dialogue practice',
              ),
              if ((lesson['grammarIds'] as List?)?.isNotEmpty == true) ...[
                const SizedBox(height: 10),
                _QuickStatRow(
                  icon: Icons.auto_stories_rounded,
                  color: const Color(0xFFFF6B35),
                  label: lang == 'vi' ? 'Bài học ngữ pháp' : 'Grammar points',
                ),
              ],
              if ((lesson['exerciseIds'] as List?)?.isNotEmpty == true) ...[
                const SizedBox(height: 10),
                _QuickStatRow(
                  icon: Icons.edit_note_rounded,
                  color: const Color(0xFF6C63FF),
                  label: lang == 'vi' ? 'Bài tập thực hành' : 'Practice exercises',
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickStatRow extends StatelessWidget {
  const _QuickStatRow({
    required this.icon,
    required this.color,
    required this.label,
  });
  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Text(label, style: AppTextStyles.bodyMd),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Legend card — Merkkien selitykset
// ─────────────────────────────────────────────
class _LegendCard extends StatelessWidget {
  const _LegendCard({required this.lang});
  final String lang;

  @override
  Widget build(BuildContext context) {
    final items = [
      _LegendItem(
        icon: Icons.chat_bubble_outline_rounded,
        color: const Color(0xFFE74C3C),
        title: lang == 'vi' ? 'Ngôn ngữ nói' : 'Spoken language',
        desc: lang == 'vi'
            ? 'Bài tập hoặc hội thoại dùng phong cách nói. Từ puhekieli được đánh dấu *.'
            : 'Exercises or texts use spoken style. Colloquial words marked with *.',
      ),
      _LegendItem(
        icon: Icons.record_voice_over_rounded,
        color: const Color(0xFF27AE60),
        title: lang == 'vi' ? 'Bài phát âm' : 'Pronunciation exercise',
        desc: lang == 'vi'
            ? 'Luyện phát âm theo băng. Cách thực hiện được ghi rõ trong bài.'
            : 'Repeat after the recording. Instructions in the exercise.',
      ),
      _LegendItem(
        icon: Icons.hearing_rounded,
        color: const Color(0xFF3498DB),
        title: lang == 'vi' ? 'Bài nghe' : 'Listening exercise',
        desc: lang == 'vi'
            ? 'Nghe băng và trả lời vào sách.'
            : 'Listen to the recording and answer in the book.',
      ),
      _LegendItem(
        icon: Icons.people_alt_rounded,
        color: const Color(0xFF9B59B6),
        title: lang == 'vi' ? 'Luyện nói đôi' : 'Pair speaking practice',
        desc: lang == 'vi' ? 'Bài tập nói theo cặp.' : 'Oral pair exercise.',
      ),
      _LegendItem(
        icon: Icons.edit_rounded,
        color: const Color(0xFF1ABC9C),
        title: lang == 'vi' ? 'Bài viết' : 'Writing exercise',
        desc: lang == 'vi' ? 'Viết đoạn văn dài.' : 'Write a longer text.',
      ),
      _LegendItem(
        icon: Icons.chrome_reader_mode_rounded,
        color: const Color(0xFFE67E22),
        title: lang == 'vi' ? 'Bài đọc' : 'Reading exercise',
        desc: lang == 'vi' ? 'Đọc đoạn văn dài.' : 'Read a longer text.',
      ),
    ];

    return _SectionCard(
      icon: Icons.info_rounded,
      iconColor: AppColors.neutral,
      title: 'Merkkien selitykset',
      subtitle: lang == 'vi' ? 'Giải thích ký hiệu' : 'Symbol guide',
      child: Column(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _LegendRow(item: item),
                ))
            .toList(),
      ),
    );
  }
}

class _LegendItem {
  const _LegendItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String desc;
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.item});
  final _LegendItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item.icon, size: 20, color: item.color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title,
                  style: AppTextStyles.labelMd
                      .copyWith(color: AppColors.surfaceDark)),
              const SizedBox(height: 2),
              Text(item.desc,
                  style:
                      AppTextStyles.caption.copyWith(color: AppColors.neutral)),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Section 2 — Lesson Content
// ─────────────────────────────────────────────
class _LessonContentSection extends StatelessWidget {
  const _LessonContentSection({required this.lesson, required this.lang});
  final Map<String, dynamic> lesson;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final contentRaw = lesson['lessonContent'];
    String rawContent = '';
    
    if (contentRaw is Map<String, dynamic>) {
      rawContent = contentRaw['text']?.toString() ?? '';
    } else if (contentRaw is String) {
      rawContent = contentRaw;
    }

    if (rawContent.isEmpty) {
      rawContent = (lesson['content'] ?? lesson['contentFi'] ?? '').toString();
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Header chip
        _SectionHeader(
          icon: Icons.menu_book_rounded,
          color: AppColors.primary,
          label: lang == 'vi' ? 'Nội dung học tập' : 'Lesson Content',
          sublabel: lang == 'vi'
              ? 'Đọc kỹ nội dung bên dưới'
              : 'Read through the content below',
        ),
        const SizedBox(height: 16),

        // Content block — render Quill Delta (or plain text)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: rawContent.toString().trim().isNotEmpty
              ? QuillContentRenderer(deltaJson: rawContent)
              : _EmptyPlaceholder(
                  icon: Icons.menu_book_outlined,
                  label: lang == 'vi'
                      ? 'Nội dung chưa được cập nhật'
                      : 'Content not yet available',
                ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Section 3 — Speaking / Dialogue
// ─────────────────────────────────────────────
class _SpeakingSection extends StatelessWidget {
  const _SpeakingSection({required this.lesson, required this.lang});
  final Map<String, dynamic> lesson;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final speakingRaw = lesson['speaking'];
    String text = '';
    String audioUrl = '';

    if (speakingRaw is Map<String, dynamic>) {
      text = speakingRaw['text']?.toString() ?? '';
      audioUrl = speakingRaw['audioUrl']?.toString() ?? '';
    } else if (speakingRaw is String) {
      text = speakingRaw;
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader(
          icon: Icons.record_voice_over_rounded,
          color: const Color(0xFF32AE88),
          label: lang == 'vi' ? 'Hội thoại mẫu' : 'Dialogue',
          sublabel: lang == 'vi'
              ? 'Lắng nghe và luyện nói theo'
              : 'Listen and repeat after the model',
        ),
        const SizedBox(height: 16),

        // Audio player card
        _AudioPlayerCard(audioUrl: audioUrl, lang: lang),
        const SizedBox(height: 16),

        // Dialogue text
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: text.toString().trim().isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFF32AE88).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.format_quote_rounded,
                              size: 16, color: Color(0xFF32AE88)),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          lang == 'vi' ? 'Hội thoại' : 'Dialogue text',
                          style: AppTextStyles.labelMd
                              .copyWith(color: const Color(0xFF32AE88)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Render as Quill Delta (may contain text + images)
                    QuillContentRenderer(deltaJson: text),
                  ],
                )
              : _EmptyPlaceholder(
                  icon: Icons.record_voice_over_outlined,
                  label: lang == 'vi'
                      ? 'Chưa có hội thoại mẫu'
                      : 'No dialogue available yet',
                ),
        ),

        const SizedBox(height: 16),

        // Pair exercise hint
        _HintCard(
          icon: Icons.people_alt_rounded,
          color: const Color(0xFF9B59B6),
          text: lang == 'vi'
              ? 'Luyện tập đoạn hội thoại với bạn học theo cặp.'
              : 'Practice this dialogue with a partner.',
        ),
      ],
    );
  }
}

// Audio player widget (placeholder — play supported via audioUrl)
class _AudioPlayerCard extends StatefulWidget {
  const _AudioPlayerCard({required this.audioUrl, required this.lang});
  final String audioUrl;
  final String lang;

  @override
  State<_AudioPlayerCard> createState() => _AudioPlayerCardState();
}

class _AudioPlayerCardState extends State<_AudioPlayerCard> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final hasAudio = widget.audioUrl.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF27AE60), Color(0xFF32AE88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Play button
          GestureDetector(
            onTap: hasAudio
                ? () => setState(() => _isPlaying = !_isPlaying)
                : null,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5), width: 2),
              ),
              child: Icon(
                hasAudio
                    ? (_isPlaying ? Icons.pause : Icons.play_arrow)
                    : Icons.hearing_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasAudio
                      ? (widget.lang == 'vi' ? 'Phát âm mẫu' : 'Model pronunciation')
                      : (widget.lang == 'vi'
                          ? 'Chưa có file âm thanh'
                          : 'No audio available'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasAudio
                      ? (widget.lang == 'vi'
                          ? 'Nhấn để phát / dừng'
                          : 'Tap to play / pause')
                      : (widget.lang == 'vi'
                          ? 'Admin chưa upload audio'
                          : 'Audio not uploaded yet'),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Waveform icon
          Icon(
            Icons.graphic_eq_rounded,
            color: Colors.white.withValues(alpha: hasAudio ? 0.8 : 0.3),
            size: 32,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section 4 — Grammar
// ─────────────────────────────────────────────
class _GrammarSection extends StatelessWidget {
  const _GrammarSection({required this.grammars, required this.lang});
  final List<Map<String, dynamic>> grammars;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader(
          icon: Icons.auto_stories_rounded,
          color: const Color(0xFFFF6B35),
          label: lang == 'vi' ? 'Ngữ pháp' : 'Grammar',
          sublabel: lang == 'vi'
              ? 'Điểm ngữ pháp trong bài học này'
              : 'Grammar points in this lesson',
        ),
        const SizedBox(height: 16),

        if (grammars.isEmpty)
          _EmptyPlaceholder(
            icon: Icons.auto_stories_outlined,
            label: lang == 'vi'
                ? 'Bài học này chưa có điểm ngữ pháp'
                : 'No grammar points for this lesson',
          )
        else
          ...grammars.asMap().entries.map((entry) {
            final idx = entry.key;
            final g = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _GrammarCard(grammar: g, index: idx + 1, lang: lang),
            );
          }),
      ],
    );
  }
}

class _GrammarCard extends StatelessWidget {
  const _GrammarCard({
    required this.grammar,
    required this.index,
    required this.lang,
  });
  final Map<String, dynamic> grammar;
  final int index;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final title = grammar['title'] as String? ?? grammar['titleFi'] as String? ?? '';
    final desc = grammar['description'] as String? ?? '';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Index bubble
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.isNotEmpty
                        ? title
                        : (lang == 'vi' ? 'Điểm ngữ pháp' : 'Grammar point'),
                    style: AppTextStyles.headingSm,
                  ),
                  if (desc.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      desc,
                      style: AppTextStyles.bodyMd
                          .copyWith(color: AppColors.neutral),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section 5 — Exercises
// ─────────────────────────────────────────────
class _ExerciseSection extends StatelessWidget {
  const _ExerciseSection({
    required this.exercises,
    required this.lang,
    required this.planId,
    required this.weekId,
    required this.dayId,
    required this.activityId,
    required this.context,
  });
  final List<Map<String, dynamic>> exercises;
  final String lang;
  final String planId, weekId, dayId, activityId;
  final BuildContext context;

  @override
  Widget build(BuildContext outerContext) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader(
          icon: Icons.edit_note_rounded,
          color: const Color(0xFF6C63FF),
          label: lang == 'vi' ? 'Bài tập' : 'Exercises',
          sublabel: lang == 'vi'
              ? 'Thực hành để củng cố kiến thức'
              : 'Practice to consolidate knowledge',
        ),
        const SizedBox(height: 16),

        if (exercises.isEmpty)
          _EmptyPlaceholder(
            icon: Icons.edit_outlined,
            label: lang == 'vi'
                ? 'Bài học này chưa có bài tập'
                : 'No exercises for this lesson',
          )
        else ...[
          // Info hint
          _HintCard(
            icon: Icons.edit_rounded,
            color: const Color(0xFF6C63FF),
            text: lang == 'vi'
                ? 'Nhấn vào bài tập để bắt đầu luyện tập.'
                : 'Tap an exercise to start practicing.',
          ),
          const SizedBox(height: 12),

          ...exercises.asMap().entries.map((entry) {
            final idx = entry.key;
            final ex = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ExerciseCard(
                exercise: ex,
                index: idx + 1,
                lang: lang,
                onTap: () => outerContext.push(
                  '/exercise/${ex['id']}'
                  '?planId=$planId&weekId=$weekId&dayId=$dayId&activityId=$activityId',
                ),
              ),
            );
          }),
        ],
      ],
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({
    required this.exercise,
    required this.index,
    required this.lang,
    required this.onTap,
  });
  final Map<String, dynamic> exercise;
  final int index;
  final String lang;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = exercise['title'] as String? ?? '';
    final desc = exercise['description'] as String? ?? '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Exercise number + icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF8B82FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.isNotEmpty
                          ? title
                          : (lang == 'vi' ? 'Bài tập $index' : 'Exercise $index'),
                      style: AppTextStyles.headingSm,
                    ),
                    if (desc.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        desc,
                        style: AppTextStyles.bodyMd
                            .copyWith(color: AppColors.neutral),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.neutral, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Complete bar
// ─────────────────────────────────────────────
class _CompleteBar extends StatelessWidget {
  const _CompleteBar({
    required this.done,
    required this.marking,
    required this.lang,
    required this.onMarkDone,
  });
  final bool done;
  final bool marking;
  final String lang;
  final VoidCallback onMarkDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: done || marking ? null : onMarkDone,
          icon: marking
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Icon(done ? Icons.check_circle : Icons.check_circle_outline),
          label: Text(
            done
                ? (lang == 'vi' ? '✓ Đã học xong' : '✓ Lesson completed')
                : (lang == 'vi' ? 'Đánh dấu đã học' : 'Mark as complete'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: done
                ? AppColors.done
                : AppColors.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor:
                done ? AppColors.done : AppColors.neutral,
            disabledForegroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            elevation: done ? 0 : 2,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Shared utility widgets
// ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
    this.subtitle,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.headingSm),
                    if (subtitle != null)
                      Text(subtitle!,
                          style: AppTextStyles.caption
                              .copyWith(color: AppColors.neutral)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 0),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.color,
    required this.label,
    required this.sublabel,
  });
  final IconData icon;
  final Color color;
  final String label;
  final String sublabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.headingMd),
              Text(sublabel,
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.neutral)),
            ],
          ),
        ),
      ],
    );
  }
}

class _HintCard extends StatelessWidget {
  const _HintCard({
    required this.icon,
    required this.color,
    required this.text,
  });
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMd.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppColors.borderLight),
          const SizedBox(height: 12),
          Text(label,
              style:
                  AppTextStyles.bodyMd.copyWith(color: AppColors.neutral)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Loading shimmer
// ─────────────────────────────────────────────
class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0056D2), Color(0xFF3587FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                const SizedBox(height: 16),
                Text(
                  'Ladataan...',
                  style: AppTextStyles.bodyMd
                      .copyWith(color: AppColors.neutral),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Error state
// ─────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.lang, required this.onBack});
  final String lang;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.error_outline,
                    color: AppColors.error, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                lang == 'vi' ? 'Không tìm thấy bài học' : 'Lesson not found',
                style: AppTextStyles.headingMd,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                lang == 'vi'
                    ? 'Bài học này có thể đã bị xóa hoặc chưa có nội dung.'
                    : 'This lesson may have been removed or has no content.',
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.neutral),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                label: Text(lang == 'vi' ? 'Quay lại' : 'Go back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
