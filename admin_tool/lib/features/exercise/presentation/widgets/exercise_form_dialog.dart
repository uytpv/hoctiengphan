import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/exercise.dart';
import '../../data/exercise_repository.dart';

class ExerciseFormDialog extends ConsumerStatefulWidget {
  final Exercise? exercise;

  const ExerciseFormDialog({super.key, this.exercise});

  @override
  ConsumerState<ExerciseFormDialog> createState() => _ExerciseFormDialogState();
}

class _ExerciseFormDialogState extends ConsumerState<ExerciseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _typeController;
  late TextEditingController _readingTextController;
  late TextEditingController _contentController;
  late List<Map<String, dynamic>> _questions;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.exercise?.title ?? '');
    _descriptionController = TextEditingController(text: widget.exercise?.description ?? '');
    _typeController = TextEditingController(text: widget.exercise?.type ?? 'multiple-choice');
    _readingTextController = TextEditingController(text: widget.exercise?.readingText ?? '');
    _contentController = TextEditingController(text: widget.exercise?.content ?? '');
    _questions = widget.exercise?.questions != null 
      ? List<Map<String, dynamic>>.from(widget.exercise!.questions.map((e) => Map<String, dynamic>.from(e)))
      : [];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _readingTextController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.exercise == null ? 'Add Exercise' : 'Edit Exercise'),
      content: SizedBox(
        width: 600,
        height: 600,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title *', border: OutlineInputBorder()),
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: ['multiple-choice', 'fill-in-blanks', 'true-false'].contains(_typeController.text) 
                    ? _typeController.text 
                    : 'multiple-choice',
                  decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'multiple-choice', child: Text('Multiple Choice')),
                    DropdownMenuItem(value: 'fill-in-blanks', child: Text('Fill in Blanks')),
                    DropdownMenuItem(value: 'true-false', child: Text('True or False')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _typeController.text = v);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _readingTextController,
                  decoration: const InputDecoration(labelText: 'Reading Text (Optional)', border: OutlineInputBorder()),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Instructions / Extra Info', border: OutlineInputBorder()),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      onPressed: _addQuestion,
                      icon: const Icon(Icons.add),
                      label: const Text('ADD QUESTION'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ..._buildQuestionEditors(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }

  List<Widget> _buildQuestionEditors() {
    return _questions.asMap().entries.map((entry) {
      final index = entry.key;
      
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () => setState(() => _questions.removeAt(index)),
                  ),
                ],
              ),
              if (_typeController.text == 'fill-in-blanks') ...[
                _buildField(index, 'textBefore', 'Text Before Blank (e.g. "Minä ")'),
                _buildField(index, 'textAfter', 'Text After Blank (e.g. " opiskelija.")'),
              ] else ...[
                _buildField(index, 'text', 'Question Text'),
              ],
              _buildField(index, 'correctAnswer', 'Correct Answer'),
              if (_typeController.text == 'multiple-choice') ...[
                _buildOptionsField(index),
              ],
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildField(int index, String key, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        initialValue: _questions[index][key]?.toString() ?? '',
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        onChanged: (v) => _questions[index][key] = v,
      ),
    );
  }

  Widget _buildOptionsField(int index) {
    final options = (_questions[index]['options'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    final controller = TextEditingController(text: options.join(', '));
    
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Options (comma separated)', 
          border: OutlineInputBorder(),
          helperText: 'e.g. Choice A, Choice B, Choice C'
        ),
        onChanged: (v) {
          _questions[index]['options'] = v.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
        },
      ),
    );
  }

  void _addQuestion() {
    setState(() {
      final newQ = <String, dynamic>{'id': DateTime.now().millisecondsSinceEpoch.toString()};
      if (_typeController.text == 'fill-in-blanks') {
        newQ['textBefore'] = '';
        newQ['textAfter'] = '';
      } else {
        newQ['text'] = '';
      }
      newQ['correctAnswer'] = '';
      if (_typeController.text == 'multiple-choice') {
        newQ['options'] = <String>[];
      }
      if (_typeController.text == 'true-false') {
        newQ['options'] = ['Oikein', 'Väärin'];
      }
      _questions.add(newQ);
    });
  }

  void _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      final exercise = Exercise(
        id: widget.exercise?.id ?? '',
        title: _titleController.text,
        description: _descriptionController.text,
        type: _typeController.text,
        readingText: _readingTextController.text.isNotEmpty ? _readingTextController.text : null,
        content: _contentController.text,
        questions: _questions,
      );

      final repository = ref.read(exerciseRepositoryProvider);
      try {
        if (widget.exercise == null) {
          await repository.createExercise(exercise);
        } else {
          await repository.updateExercise(exercise);
        }
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }
}
