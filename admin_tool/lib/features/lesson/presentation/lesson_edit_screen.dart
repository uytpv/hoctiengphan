import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:admin_tool/core/services/storage_service.dart';
import 'package:admin_tool/features/lesson/data/lesson_repository.dart';
import 'package:admin_tool/features/lesson/domain/lesson.dart';

class LessonEditScreen extends ConsumerStatefulWidget {
  final String? lessonId;

  const LessonEditScreen({super.key, this.lessonId});

  @override
  ConsumerState<LessonEditScreen> createState() => _LessonEditScreenState();
}

class _LessonEditScreenState extends ConsumerState<LessonEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _exerciseIdsController;

  late QuillController _contentController;
  late QuillController _grammarController;
  late QuillController _speakingController;

  bool _initialized = false;
  Lesson? _originalLesson;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
    _exerciseIdsController = TextEditingController();

    _contentController = QuillController.basic();
    _grammarController = QuillController.basic();
    _speakingController = QuillController.basic();
  }

  void _initializeData(Lesson? lesson) {
    if (_initialized) return;
    if (lesson != null) {
      _originalLesson = lesson;
      _titleController.text = lesson.title;
      _descController.text = lesson.description ?? '';
      _exerciseIdsController.text = lesson.exerciseIds.join(', ');

      _contentController = _loadDelta(lesson.lessonContent.text);
      _grammarController = _loadDelta(lesson.grammar.text);
      _speakingController = _loadDelta(lesson.speaking.text);
    }
    _initialized = true;
  }

  QuillController _loadDelta(String jsonStr) {
    if (jsonStr.isEmpty) return QuillController.basic();
    try {
      final doc = Document.fromJson(jsonDecode(jsonStr));
      return QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    } catch (e) {
      final doc = Document()..insert(0, jsonStr);
      return QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  String _saveDelta(QuillController controller) {
    return jsonEncode(controller.document.toDelta().toJson());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _exerciseIdsController.dispose();
    _contentController.dispose();
    _grammarController.dispose();
    _speakingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lessonId != null && widget.lessonId != 'new') {
      final lessonsAsync = ref.watch(lessonsStreamProvider);
      return lessonsAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.lessonId == null || widget.lessonId == 'new'
              ? 'Create New Lesson'
              : 'Edit Lesson',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text('SAVE LESSON'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade700,
                foregroundColor: Colors.white,
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
          Container(
            width: 350,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey.shade200)),
              color: Colors.grey.shade50,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _buildSectionTitle('General Info'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      labelText: 'Short Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Relations'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _exerciseIdsController,
                    decoration: const InputDecoration(
                      labelText: 'Exercise IDs',
                      hintText: 'ex1, ex2...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Separated by comma',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: const TabBar(
                      tabs: [
                        Tab(text: '1. LESSON CONTENT'),
                        Tab(text: '2. GRAMMAR'),
                        Tab(text: '3. SPEAKING'),
                      ],
                      labelColor: Colors.blueAccent,
                      indicatorColor: Colors.blueAccent,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildEditorSection(_contentController),
                        _buildEditorSection(_grammarController),
                        _buildEditorSection(_speakingController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        color: Colors.grey.shade700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildEditorSection(QuillController controller) {
    return Column(
      children: [
        QuillSimpleToolbar(
          controller: controller,
          config: QuillSimpleToolbarConfig(
            showFontSize: true,
            showFontFamily: true,
            showBoldButton: true,
            showItalicButton: true,
            showUnderLineButton: true,
            showStrikeThrough: true,
            showColorButton: true,
            showBackgroundColorButton: true,
            showListBullets: true,
            showListNumbers: true,
            showAlignmentButtons: true,
            showLink: true,
            embedButtons: FlutterQuillEmbeds.toolbarButtons(
              imageButtonOptions: QuillToolbarImageButtonOptions(
                imageButtonConfig: QuillToolbarImageConfig(
                  onRequestPickImage: (context) async {
                    // This triggers the StorageService to pick and upload the image
                    // and returns the URL string to be inserted into the document.
                    return await ref
                        .read(storageServiceProvider)
                        .pickAndUploadImage();
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: QuillEditor.basic(
              controller: controller,
              config: QuillEditorConfig(
                autoFocus: false,
                expands: true,
                padding: EdgeInsets.zero,
                embedBuilders: kIsWeb
                    ? FlutterQuillEmbeds.editorWebBuilders()
                    : FlutterQuillEmbeds.editorBuilders(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final lesson = Lesson(
        id: _originalLesson?.id ?? '',
        title: _titleController.text,
        description: _descController.text,
        lessonContent: (_originalLesson?.lessonContent ?? const LessonContent())
            .copyWith(text: _saveDelta(_contentController)),
        grammar: (_originalLesson?.grammar ?? const LessonGrammar()).copyWith(
          text: _saveDelta(_grammarController),
        ),
        speaking: (_originalLesson?.speaking ?? const LessonSpeaking())
            .copyWith(text: _saveDelta(_speakingController)),
        exerciseIds: _exerciseIdsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      );

      final repository = ref.read(lessonRepositoryProvider);
      try {
        if (widget.lessonId == null || widget.lessonId == 'new') {
          await repository.createLesson(lesson);
        } else {
          await repository.updateLesson(lesson);
        }
        if (mounted) context.pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error saving lesson: $e')));
        }
      }
    }
  }
}
