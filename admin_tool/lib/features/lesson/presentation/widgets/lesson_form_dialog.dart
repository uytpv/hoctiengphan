import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/lesson.dart';
import '../../data/lesson_repository.dart'; // Correct import

class LessonFormDialog extends ConsumerStatefulWidget {
  final Lesson? lesson;

  const LessonFormDialog({super.key, this.lesson});

  @override
  ConsumerState<LessonFormDialog> createState() => _LessonFormDialogState();
}

class _StarDivider extends StatelessWidget {
  final String label;
  const _StarDivider(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class _LessonFormDialogState extends ConsumerState<LessonFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  
  // Lesson Content
  late TextEditingController _contentTextController;
  late TextEditingController _videoUrlController;
  late TextEditingController _imageIdsController;
  
  // Grammar
  late TextEditingController _grammarTextController;
  late TextEditingController _grammarAudioUrlController;
  
  // Speaking
  late TextEditingController _speakingTextController;
  late TextEditingController _speakingAudioUrlController;
  late TextEditingController _speakingConversationUrlController;
  
  // Exercises
  late TextEditingController _exerciseIdsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.lesson?.title ?? '');
    _descController = TextEditingController(text: widget.lesson?.description ?? '');
    
    _contentTextController = TextEditingController(text: widget.lesson?.lessonContent.text ?? '');
    _videoUrlController = TextEditingController(text: widget.lesson?.lessonContent.videoUrl ?? '');
    _imageIdsController = TextEditingController(text: widget.lesson?.lessonContent.imageIds.join(', ') ?? '');
    
    _grammarTextController = TextEditingController(text: widget.lesson?.grammar.text ?? '');
    _grammarAudioUrlController = TextEditingController(text: widget.lesson?.grammar.audioUrl ?? '');
    
    _speakingTextController = TextEditingController(text: widget.lesson?.speaking.text ?? '');
    _speakingAudioUrlController = TextEditingController(text: widget.lesson?.speaking.audioUrl ?? '');
    _speakingConversationUrlController = TextEditingController(text: widget.lesson?.speaking.conversationUrl ?? '');
    
    _exerciseIdsController = TextEditingController(text: widget.lesson?.exerciseIds.join(', ') ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _contentTextController.dispose();
    _videoUrlController.dispose();
    _imageIdsController.dispose();
    _grammarTextController.dispose();
    _grammarAudioUrlController.dispose();
    _speakingTextController.dispose();
    _speakingAudioUrlController.dispose();
    _speakingConversationUrlController.dispose();
    _exerciseIdsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: AlertDialog(
        title: Text(widget.lesson == null ? 'Add New Lesson' : 'Edit Lesson'),
        content: SizedBox(
          width: 600,
          height: 500,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'General'),
                  Tab(text: 'Content'),
                  Tab(text: 'Gmr & Spk'),
                  Tab(text: 'Exercises'),
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
                      // Tab 1: General
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(labelText: 'Title *'),
                              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _descController,
                              decoration: const InputDecoration(labelText: 'Description'),
                              maxLines: 3,
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
                      // Tab 3: Grammar & Speaking
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            const _StarDivider('GRAMMAR'),
                            TextFormField(
                              controller: _grammarTextController,
                              decoration: const InputDecoration(labelText: 'Grammar Text'),
                              maxLines: 3,
                            ),
                            TextFormField(
                              controller: _grammarAudioUrlController,
                              decoration: const InputDecoration(labelText: 'Grammar Audio URL'),
                            ),
                            const _StarDivider('SPEAKING'),
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
                      // Tab 4: Exercises
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _exerciseIdsController,
                              decoration: const InputDecoration(
                                labelText: 'Exercise IDs',
                                hintText: 'ex123, ex456 (comma separated)',
                              ),
                              maxLines: 5,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Enter exercise identifiers that students need to complete for this lesson.',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
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
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
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
        grammar: LessonGrammar(
          text: _grammarTextController.text,
          audioUrl: _grammarAudioUrlController.text,
        ),
        speaking: LessonSpeaking(
          text: _speakingTextController.text,
          audioUrl: _speakingAudioUrlController.text,
          conversationUrl: _speakingConversationUrlController.text,
        ),
        exerciseIds: _exerciseIdsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
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
