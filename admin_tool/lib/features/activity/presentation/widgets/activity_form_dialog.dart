import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/activity/domain/activity.dart';
import 'package:admin_tool/features/activity/data/activity_repository.dart';
import 'package:admin_tool/features/lesson/data/lesson_repository.dart';
import 'package:admin_tool/features/exercise/data/exercise_repository.dart';

class ActivityFormDialog extends ConsumerStatefulWidget {
  final Activity? activity;

  const ActivityFormDialog({super.key, this.activity});

  @override
  ConsumerState<ActivityFormDialog> createState() => _ActivityFormDialogState();
}

class _ActivityFormDialogState extends ConsumerState<ActivityFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _mediaUrlController;
  late TextEditingController _linkUrlController;
  late ActivityType _type;
  String? _selectedLessonId;
  String? _selectedExerciseId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.activity?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.activity?.description ?? '',
    );
    _mediaUrlController = TextEditingController(
      text: widget.activity?.mediaUrl ?? '',
    );
    _linkUrlController = TextEditingController(
      text: widget.activity?.linkUrl ?? '',
    );
    _type = widget.activity?.type ?? ActivityType.lesson;
    _selectedLessonId = widget.activity?.lessonId;
    _selectedExerciseId = widget.activity?.exerciseId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _mediaUrlController.dispose();
    _linkUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessonsAsync = ref.watch(lessonsStreamProvider);
    final exercisesAsync = ref.watch(exercisesStreamProvider);

    return AlertDialog(
      title: Text(widget.activity == null ? 'Add Activity' : 'Edit Activity'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ActivityType>(
                value: _type,
                decoration: const InputDecoration(
                  labelText: 'Activity Type',
                  border: OutlineInputBorder(),
                ),
                items: ActivityType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _type = val);
                },
              ),
              const SizedBox(height: 16),
              if (_type == ActivityType.lesson)
                lessonsAsync.when(
                  data: (items) => DropdownButtonFormField<String>(
                    value: _selectedLessonId,
                    decoration: const InputDecoration(
                      labelText: 'Target Lesson',
                      border: OutlineInputBorder(),
                    ),
                    items: items
                        .map(
                          (i) => DropdownMenuItem(
                            value: i.id,
                            child: Text(i.title),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _selectedLessonId = val),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (e, s) => Text('Error loading lessons: $e'),
                ),
              if (_type == ActivityType.exercise)
                exercisesAsync.when(
                  data: (items) => DropdownButtonFormField<String>(
                    value: _selectedExerciseId,
                    decoration: const InputDecoration(
                      labelText: 'Target Exercise',
                      border: OutlineInputBorder(),
                    ),
                    items: items
                        .map(
                          (i) => DropdownMenuItem(
                            value: i.id,
                            child: Text(i.title),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _selectedExerciseId = val),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (e, s) => Text('Error loading exercises: $e'),
                ),
              if (_type == ActivityType.music ||
                  _type == ActivityType.movie) ...[
                TextFormField(
                  controller: _mediaUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Media URL / Link',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description / Instructions',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }

  void _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      final activity = Activity(
        id: widget.activity?.id ?? '',
        title: _titleController.text,
        description: _descriptionController.text,
        type: _type,
        lessonId: _type == ActivityType.lesson ? _selectedLessonId : null,
        exerciseId: _type == ActivityType.exercise ? _selectedExerciseId : null,
        mediaUrl: _mediaUrlController.text.isNotEmpty
            ? _mediaUrlController.text
            : null,
        createdAt: DateTime.now(),
      );

      final repository = ref.read(activityRepositoryProvider);
      try {
        if (widget.activity == null) {
          await repository.createActivity(activity);
        } else {
          await repository.updateActivity(activity);
        }
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted)
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
