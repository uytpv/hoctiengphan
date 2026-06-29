import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:admin_tool/features/lesson/data/lesson_repository.dart';
import 'package:admin_tool/features/lesson/domain/lesson.dart';
import 'package:admin_tool/features/exercise/data/exercise_repository.dart';
import 'package:admin_tool/features/exercise/domain/exercise.dart' as model_ex;
import 'package:admin_tool/features/activity/data/activity_repository.dart';
import 'package:admin_tool/features/study_plan/data/study_plan_repository.dart';
import 'package:admin_tool/features/study_plan/domain/study_plan.dart';
import 'widgets/markdown_preview.dart';

class LessonEditScreen extends ConsumerStatefulWidget {
  final String? lessonId;

  const LessonEditScreen({super.key, this.lessonId});

  @override
  ConsumerState<LessonEditScreen> createState() => _LessonEditScreenState();
}

class _LessonEditScreenState extends ConsumerState<LessonEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _chapterController;
  late TextEditingController _descController;
  late TextEditingController _contentController;

  bool _initialized = false;
  bool _saving = false;
  Lesson? _originalLesson;

  List<StudyPlan> _allPlans = [];
  List<StudyPlanWeek> _allWeeks = [];
  List<LessonLink> _assignedLinks = [];
  bool _loadingPlansAndWeeks = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _chapterController = TextEditingController();
    _descController = TextEditingController();
    _contentController = TextEditingController();

    // Lắng nghe thay đổi nội dung Markdown để tự động cập nhật Live Preview
    _contentController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPlansAndLinks(widget.lessonId);
    });
  }

  Future<void> _loadPlansAndLinks(String? lessonId) async {
    try {
      final planRepo = ref.read(studyPlanRepositoryProvider);
      final activityRepo = ref.read(activityRepositoryProvider);

      final plans = await planRepo.getPlansOnce();
      final weeks = await planRepo.getAllWeeksOnce();

      final List<LessonLink> links = [];

      if (lessonId != null && lessonId != 'new') {
        final activity = await activityRepo.getActivityByLessonId(lessonId);
        if (activity != null) {
          for (final week in weeks) {
            for (final day in week.days) {
              if (day.activityIds.contains(activity.id)) {
                final plan = plans.firstWhere((p) => p.id == week.planId);
                links.add(LessonLink(plan: plan, week: week, dayName: day.dayName));
              }
            }
          }
        }
      }

      if (mounted) {
        setState(() {
          _allPlans = plans;
          _allWeeks = weeks;
          _assignedLinks = links;
          _loadingPlansAndWeeks = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading plans/links: $e');
      }
      if (mounted) {
        setState(() {
          _loadingPlansAndWeeks = false;
        });
      }
    }
  }

  void _showAddLinkDialog() {
    if (_allPlans.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có lộ trình học nào để gán.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AddLessonLinkDialog(
          plans: _allPlans,
          weeks: _allWeeks,
          onAdd: (link) {
            final exists = _assignedLinks.any((l) =>
                l.plan.id == link.plan.id &&
                l.week.id == link.week.id &&
                l.dayName == link.dayName);
            if (!exists) {
              setState(() {
                _assignedLinks.add(link);
              });
            }
          },
        );
      },
    );
  }

  void _initializeData(Lesson? lesson) {
    if (_initialized) return;
    if (lesson != null) {
      _originalLesson = lesson;
      _titleController.text = lesson.title;
      _chapterController.text = lesson.chapter;
      _descController.text = lesson.description ?? '';
      _contentController.text = lesson.content;
    }
    _initialized = true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _chapterController.dispose();
    _descController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Chèn text vào vị trí con trỏ chuột
  void _insertTextAtCursor(String text) {
    final selection = _contentController.selection;
    final currentText = _contentController.text;

    if (selection.start >= 0 && selection.end >= 0) {
      final newText = currentText.replaceRange(selection.start, selection.end, text);
      _contentController.value = _contentController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start + text.length),
      );
    } else {
      final newText = currentText + text;
      _contentController.value = _contentController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  // --- Toolbar Actions ---

  // 1. Chèn từ vựng (Tìm kiếm từ có sẵn hoặc tạo mới)
  Future<void> _showAddVocabDialog() async {
    final selectedText = _contentController.selection.start >= 0 && 
            _contentController.selection.end > _contentController.selection.start
        ? _contentController.text.substring(
            _contentController.selection.start, _contentController.selection.end)
        : '';

    showDialog(
      context: context,
      builder: (context) {
        return _AddVocabDialog(
          initialSearchText: selectedText,
          onVocabSelected: (vocabId, word) {
            _insertTextAtCursor('[vocab:$vocabId|$word]');
          },
        );
      },
    );
  }

  // 2. Chèn File nghe (Upload MP3 lên Storage hoặc dán URL)
  Future<void> _showAddAudioDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return _AddAudioDialog(
          onAudioInserted: (audioUrl) {
            _insertTextAtCursor('[audio:$audioUrl]');
          },
        );
      },
    );
  }

  // 3. Chèn Video YouTube (Nhập ID hoặc link)
  Future<void> _showAddVideoDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return _AddVideoDialog(
          onVideoInserted: (videoId) {
            _insertTextAtCursor('[video:$videoId]');
          },
        );
      },
    );
  }

  // 4. Chèn Bài tập (Chọn từ ngân hàng hoặc tạo mới)
  Future<void> _showAddExerciseDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return _AddExerciseDialog(
          onExerciseSelected: (exerciseId) {
            _insertTextAtCursor('[exercise:$exerciseId]');
          },
        );
      },
    );
  }

  // 5. Chèn Ngữ pháp (Grammar)
  Future<void> _showAddGrammarDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return _AddGrammarDialog(
          onGrammarSelected: (grammarId) {
            _insertTextAtCursor('[grammar:$grammarId]');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lessonId != null && widget.lessonId != 'new') {
      final lessonsAsync = ref.watch(lessonsStreamProvider);
      return lessonsAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, s) => Scaffold(body: Center(child: Text('Lỗi tải bài học: $e'))),
        data: (lessons) {
          final lesson = lessons.firstWhere((l) => l.id == widget.lessonId);
          _initializeData(lesson);
          return _buildScaffold();
        },
      );
    } else {
      _initialized = true;
      return _buildScaffold();
    }
  }

  Widget _buildScaffold() {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          widget.lessonId == null || widget.lessonId == 'new'
              ? 'Soạn Bài học Mới'
              : 'Sửa Bài học',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save),
              label: Text(_saving ? 'ĐANG LƯU...' : 'LƯU BÀI HỌC'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cột bên trái: Soạn thảo văn bản và cấu hình
          Expanded(
            flex: 3,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thông tin chung',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Tiêu đề bài học (Ví dụ: Giới thiệu bản thân)',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) => val == null || val.isEmpty
                                    ? 'Vui lòng nhập tiêu đề'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _chapterController,
                                decoration: const InputDecoration(
                                  labelText: 'Kappale (Ví dụ: Kappale 1)',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) => val == null || val.isEmpty
                                    ? 'Vui lòng nhập Kappale'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descController,
                          decoration: const InputDecoration(
                            labelText: 'Mô tả ngắn gọn nội dung bài học',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),
                        
                        // Lộ trình học (Study Plan Link)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Liên kết lộ trình học',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Gán bài học này vào một hoặc nhiều ngày trong lộ trình học',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            OutlinedButton.icon(
                              onPressed: _showAddLinkDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('Thêm liên kết lộ trình'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (_assignedLinks.isEmpty)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.05),
                              border: Border.all(color: Colors.amber.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.warning_amber, color: Colors.amber),
                                SizedBox(width: 8),
                                Text(
                                  'Bài học chưa được liên kết với ngày học nào trong Lộ trình.',
                                  style: TextStyle(fontSize: 13, color: Colors.black87),
                                ),
                              ],
                            ),
                          )
                        else
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _assignedLinks.map((link) {
                              return Chip(
                                label: Text(
                                  '${link.plan.title} > ${link.week.title} > ${link.dayName}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                onDeleted: () {
                                  setState(() {
                                    _assignedLinks.remove(link);
                                  });
                                },
                                deleteIconColor: Colors.redAccent,
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),

                        // Soạn thảo Markdown
                        const Text(
                          'Nội dung bài học (Markdown)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        
                        // Toolbar soạn thảo
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                          ),
                          child: Wrap(
                            spacing: 4,
                            children: [
                              _ToolbarButton(
                                icon: Icons.title,
                                tooltip: 'Tiêu đề lớn (H1)',
                                onPressed: () => _insertTextAtCursor('\n# '),
                              ),
                              _ToolbarButton(
                                icon: Icons.text_fields,
                                tooltip: 'Tiêu đề vừa (H2)',
                                onPressed: () => _insertTextAtCursor('\n## '),
                              ),
                              _ToolbarButton(
                                icon: Icons.format_bold,
                                tooltip: 'Chữ in đậm',
                                onPressed: () => _insertTextAtCursor('**Chữ đậm**'),
                              ),
                              _ToolbarButton(
                                icon: Icons.format_italic,
                                tooltip: 'Chữ in nghiêng',
                                onPressed: () => _insertTextAtCursor('*Chữ nghiêng*'),
                              ),
                              const VerticalDivider(width: 8),
                              _ToolbarButton(
                                icon: Icons.book,
                                tooltip: 'Nhúng Từ vựng tương tác',
                                color: Colors.blueAccent,
                                onPressed: _showAddVocabDialog,
                              ),
                              _ToolbarButton(
                                icon: Icons.volume_up,
                                tooltip: 'Nhúng File nghe (Audio)',
                                color: Colors.blueAccent,
                                onPressed: _showAddAudioDialog,
                              ),
                              _ToolbarButton(
                                icon: Icons.play_circle_filled,
                                tooltip: 'Nhúng Video YouTube',
                                color: Colors.redAccent,
                                onPressed: _showAddVideoDialog,
                              ),
                              _ToolbarButton(
                                icon: Icons.quiz,
                                tooltip: 'Nhúng Bài tập (Quiz)',
                                color: Colors.green,
                                onPressed: _showAddExerciseDialog,
                              ),
                              _ToolbarButton(
                                icon: Icons.history_edu,
                                tooltip: 'Nhúng Ngữ pháp',
                                color: Colors.purple,
                                onPressed: _showAddGrammarDialog,
                              ),
                            ],
                          ),
                        ),
                        
                        // Text Area nhập liệu
                        TextFormField(
                          controller: _contentController,
                          maxLines: 28,
                          decoration: const InputDecoration(
                            hintText: 'Nhập văn bản bài giảng bằng Markdown tại đây. Dùng toolbar ở trên để nhúng nhanh từ vựng, nghe và bài tập...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                            ),
                          ),
                          style: const TextStyle(fontFamily: 'Courier', fontSize: 14),
                          validator: (val) => val == null || val.isEmpty
                              ? 'Vui lòng viết nội dung bài giảng'
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Cột bên phải: Trình giả lập Mobile Live Preview
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey.shade200)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Icon(Icons.phone_android, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Live Mobile Preview',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Khung thiết bị Mobile giả lập
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 8),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          title: Text(
                            _titleController.text.isEmpty ? 'Tiêu đề bài học' : _titleController.text,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: const Color(0xFF0056D2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          centerTitle: true,
                        ),
                        body: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: MarkdownPreview(content: _contentController.text),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Logic Save Bài học ---
  void _save() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _saving = true);
      final contentText = _contentController.text;

      // 1. Quét shortcode để tự động trích xuất IDs
      final vocabMatches = RegExp(r'\[vocab:([^\|\]]+)\|([^\]]+)\]').allMatches(contentText);
      final vocabIds = vocabMatches.map((m) => m.group(1)!).toSet().toList();

      final exerciseMatches = RegExp(r'\[exercise:([^\]]+)\]').allMatches(contentText);
      final exerciseIds = exerciseMatches.map((m) => m.group(1)!).toSet().toList();

      final audioMatches = RegExp(r'\[audio:([^\]]+)\]').allMatches(contentText);
      final audioUrls = audioMatches.map((m) => m.group(1)!).toSet().toList();

      final grammarMatches = RegExp(r'\[grammar:([^\]]+)\]').allMatches(contentText);
      final grammarIds = grammarMatches.map((m) => m.group(1)!).toSet().toList();

      final lesson = Lesson(
        id: _originalLesson?.id ?? '',
        title: _titleController.text,
        chapter: _chapterController.text,
        description: _descController.text,
        content: contentText,
        vocabIds: vocabIds,
        exerciseIds: exerciseIds,
        audioUrls: audioUrls,
        grammarIds: grammarIds,
        createdAt: _originalLesson?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final repository = ref.read(lessonRepositoryProvider);
      try {
        String savedId;
        if (widget.lessonId == null || widget.lessonId == 'new') {
          savedId = await repository.createLesson(lesson);
        } else {
          savedId = lesson.id;
          await repository.updateLesson(lesson);
        }

        // Tự động đồng bộ sang Activity container trung gian
        final activityId = await ref.read(activityRepositoryProvider).upsertLessonActivity(
          savedId,
          lesson.title,
          lesson.description ?? '',
        );

        // Cập nhật liên kết lộ trình học (Study Plan Weeks)
        final planRepo = ref.read(studyPlanRepositoryProvider);
        final latestWeeks = await planRepo.getAllWeeksOnce();

        for (final week in latestWeeks) {
          bool weekChanged = false;
          final updatedDays = week.days.map((day) {
            final hasActivity = day.activityIds.contains(activityId);
            final shouldHaveActivity = _assignedLinks.any((link) =>
                link.week.id == week.id && link.dayName == day.dayName);

            if (hasActivity && !shouldHaveActivity) {
              weekChanged = true;
              return day.copyWith(
                activityIds: day.activityIds.where((id) => id != activityId).toList(),
              );
            } else if (!hasActivity && shouldHaveActivity) {
              weekChanged = true;
              return day.copyWith(
                activityIds: [...day.activityIds, activityId],
              );
            }
            return day;
          }).toList();

          if (weekChanged) {
            final updatedWeek = week.copyWith(days: updatedDays);
            await planRepo.updateWeek(updatedWeek);
          }
        }

        if (mounted) {
          setState(() => _saving = false);
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          setState(() => _saving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi khi lưu bài học: $e')),
          );
        }
      }
    }
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? color;

  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 18),
      tooltip: tooltip,
      onPressed: onPressed,
      color: color ?? Colors.grey.shade700,
      visualDensity: VisualDensity.compact,
    );
  }
}

// --- Các Dialog phụ trợ soạn thảo ---

/// Dialog chọn Từ vựng có sẵn hoặc tạo mới
class _AddVocabDialog extends StatefulWidget {
  final String initialSearchText;
  final Function(String id, String word) onVocabSelected;

  const _AddVocabDialog({required this.initialSearchText, required this.onVocabSelected});

  @override
  State<_AddVocabDialog> createState() => _AddVocabDialogState();
}

class _AddVocabDialogState extends State<_AddVocabDialog> {
  String _searchQuery = '';
  bool _creatingNew = false;
  
  // Form tạo mới
  final _vocabFormKey = GlobalKey<FormState>();
  final _finnishController = TextEditingController();
  final _vietnameseController = TextEditingController();
  final _englishController = TextEditingController();
  final _pronunciationController = TextEditingController();
  final _audioUrlController = TextEditingController();
  bool _savingNewVocab = false;

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.initialSearchText;
    _finnishController.text = widget.initialSearchText;
  }

  @override
  void dispose() {
    _finnishController.dispose();
    _vietnameseController.dispose();
    _englishController.dispose();
    _pronunciationController.dispose();
    _audioUrlController.dispose();
    super.dispose();
  }

  Future<void> _createNewVocab() async {
    if (_vocabFormKey.currentState!.validate()) {
      setState(() => _savingNewVocab = true);
      try {
        final docRef = await FirebaseFirestore.instance.collection('vocabularies').add({
          'finnish': _finnishController.text,
          'vietnamese': _vietnameseController.text,
          'english': _englishController.text,
          'pronunciation': _pronunciationController.text,
          'audioUrl': _audioUrlController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        widget.onVocabSelected(docRef.id, _finnishController.text);
        if (mounted) Navigator.pop(context);
      } catch (e) {
        setState(() => _savingNewVocab = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi tạo từ vựng: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_creatingNew ? 'Tạo Từ vựng Mới' : 'Gắn Từ vựng Tương tác'),
      content: SizedBox(
        width: 500,
        height: 450,
        child: _creatingNew ? _buildCreateForm() : _buildSearchList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        if (_creatingNew) ...[
          TextButton(
            onPressed: () => setState(() => _creatingNew = false),
            child: const Text('Quay lại Tìm kiếm'),
          ),
          ElevatedButton(
            onPressed: _savingNewVocab ? null : _createNewVocab,
            child: const Text('Tạo & Chèn'),
          ),
        ] else
          ElevatedButton.icon(
            onPressed: () => setState(() => _creatingNew = true),
            icon: const Icon(Icons.add),
            label: const Text('Tạo từ mới'),
          ),
      ],
    );
  }

  Widget _buildSearchList() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm từ vựng Phần Lan...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (val) => setState(() => _searchQuery = val),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('vocabularies').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;
              final filtered = docs.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final fi = (data['finnish'] ?? '').toString().toLowerCase();
                final vi = (data['vietnamese'] ?? '').toString().toLowerCase();
                final q = _searchQuery.toLowerCase();
                return fi.contains(q) || vi.contains(q);
              }).toList();

              if (filtered.isEmpty) {
                return const Center(
                  child: Text('Không tìm thấy từ vựng nào. Hãy tạo từ mới!'),
                );
              }

              return ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final doc = filtered[index];
                  final data = doc.data() as Map<String, dynamic>;
                  final fi = data['finnish'] ?? '';
                  final vi = data['vietnamese'] ?? '';
                  final pr = data['pronunciation'] ?? '';

                  return ListTile(
                    title: Text(fi, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('$pr - Nghĩa: $vi'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      widget.onVocabSelected(doc.id, fi);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreateForm() {
    return Form(
      key: _vocabFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _finnishController,
              decoration: const InputDecoration(labelText: 'Từ tiếng Phần Lan (*)', border: OutlineInputBorder()),
              validator: (val) => val == null || val.isEmpty ? 'Không được để trống' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _vietnameseController,
              decoration: const InputDecoration(labelText: 'Nghĩa tiếng Việt (*)', border: OutlineInputBorder()),
              validator: (val) => val == null || val.isEmpty ? 'Không được để trống' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _englishController,
              decoration: const InputDecoration(labelText: 'Nghĩa tiếng Anh', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _pronunciationController,
              decoration: const InputDecoration(labelText: 'Phiên âm đọc (Ví dụ: moi)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _audioUrlController,
              decoration: const InputDecoration(labelText: 'Link URL file phát âm (.mp3)', border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog chèn Audio
class _AddAudioDialog extends StatefulWidget {
  final Function(String url) onAudioInserted;
  const _AddAudioDialog({required this.onAudioInserted});

  @override
  State<_AddAudioDialog> createState() => _AddAudioDialogState();
}

class _AddAudioDialogState extends State<_AddAudioDialog> {
  final _urlController = TextEditingController();
  bool _uploading = false;
  String? _uploadError;

  Future<void> _uploadAudio() async {
    final result = await FilePicker.pickFiles(
      type: FileType.audio,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    setState(() {
      _uploading = true;
      _uploadError = null;
    });

    try {
      final file = result.files.first;
      final fileName = '${const Uuid().v4()}_${file.name}';
      final ref = FirebaseStorage.instance.ref().child('audios/lessons/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(file.bytes!);
      } else {
        // Fallback cho local path nếu chạy offline
        throw Exception('Chỉ hỗ trợ upload trực tiếp từ Admin Tool Web');
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      widget.onAudioInserted(downloadUrl);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() {
        _uploading = false;
        _uploadError = 'Lỗi upload file: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chèn File nghe (Audio)'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: _uploading ? null : _uploadAudio,
            icon: _uploading 
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.cloud_upload),
            label: Text(_uploading ? 'Đang upload file...' : 'Tải file MP3 lên hệ thống'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          if (_uploadError != null) ...[
            const SizedBox(height: 8),
            Text(_uploadError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ],
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('HOẶC', style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'Dán trực tiếp URL file Audio (.mp3)',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_urlController.text.trim().isNotEmpty) {
              widget.onAudioInserted(_urlController.text.trim());
              Navigator.pop(context);
            }
          },
          child: const Text('Chèn URL'),
        ),
      ],
    );
  }
}

/// Dialog chèn Video YouTube
class _AddVideoDialog extends StatefulWidget {
  final Function(String id) onVideoInserted;
  const _AddVideoDialog({required this.onVideoInserted});

  @override
  State<_AddVideoDialog> createState() => _AddVideoDialogState();
}

class _AddVideoDialogState extends State<_AddVideoDialog> {
  final _controller = TextEditingController();

  String? _extractYoutubeId(String text) {
    if (text.length == 11) return text; // Có vẻ là ID sẵn rồi
    final regExp = RegExp(
      r'^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(text);
    if (match != null && match.groupCount >= 2) {
      return match.group(2);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chèn Video YouTube'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Nhập ID YouTube hoặc Link Video',
          hintText: 'Ví dụ: watch?v=dQw4w9WgXcQ',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            final id = _extractYoutubeId(_controller.text.trim());
            if (id != null) {
              widget.onVideoInserted(id);
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đường link không hợp lệ, không tìm thấy YouTube Video ID')),
              );
            }
          },
          child: const Text('Chèn Video'),
        ),
      ],
    );
  }
}

/// Dialog chèn Bài tập (Exercise)
class _AddExerciseDialog extends StatefulWidget {
  final Function(String id) onExerciseSelected;
  const _AddExerciseDialog({required this.onExerciseSelected});

  @override
  State<_AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<_AddExerciseDialog> {
  String _searchQuery = '';
  bool _creatingNew = false;

  // Form tạo bài tập mới nhanh
  final _exerciseFormKey = GlobalKey<FormState>();
  final _exTitleController = TextEditingController();
  final _exInstructionController = TextEditingController();
  
  // Trạng thái lưu danh sách câu hỏi
  final List<Map<String, dynamic>> _questionsList = [];

  @override
  void dispose() {
    _exTitleController.dispose();
    _exInstructionController.dispose();
    super.dispose();
  }

  void _addQuestion(Map<String, dynamic> q) {
    setState(() {
      _questionsList.add(q);
    });
  }

  Future<void> _saveNewExercise() async {
    if (_exerciseFormKey.currentState!.validate()) {
      if (_questionsList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng thêm ít nhất một câu hỏi')),
        );
        return;
      }

      try {
        final docRef = await FirebaseFirestore.instance.collection('exercises').add({
          'title': _exTitleController.text,
          'titleFi': _exTitleController.text,
          'instructionFi': _exInstructionController.text,
          'questions': _questionsList,
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        widget.onExerciseSelected(docRef.id);
        if (mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi tạo bài tập: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_creatingNew ? 'Tạo Bài tập tương tác mới' : 'Nhúng Bài tập (Quiz)'),
      content: SizedBox(
        width: 600,
        height: 500,
        child: _creatingNew ? _buildCreateForm() : _buildSearchList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        if (_creatingNew) ...[
          TextButton(
            onPressed: () => setState(() => _creatingNew = false),
            child: const Text('Quay lại Tìm kiếm'),
          ),
          ElevatedButton(
            onPressed: _saveNewExercise,
            child: const Text('Tạo & Chèn'),
          ),
        ] else
          ElevatedButton.icon(
            onPressed: () => setState(() => _creatingNew = true),
            icon: const Icon(Icons.add),
            label: const Text('Tạo bài tập mới'),
          ),
      ],
    );
  }

  Widget _buildSearchList() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Tìm bài tập theo tiêu đề...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (val) => setState(() => _searchQuery = val),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('exercises').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;
              final filtered = docs.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final title = (data['title'] ?? data['titleFi'] ?? data['instructionFi'] ?? '').toString().toLowerCase();
                return title.contains(_searchQuery.toLowerCase());
              }).toList();

              if (filtered.isEmpty) {
                return const Center(
                  child: Text('Không tìm thấy bài tập nào.'),
                );
              }

              return ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final doc = filtered[index];
                  final data = doc.data() as Map<String, dynamic>;
                  final title = data['title'] ?? data['titleFi'] ?? data['instructionFi'] ?? 'Bài tập';
                  final count = (data['questions'] as List?)?.length ?? 0;

                  return ListTile(
                    title: Text(title.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('ID: ${doc.id} - Số câu hỏi: $count câu'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      widget.onExerciseSelected(doc.id);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreateForm() {
    return Form(
      key: _exerciseFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _exTitleController,
            decoration: const InputDecoration(labelText: 'Tiêu đề bài tập (*)', border: OutlineInputBorder()),
            validator: (val) => val == null || val.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _exInstructionController,
            decoration: const InputDecoration(labelText: 'Lời dẫn / Hướng dẫn học viên (*)', border: OutlineInputBorder()),
            validator: (val) => val == null || val.isEmpty ? 'Vui lòng nhập hướng dẫn' : null,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Danh sách câu hỏi (${_questionsList.length})',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              OutlinedButton.icon(
                onPressed: _showAddQuestionDialog,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Thêm câu hỏi'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _questionsList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Chưa có câu hỏi nào. Hãy thêm câu hỏi đầu tiên!'),
                  )
                : ListView.builder(
                    itemCount: _questionsList.length,
                    itemBuilder: (context, index) {
                      final q = _questionsList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text('Câu ${index + 1}: ${q['prompt']}'),
                          subtitle: Text('Loại: ${q['type']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() => _questionsList.removeAt(index)),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddQuestionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return _AddQuestionDialog(
          onAdd: _addQuestion,
        );
      },
    );
  }
}

/// Dialog tạo một Câu hỏi cụ thể
class _AddQuestionDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;
  const _AddQuestionDialog({required this.onAdd});

  @override
  State<_AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<_AddQuestionDialog> {
  final _qFormKey = GlobalKey<FormState>();
  final _promptController = TextEditingController();
  final _explanationController = TextEditingController();
  
  String _type = 'MULTIPLE_CHOICE'; // MULTIPLE_CHOICE, FILL_IN_BLANK, TRUE_FALSE

  // Cho MULTIPLE_CHOICE
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  int _correctIndex = 0;

  // Cho FILL_IN_BLANK
  final _correctTextController = TextEditingController();

  // Cho TRUE_FALSE
  bool _correctTrueFalse = true; // true = Đúng, false = Sai

  @override
  void dispose() {
    _promptController.dispose();
    _explanationController.dispose();
    for (var c in _optionControllers) {
      c.dispose();
    }
    _correctTextController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_qFormKey.currentState!.validate()) {
      final Map<String, dynamic> data = {
        'prompt': _promptController.text,
        'type': _type,
        'explanation': _explanationController.text,
      };

      if (_type == 'MULTIPLE_CHOICE') {
        data['options'] = _optionControllers.map((c) => c.text).toList();
        data['correctIndex'] = _correctIndex;
      } else if (_type == 'FILL_IN_BLANK') {
        data['correctText'] = _correctTextController.text;
      } else if (_type == 'TRUE_FALSE') {
        data['correctIndex'] = _correctTrueFalse ? 0 : 1; // 0: True, 1: False
      }

      widget.onAdd(data);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm câu hỏi'),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _qFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: const InputDecoration(labelText: 'Loại câu hỏi', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'MULTIPLE_CHOICE', child: Text('Trắc nghiệm (A, B, C...)')),
                    DropdownMenuItem(value: 'TRUE_FALSE', child: Text('Đúng / Sai')),
                    DropdownMenuItem(value: 'FILL_IN_BLANK', child: Text('Điền từ trống')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _type = val);
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _promptController,
                  decoration: const InputDecoration(labelText: 'Nội dung câu hỏi (*)', border: OutlineInputBorder()),
                  validator: (val) => val == null || val.isEmpty ? 'Vui lòng nhập câu hỏi' : null,
                ),
                const SizedBox(height: 12),
                
                // Form động theo loại câu hỏi
                if (_type == 'MULTIPLE_CHOICE') _buildMultipleChoiceFields(),
                if (_type == 'TRUE_FALSE') _buildTrueFalseFields(),
                if (_type == 'FILL_IN_BLANK') _buildFillInBlankFields(),
                
                const SizedBox(height: 12),
                TextFormField(
                  controller: _explanationController,
                  decoration: const InputDecoration(labelText: 'Giải thích đáp án', border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Thêm'),
        ),
      ],
    );
  }

  Widget _buildMultipleChoiceFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Danh sách lựa chọn', style: TextStyle(fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() {
                  _optionControllers.add(TextEditingController());
                });
              },
              child: const Text('+ Thêm lựa chọn'),
            ),
          ],
        ),
        Column(
          children: List.generate(_optionControllers.length, (index) {
            return Row(
              children: [
                Radio<int>(
                  value: index,
                  groupValue: _correctIndex,
                  onChanged: (val) {
                    if (val != null) setState(() => _correctIndex = val);
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: _optionControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Lựa chọn ${String.fromCharCode(65 + index)}',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.isEmpty ? 'Không được bỏ trống' : null,
                  ),
                ),
                if (_optionControllers.length > 2)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _optionControllers.removeAt(index);
                        if (_correctIndex >= _optionControllers.length) {
                          _correctIndex = 0;
                        }
                      });
                    },
                  ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTrueFalseFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text('Đáp án đúng', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: ChoiceChip(
                label: const Text('Đúng'),
                selected: _correctTrueFalse == true,
                onSelected: (val) => setState(() => _correctTrueFalse = true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ChoiceChip(
                label: const Text('Sai'),
                selected: _correctTrueFalse == false,
                onSelected: (val) => setState(() => _correctTrueFalse = false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFillInBlankFields() {
    return Column(
      children: [
        const SizedBox(height: 8),
        TextFormField(
          controller: _correctTextController,
          decoration: const InputDecoration(labelText: 'Từ đáp án đúng (*)', border: OutlineInputBorder()),
          validator: (val) => val == null || val.isEmpty ? 'Không được bỏ trống' : null,
        ),
      ],
    );
  }
}

class LessonLink {
  final StudyPlan plan;
  final StudyPlanWeek week;
  final String dayName;

  LessonLink({required this.plan, required this.week, required this.dayName});
}

class AddLessonLinkDialog extends StatefulWidget {
  final List<StudyPlan> plans;
  final List<StudyPlanWeek> weeks;
  final Function(LessonLink) onAdd;

  const AddLessonLinkDialog({
    super.key,
    required this.plans,
    required this.weeks,
    required this.onAdd,
  });

  @override
  State<AddLessonLinkDialog> createState() => _AddLessonLinkDialogState();
}

class _AddLessonLinkDialogState extends State<AddLessonLinkDialog> {
  StudyPlan? _selectedPlan;
  StudyPlanWeek? _selectedWeek;
  String? _selectedDayName;

  final List<String> _days = [
    'Thứ 2',
    'Thứ 3',
    'Thứ 4',
    'Thứ 5',
    'Thứ 6',
    'Thứ 7',
    'Chủ Nhật'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.plans.isNotEmpty) {
      _selectedPlan = widget.plans.first;
      _updateWeeks();
    }
  }

  void _updateWeeks() {
    if (_selectedPlan == null) return;
    final planWeeks = widget.weeks.where((w) => w.planId == _selectedPlan!.id).toList();
    if (planWeeks.isNotEmpty) {
      _selectedWeek = planWeeks.first;
    } else {
      _selectedWeek = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final planWeeks = _selectedPlan == null
        ? <StudyPlanWeek>[]
        : widget.weeks.where((w) => w.planId == _selectedPlan!.id).toList();

    return AlertDialog(
      title: const Text('Thêm liên kết Lộ trình học'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<StudyPlan>(
            value: _selectedPlan,
            decoration: const InputDecoration(labelText: 'Chọn Lộ trình'),
            items: widget.plans.map((p) {
              return DropdownMenuItem(value: p, child: Text(p.title));
            }).toList(),
            onChanged: (val) {
              setState(() {
                _selectedPlan = val;
                _updateWeeks();
              });
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<StudyPlanWeek>(
            value: _selectedWeek,
            decoration: const InputDecoration(labelText: 'Chọn Tuần học'),
            items: planWeeks.map((w) {
              return DropdownMenuItem(value: w, child: Text(w.title));
            }).toList(),
            onChanged: (val) {
              setState(() {
                _selectedWeek = val;
              });
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedDayName,
            decoration: const InputDecoration(labelText: 'Chọn Ngày học'),
            items: _days.map((d) {
              return DropdownMenuItem(value: d, child: Text(d));
            }).toList(),
            onChanged: (val) {
              setState(() {
                _selectedDayName = val;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _selectedPlan == null || _selectedWeek == null || _selectedDayName == null
              ? null
              : () {
                  widget.onAdd(LessonLink(
                    plan: _selectedPlan!,
                    week: _selectedWeek!,
                    dayName: _selectedDayName!,
                  ));
                  Navigator.pop(context);
                },
          child: const Text('Gán liên kết'),
        ),
      ],
    );
  }
}

/// Dialog chèn Ngữ pháp (Grammar)
class _AddGrammarDialog extends StatefulWidget {
  final Function(String id) onGrammarSelected;
  const _AddGrammarDialog({required this.onGrammarSelected});

  @override
  State<_AddGrammarDialog> createState() => _AddGrammarDialogState();
}

class _AddGrammarDialogState extends State<_AddGrammarDialog> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nhúng bài Ngữ pháp'),
      content: SizedBox(
        width: 500,
        height: 400,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Tìm bài ngữ pháp theo tiêu đề...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('grammars').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;
                  final filtered = docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final title = (data['title'] ?? '').toString().toLowerCase();
                    final slug = (data['slug'] ?? '').toString().toLowerCase();
                    final q = _searchQuery.toLowerCase();
                    return title.contains(q) || slug.contains(q);
                  }).toList();

                  if (filtered.isEmpty) {
                    return const Center(
                      child: Text('Không tìm thấy bài ngữ pháp nào.'),
                    );
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final doc = filtered[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final title = data['title'] ?? 'Ngữ pháp';
                      final slug = data['slug'] ?? '';

                      return ListTile(
                        leading: const Icon(Icons.history_edu, color: Colors.purple),
                        title: Text(title.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('ID: ${doc.id} ${slug.isNotEmpty ? "- Chương: $slug" : ""}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          widget.onGrammarSelected(doc.id);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
      ],
    );
  }
}

