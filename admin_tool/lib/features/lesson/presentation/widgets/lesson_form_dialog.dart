import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/lesson/data/lesson_repository.dart';
import 'package:admin_tool/features/lesson/domain/lesson.dart';
import 'package:admin_tool/features/grammar/data/grammar_repository.dart';
import 'package:admin_tool/features/grammar/domain/grammar.dart';
import 'package:admin_tool/features/exercise/data/exercise_repository.dart';
import 'package:admin_tool/features/exercise/domain/exercise.dart';
import 'package:admin_tool/features/grammar/presentation/widgets/grammar_form_dialog.dart';
import 'package:admin_tool/features/exercise/presentation/widgets/exercise_form_dialog.dart';

class LessonFormDialog extends ConsumerStatefulWidget {
  final Lesson? lesson;

  const LessonFormDialog({super.key, this.lesson});

  @override
  ConsumerState<LessonFormDialog> createState() => _LessonFormDialogState();
}


class _LessonFormDialogState extends ConsumerState<LessonFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  
  // Lesson Content
  late TextEditingController _contentTextController;
  late TextEditingController _videoUrlController;
  late TextEditingController _imageIdsController;
  
  // Grammar & Exercises
  final Set<String> _selectedGrammarIds = {};
  final Set<String> _selectedExerciseIds = {};
  
  // Speaking
  late TextEditingController _speakingTextController;
  late TextEditingController _speakingAudioUrlController;
  late TextEditingController _speakingConversationUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.lesson?.title ?? '');
    _descController = TextEditingController(text: widget.lesson?.description ?? '');
    
    _contentTextController = TextEditingController(text: widget.lesson?.lessonContent.text ?? '');
    _videoUrlController = TextEditingController(text: widget.lesson?.lessonContent.videoUrl ?? '');
    _imageIdsController = TextEditingController(text: widget.lesson?.lessonContent.imageIds.join(', ') ?? '');
    
    _selectedGrammarIds.addAll(widget.lesson?.grammarIds ?? []);
    _selectedExerciseIds.addAll(widget.lesson?.exerciseIds ?? []);
    
    _speakingTextController = TextEditingController(text: widget.lesson?.speaking.text ?? '');
    _speakingAudioUrlController = TextEditingController(text: widget.lesson?.speaking.audioUrl ?? '');
    _speakingConversationUrlController = TextEditingController(text: widget.lesson?.speaking.conversationUrl ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _contentTextController.dispose();
    _videoUrlController.dispose();
    _imageIdsController.dispose();
    _speakingTextController.dispose();
    _speakingAudioUrlController.dispose();
    _speakingConversationUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: AlertDialog(
        title: Text(widget.lesson == null ? 'Add New Lesson' : 'Edit Lesson'),
        content: SizedBox(
          width: 700,
          height: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title *', border: OutlineInputBorder()),
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: '1. Description'),
                  Tab(text: '2. Content'),
                  Tab(text: '3. Speaking'),
                  Tab(text: '4. Grammar'),
                  Tab(text: '5. Exercise'),
                ],
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TabBarView(
                    children: [
                      // Tab 1: Description
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _descController,
                              decoration: const InputDecoration(
                                labelText: 'Short Description',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                      // Tab 2: Content
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _contentTextController,
                              decoration: const InputDecoration(labelText: 'Lesson Content (Text/Markdown)'),
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _videoUrlController,
                              decoration: const InputDecoration(labelText: 'Video URL'),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _imageIdsController,
                              decoration: const InputDecoration(labelText: 'Image IDs (comma separated)', hintText: 'img1, img2...'),
                            ),
                          ],
                        ),
                      ),
                      // Tab 3: Speaking
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _speakingTextController,
                              decoration: const InputDecoration(labelText: 'Speaking Text'),
                              maxLines: 3,
                            ),
                            TextFormField(
                              controller: _speakingAudioUrlController,
                              decoration: const InputDecoration(labelText: 'Speaking Audio URL'),
                            ),
                            TextFormField(
                              controller: _speakingConversationUrlController,
                              decoration: const InputDecoration(labelText: 'Conversation URL'),
                            ),
                          ],
                        ),
                      ),
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
                          showDialog(
                            context: context,
                            builder: (context) => const ExerciseFormDialog(),
                          );
                        },
                        emptyLabel: 'Exercise',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: _save, child: const Text('Save')),
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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: onCreateNew,
                icon: const Icon(Icons.add),
                label: Text('Create New $emptyLabel'),
              ),
            ),
            if (items.isEmpty)
              Expanded(child: Center(child: Text('No $emptyLabel items found.')))
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final id = idAttr(item);
                    final title = titleAttr(item);
                    final isSelected = selectedIds.contains(id);
                    return CheckboxListTile(
                      title: Text(title),
                      subtitle: Text(id),
                      value: isSelected,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedIds.add(id);
                          } else {
                            selectedIds.remove(id);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final lesson = Lesson(
        id: widget.lesson?.id ?? '',
        title: _titleController.text,
        description: _descController.text,
        lessonContent: LessonContent(
          text: _contentTextController.text,
          videoUrl: _videoUrlController.text,
          imageIds: _imageIdsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        ),
        grammarIds: _selectedGrammarIds.toList(),
        speaking: LessonSpeaking(
          text: _speakingTextController.text,
          audioUrl: _speakingAudioUrlController.text,
          conversationUrl: _speakingConversationUrlController.text,
        ),
        exerciseIds: _selectedExerciseIds.toList(),
      );

      final repository = ref.read(lessonRepositoryProvider); // Access direct repository
      try {
        if (widget.lesson == null) {
          await repository.createLesson(lesson);
        } else {
          await repository.updateLesson(lesson);
        }
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving lesson: $e')));
        }
      }
    }
  }
}
