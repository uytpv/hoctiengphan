import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/lesson.dart';
import '../../data/lesson_repository.dart';

class LessonFormDialog extends ConsumerStatefulWidget {
  final Lesson? lesson;

  const LessonFormDialog({super.key, this.lesson});

  @override
  ConsumerState<LessonFormDialog> createState() => _LessonFormDialogState();
}

class _LessonFormDialogState extends ConsumerState<LessonFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _chapterController;
  late TextEditingController _displayController;
  late TextEditingController _descriptionController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.lesson?.title ?? '');
    _chapterController = TextEditingController(
      text: widget.lesson?.chapter ?? '',
    );
    _displayController = TextEditingController(
      text: widget.lesson?.fullDisplay ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.lesson?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _chapterController.dispose();
    _displayController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final lesson = Lesson(
        id: widget.lesson?.id ?? '',
        title: _titleController.text.trim(),
        chapter: _chapterController.text.trim(),
        fullDisplay: _displayController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      if (widget.lesson == null) {
        await ref.read(lessonRepositoryProvider).createLesson(lesson);
      } else {
        await ref.read(lessonRepositoryProvider).updateLesson(lesson);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving lesson: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.lesson == null ? 'Add Lesson' : 'Edit Lesson'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title *',
                    hintText: 'Example: Tervetuloa Suomeen!',
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _chapterController,
                  decoration: const InputDecoration(
                    labelText: 'Chapter *',
                    hintText: 'Example: Kappale 1',
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _displayController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name *',
                    hintText: 'Example: 1 - Tervetuloa Suomeen!',
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey.shade800,
            foregroundColor: Colors.white,
          ),
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
