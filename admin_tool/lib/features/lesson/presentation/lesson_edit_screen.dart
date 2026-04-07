import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:admin_tool/core/services/storage_service.dart';
import '../../grammar/presentation/widgets/grammar_form_dialog.dart';

import 'package:admin_tool/features/lesson/data/lesson_repository.dart';
import 'package:admin_tool/features/lesson/domain/lesson.dart';
import 'package:admin_tool/features/grammar/data/grammar_repository.dart';
import 'package:admin_tool/features/grammar/domain/grammar.dart';
import 'package:admin_tool/features/exercise/data/exercise_repository.dart';
import 'package:admin_tool/features/exercise/domain/exercise.dart';

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

  late QuillController _contentController;
  late QuillController _speakingController;

  final Set<String> _selectedGrammarIds = {};
  final Set<String> _selectedExerciseIds = {};

  bool _initialized = false;
  Lesson? _originalLesson;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();

    _contentController = QuillController.basic();
    _speakingController = QuillController.basic();
  }

  void _initializeData(Lesson? lesson) {
    if (_initialized) return;
    if (lesson != null) {
      _originalLesson = lesson;
      _titleController.text = lesson.title;
      _descController.text = lesson.description ?? '';

      _selectedGrammarIds.clear();
      _selectedGrammarIds.addAll(lesson.grammarIds);

      _selectedExerciseIds.clear();
      _selectedExerciseIds.addAll(lesson.exerciseIds);

      _contentController = _loadDelta(lesson.lessonContent.text);
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
    _contentController.dispose();
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
                  _buildSectionTitle('Title'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Lesson Title *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 5,
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
                      isScrollable: true,
                      tabs: [
                        Tab(text: '1. DESCRIPTION'),
                        Tab(text: '2. LESSON CONTENT'),
                        Tab(text: '3. SPEAKING'),
                        Tab(text: '4. GRAMMAR'),
                        Tab(text: '5. EXERCISE'),
                      ],
                      labelColor: Colors.blueAccent,
                      indicatorColor: Colors.blueAccent,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1: Description
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Short Description'),
                              const SizedBox(height: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _descController,
                                  decoration: const InputDecoration(
                                    hintText:
                                        'Enter a short summary of the lesson...',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Tab 2: Content
                        _buildEditorSection(_contentController),
                        // Tab 3: Speaking
                        _buildEditorSection(_speakingController),
                        // Tab 4: Grammar
                        _buildRelationTab<Grammar>(
                          streamProvider: grammarsStreamProvider,
                          selectedIds: _selectedGrammarIds,
                          titleAttr: (g) => g.title,
                          idAttr: (g) => g.id,
                          onCreateNew: () {
                            showDialog(
                              context: context,
                              builder: (context) => const GrammarFormDialog(),
                            );
                          },
                          emptyLabel: 'Grammar',
                        ),
                        // Tab 5: Exercise
                        _buildRelationTab<Exercise>(
                          streamProvider: exercisesStreamProvider,
                          selectedIds: _selectedExerciseIds,
                          titleAttr: (e) => e.title,
                          idAttr: (e) => e.id,
                          onCreateNew: () {
                            context.push('/exercises/new');
                          },
                          emptyLabel: 'Exercise',
                        ),
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

  Widget _buildRelationTab<T>({
    required StreamProvider<List<T>> streamProvider,
    required Set<String> selectedIds,
    required String Function(T) titleAttr,
    required String Function(T) idAttr,
    required VoidCallback onCreateNew,
    required String emptyLabel,
  }) {
    final asyncData = ref.watch(streamProvider);
    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No $emptyLabel items found.'),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: onCreateNew,
                  icon: const Icon(Icons.add),
                  label: Text('Create New $emptyLabel'),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: items.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final item = items[index];
            final id = idAttr(item);
            final title = titleAttr(item);
            final isAdded = selectedIds.contains(id);

            return ListTile(
              title: Text(title),
              subtitle: Text('ID: $id'),
              trailing: isAdded
                  ? IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          selectedIds.remove(id);
                        });
                      },
                      tooltip: 'Remove',
                    )
                  : IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          selectedIds.add(id);
                        });
                      },
                      tooltip: 'Add',
                    ),
            );
          },
        );
      },
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
        grammarIds: _selectedGrammarIds.toList(),
        speaking: (_originalLesson?.speaking ?? const LessonSpeaking())
            .copyWith(text: _saveDelta(_speakingController)),
        exerciseIds: _selectedExerciseIds.toList(),
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
