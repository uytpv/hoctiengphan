import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/vocabulary.dart';
import '../../../lesson/domain/lesson.dart';
import '../../providers/vocabulary_provider.dart';
import '../../repositories/vocabulary_repository.dart';

class VocabularyFormDialog extends ConsumerStatefulWidget {
  final Vocabulary? vocabulary;

  const VocabularyFormDialog({super.key, this.vocabulary});

  @override
  ConsumerState<VocabularyFormDialog> createState() =>
      _VocabularyFormDialogState();
}

class _VocabularyFormDialogState extends ConsumerState<VocabularyFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _finnishController;
  late TextEditingController _vietnameseController;
  late TextEditingController _englishController;
  late TextEditingController _pronunciationController;
  late TextEditingController _audioUrlController;
  late TextEditingController _imageUrlController;
  late TextEditingController _exampleController;
  late TextEditingController _exampleTranslationController;
  late TextEditingController _categoryController;

  String? _selectedLessonId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final v = widget.vocabulary;
    _finnishController = TextEditingController(text: v?.finnish ?? '');
    _vietnameseController = TextEditingController(text: v?.vietnamese ?? '');
    _englishController = TextEditingController(text: v?.english ?? '');
    _pronunciationController = TextEditingController(
      text: v?.pronunciation ?? '',
    );
    _audioUrlController = TextEditingController(text: v?.audioUrl ?? '');
    _imageUrlController = TextEditingController(text: v?.imageUrl ?? '');
    _exampleController = TextEditingController(text: v?.example ?? '');
    _exampleTranslationController = TextEditingController(
      text: v?.exampleTranslation ?? '',
    );
    _categoryController = TextEditingController(text: v?.category ?? '');

    _selectedLessonId = v?.lessonId;
  }

  @override
  void dispose() {
    _finnishController.dispose();
    _vietnameseController.dispose();
    _englishController.dispose();
    _pronunciationController.dispose();
    _audioUrlController.dispose();
    _imageUrlController.dispose();
    _exampleController.dispose();
    _exampleTranslationController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final repository = ref.read(vocabularyRepositoryProvider);
      final newVoc = Vocabulary(
        id: widget.vocabulary?.id ?? '',
        finnish: _finnishController.text.trim(),
        vietnamese: _vietnameseController.text.trim(),
        english: _englishController.text.trim(),
        pronunciation: _pronunciationController.text.trim(),
        lessonId: _selectedLessonId,
        category: _categoryController.text.trim(),
        audioUrl: _audioUrlController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        example: _exampleController.text.trim(),
        exampleTranslation: _exampleTranslationController.text.trim(),
      );

      if (widget.vocabulary == null) {
        await repository.addVocabulary(newVoc);
      } else {
        await repository.updateVocabulary(newVoc);
      }

      ref.invalidate(vocabularyListProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessons = ref.watch(lessonsProvider).value ?? [];

    return AlertDialog(
      title: Text(
        widget.vocabulary == null ? 'Add New Vocabulary' : 'Edit Vocabulary',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _finnishController,
                  decoration: const InputDecoration(
                    labelText: 'Finnish*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? 'Finnish is required' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _vietnameseController,
                        decoration: const InputDecoration(
                          labelText: 'Vietnamese*',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'Vietnamese is required' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _englishController,
                        decoration: const InputDecoration(
                          labelText: 'English*',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'English is required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pronunciationController,
                  decoration: const InputDecoration(
                    labelText: 'Phiên âm',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedLessonId,
                        decoration: const InputDecoration(
                          labelText: 'Lesson',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('No Lesson'),
                          ),
                          ...lessons.map(
                            (l) => DropdownMenuItem(
                              value: l.id,
                              child: Text(l.title),
                            ),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => _selectedLessonId = val),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _categoryController,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.image),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _audioUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Audio URL',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.volume_up),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _exampleController,
                  decoration: const InputDecoration(
                    labelText: 'Example Sentence',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _exampleTranslationController,
                  decoration: const InputDecoration(
                    labelText: 'Example Translation',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
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
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Save Vocabulary'),
        ),
      ],
    );
  }
}
