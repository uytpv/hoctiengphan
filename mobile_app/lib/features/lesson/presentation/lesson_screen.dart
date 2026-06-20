import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/language_provider.dart';
import '../../study_plan/data/study_plan_repository.dart';
import '../../../core/common/widgets/markdown_content_renderer.dart';

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

class _LessonScreenState extends ConsumerState<LessonScreen> {
  Map<String, dynamic>? _lesson;
  bool _loading = true;
  bool _marking = false;
  bool _done = false;

  // Theo dõi tương tác để tính toán tiến độ
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;
  final Set<String> _playedAudioUrls = {};
  final Set<String> _completedExerciseIds = {};

  // Các tài nguyên có trong bài giảng (dùng để so sánh tiến độ)
  final Set<String> _totalAudioUrls = {};
  final Set<String> _totalExerciseIds = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_hasScrolledToBottom) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    // Nếu cuộn gần tới cuối trang (cách 100px)
    if (maxScroll - currentScroll <= 100) {
      setState(() {
        _hasScrolledToBottom = true;
      });
      _checkAndAutoSaveProgress();
    }
  }

  // Nạp dữ liệu bài học từ Firestore
  Future<void> _load() async {
    if (widget.lessonId.isEmpty) {
      setState(() => _loading = false);
      return;
    }

    try {
      final db = FirebaseFirestore.instance;
      // 1. Kiểm tra trạng thái đã hoàn thành của activity trước đó
      var isActivityDone = false;
      if (widget.planId.isNotEmpty && widget.activityId.isNotEmpty) {
        final repo = ref.read(studyPlanRepositoryProvider);
        final progressMap = await repo.getUserProgress(widget.planId);
        isActivityDone = progressMap[widget.activityId] == 'done';
      }

      // 2. Tải bài học
      final doc = await db.collection('lessons').doc(widget.lessonId).get();
      final data = doc.data();

      if (data == null) {
        setState(() => _loading = false);
        return;
      }

      // Trích xuất danh sách audioUrls và exerciseIds từ bài học
      final contentText = data['content'] as String? ?? '';
      
      // Quét các audio
      final audioMatches = RegExp(r'\[audio:([^\]]+)\]').allMatches(contentText);
      final List<String> audiosInContent = audioMatches.map((m) => m.group(1)!).toList();

      // Quét các bài tập
      final exerciseMatches = RegExp(r'\[exercise:([^\]]+)\]').allMatches(contentText);
      final List<String> exercisesInContent = exerciseMatches.map((m) => m.group(1)!).toList();

      if (mounted) {
        setState(() {
          _lesson = data;
          _done = isActivityDone;
          _totalAudioUrls.addAll(audiosInContent);
          _totalExerciseIds.addAll(exercisesInContent);
          _loading = false;

          // Nếu bài học đã được đánh dấu hoàn thành từ trước, tự động set các mốc hoàn thành
          if (_done) {
            _hasScrolledToBottom = true;
            _playedAudioUrls.addAll(audiosInContent);
            _completedExerciseIds.addAll(exercisesInContent);
          }
        });
      }
    } catch (e) {
      debugPrint('[LessonScreen] Error loading lesson: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  // Tính toán phần trăm tiến độ bài học
  double get _progressPercent {
    int totalPoints = 1; // 1 điểm cho việc đọc hết bài (cuộn xuống cuối)
    totalPoints += _totalAudioUrls.length;
    totalPoints += _totalExerciseIds.length;

    int completedPoints = 0;
    if (_hasScrolledToBottom) completedPoints++;
    completedPoints += _playedAudioUrls.intersection(_totalAudioUrls).length;
    completedPoints += _completedExerciseIds.intersection(_totalExerciseIds).length;

    if (totalPoints == 0) return 1.0;
    return completedPoints / totalPoints;
  }

  // Tự động lưu hoặc kích hoạt khi hoàn thành 100%
  void _checkAndAutoSaveProgress() {
    if (_progressPercent >= 1.0 && !_done && !_marking) {
      // Chúng ta có thể tự động hoàn thành hoặc để học viên bấm nút. Ở đây ta bật sáng nút.
    }
  }

  // Gọi repository để đánh dấu hoàn thành bài học trên Firestore
  Future<void> _markDone() async {
    setState(() => _marking = true);
    try {
      final repo = ref.read(studyPlanRepositoryProvider);
      await repo.markActivityDone(
        planId: widget.planId,
        weekId: widget.weekId,
        dayId: widget.dayId,
        activityId: widget.activityId,
      );
      if (mounted) {
        setState(() {
          _marking = false;
          _done = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tuyệt vời! Bạn đã hoàn thành bài học này.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _marking = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi lưu tiến trình: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_lesson == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lỗi')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(lang == 'vi' ? 'Không thể tải bài học.' : 'Unable to load lesson.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: Text(lang == 'vi' ? 'Quay lại' : 'Go back'),
              ),
            ],
          ),
        ),
      );
    }

    final title = _lesson!['title'] as String? ?? _lesson!['titleFi'] as String? ?? '';
    final chapter = _lesson!['chapter'] as String? ?? '';
    final contentText = _lesson!['content'] as String? ?? '';
    final progress = _progressPercent;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header bài học với Gradient
          _LessonHeader(
            title: title,
            chapter: chapter,
            done: _done,
            lang: lang,
            progress: progress,
            onBack: () => context.go('/study-plan/${widget.planId}'),
          ),

          // Vùng cuộn bài đọc tương tác chính
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: MarkdownContentRenderer(
                content: contentText,
                onAudioPlayed: (url) {
                  if (!_playedAudioUrls.contains(url)) {
                    setState(() {
                      _playedAudioUrls.add(url);
                    });
                    _checkAndAutoSaveProgress();
                  }
                },
                onExerciseCompleted: (exerciseId, isCompleted) {
                  if (isCompleted && !_completedExerciseIds.contains(exerciseId)) {
                    setState(() {
                      _completedExerciseIds.add(exerciseId);
                    });
                    _checkAndAutoSaveProgress();
                  }
                },
              ),
            ),
          ),

          // Bottom Bar hành động hoàn thành
          _CompleteBar(
            done: _done,
            marking: _marking,
            lang: lang,
            progress: progress,
            onMarkDone: _markDone,
          ),
        ],
      ),
    );
  }
}

class _LessonHeader extends StatelessWidget {
  const _LessonHeader({
    required this.title,
    required this.chapter,
    required this.done,
    required this.lang,
    required this.progress,
    required this.onBack,
  });

  final String title;
  final String chapter;
  final bool done;
  final String lang;
  final double progress;
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white, size: 16),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 6,
                  children: [
                    if (chapter.isNotEmpty)
                      _WhiteChip(label: chapter),
                    _WhiteChip(
                      label: lang == 'vi' ? 'Bài học tương tác' : 'Interactive Lesson',
                      icon: Icons.menu_book_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),
              // Thanh tiến trình học
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang == 'vi' ? 'Tiến độ học tập:' : 'Learning Progress:',
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                        minHeight: 6,
                      ),
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

class _WhiteChip extends StatelessWidget {
  const _WhiteChip({required this.label, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 12),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompleteBar extends StatelessWidget {
  const _CompleteBar({
    required this.done,
    required this.marking,
    required this.lang,
    required this.progress,
    required this.onMarkDone,
  });

  final bool done;
  final bool marking;
  final String lang;
  final double progress;
  final VoidCallback onMarkDone;

  @override
  Widget build(BuildContext context) {
    final canComplete = progress >= 1.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: (done || marking || !canComplete) ? null : onMarkDone,
          icon: marking
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : Icon(done ? Icons.check_circle : Icons.check_circle_outline),
          label: Text(
            done
                ? (lang == 'vi' ? '✓ Đã học xong' : '✓ Lesson completed')
                : !canComplete
                    ? (lang == 'vi' ? 'Hãy hoàn thành toàn bộ bài tập và nghe audio' : 'Complete exercises & audios to finish')
                    : (lang == 'vi' ? 'Hoàn thành bài học' : 'Complete lesson'),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: done ? Colors.green : Colors.blueAccent,
            foregroundColor: Colors.white,
            disabledBackgroundColor: done 
                ? Colors.green 
                : !canComplete 
                    ? Colors.grey.shade300 
                    : Colors.blueAccent.withOpacity(0.6),
            disabledForegroundColor: !canComplete ? Colors.grey.shade600 : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: done ? 0 : 2,
          ),
        ),
      ),
    );
  }
}
