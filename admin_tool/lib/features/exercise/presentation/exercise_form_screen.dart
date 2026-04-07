import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import '../domain/exercise.dart';
import '../data/exercise_repository.dart';
import 'widgets/exercise_preview_widget.dart';

class ExerciseFormScreen extends ConsumerStatefulWidget {
  final String? exerciseId; // Null implies creating a new exercise

  const ExerciseFormScreen({super.key, this.exerciseId});

  @override
  ConsumerState<ExerciseFormScreen> createState() => _ExerciseFormScreenState();
}

class _ExerciseFormScreenState extends ConsumerState<ExerciseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _typeController;
  late TextEditingController _readingTextController;
  late TextEditingController _contentController;
  List<Map<String, dynamic>> _questions = [];

  bool _isUploading = false;
  bool _isLoading = false;
  Exercise? _exercise;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _typeController = TextEditingController(text: 'multiple-choice');
    _readingTextController = TextEditingController();
    _contentController = TextEditingController();

    if (widget.exerciseId != null) {
      _loadExercise();
    }
  }

  Future<void> _loadExercise() async {
    setState(() => _isLoading = true);
    try {
      final repository = ref.read(exerciseRepositoryProvider);
      final exercise = await repository.getExercise(widget.exerciseId!);
      if (mounted) {
        setState(() {
          _exercise = exercise;
          _titleController.text = exercise.title;
          _descriptionController.text = exercise.description;
          _typeController.text = exercise.type;
          _readingTextController.text = exercise.readingText ?? '';
          _contentController.text = exercise.content;
          _questions = List<Map<String, dynamic>>.from(
            exercise.questions.map((e) => Map<String, dynamic>.from(e)),
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading exercise: $e')));
      }
    }
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

  void _forceUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exerciseId == null ? 'Add Exercise' : 'Edit Exercise',
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                children: [
                  // Editor Side
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Form(
                        key: _formKey,
                        onChanged: _forceUpdate,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title *',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (v) =>
                                    v?.isEmpty ?? true ? 'Required' : null,
                                onChanged: (_) => _forceUpdate(),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 2,
                                onChanged: (_) => _forceUpdate(),
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String>(
                                value:
                                    [
                                      'multiple-choice',
                                      'fill-in-blanks',
                                      'true-false',
                                      'translation',
                                    ].contains(_typeController.text)
                                    ? _typeController.text
                                    : 'multiple-choice',
                                decoration: const InputDecoration(
                                  labelText: 'Type',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'multiple-choice',
                                    child: Text('Multiple Choice (Quiz)'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'fill-in-blanks',
                                    child: Text('Fill in Blanks'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'true-false',
                                    child: Text('True or False'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'translation',
                                    child: Text('Translation / 2 Columns'),
                                  ),
                                ],
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() {
                                      _typeController.text = v;
                                      _forceUpdate();
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _readingTextController,
                                decoration: const InputDecoration(
                                  labelText: 'Reading Text (Optional)',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 5,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _contentController,
                                decoration: const InputDecoration(
                                  labelText: 'Instructions / Extra Info',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                                onChanged: (_) => _forceUpdate(),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Questions',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: _addQuestion,
                                    icon: const Icon(Icons.add),
                                    label: const Text('ADD'),
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
                  ),
                  if (isDesktop)
                    const SizedBox(width: 24)
                  else
                    const SizedBox(height: 16),

                  // Preview Side
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Live Preview',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 450,
                                  ), // Mobile width sim
                                  child: ExercisePreviewWidget(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    type: _typeController.text,
                                    content: _contentController.text,
                                    questions: _questions,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isUploading ? null : _save,
                  child: _isUploading
                      ? const CircularProgressIndicator()
                      : const Text('Save Exercise'),
                ),
              ],
            ),
          ],
        ),
      ),
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
                  Text(
                    'Question ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () {
                      setState(() => _questions.removeAt(index));
                    },
                  ),
                ],
              ),

              if (_typeController.text == 'fill-in-blanks') ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Use [[answer]] to add blank fields. Example: Minä [[olen]] oppilas.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],

              _buildField(
                index,
                'text',
                _typeController.text == 'translation'
                    ? 'Word (Left Column)'
                    : 'Question Text',
                maxLines: 3,
              ),

              if (_typeController.text == 'translation') ...[
                _buildField(
                  index,
                  'correctAnswer',
                  'Translation (Right Column)',
                  maxLines: 1,
                ),
              ],

              if (_typeController.text == 'multiple-choice' ||
                  _typeController.text == 'true-false') ...[
                _buildOptionsField(index),
                _buildCorrectAnswersField(index),
              ],

              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8),
                child: Text(
                  'Media (Optional)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Expanded(child: _buildField(index, 'imageUrl', 'Image URL')),
                  IconButton(
                    icon: const Icon(Icons.upload_file),
                    tooltip: 'Upload Image',
                    onPressed: () =>
                        _uploadFile(index, 'imageUrl', fp.FileType.image),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildField(index, 'audioUrl', 'Audio URL')),
                  IconButton(
                    icon: const Icon(Icons.upload_file),
                    tooltip: 'Upload Audio',
                    onPressed: () =>
                        _uploadFile(index, 'audioUrl', fp.FileType.audio),
                  ),
                ],
              ),
              _buildField(
                index,
                'videoUrl',
                'Video ID / Embed URL (e.g. Youtube URL)',
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildField(int index, String key, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        initialValue: _questions[index][key]?.toString() ?? '',
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
        onChanged: (v) {
          _questions[index][key] = v;
        },
      ),
    );
  }

  Widget _buildOptionsField(int index) {
    final options =
        (_questions[index]['options'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final controller = TextEditingController(text: options.join(', '));

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Options (comma separated)',
          border: OutlineInputBorder(),
          helperText: 'e.g. Cat, Dog, Bird',
        ),
        onChanged: (v) {
          _questions[index]['options'] = v
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
        },
      ),
    );
  }

  Widget _buildCorrectAnswersField(int index) {
    final correctAnswers =
        (_questions[index]['correctAnswers'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    // Migrate old correctAnswer to array for easier editing if missing
    if (correctAnswers.isEmpty &&
        _questions[index]['correctAnswer'] != null &&
        _questions[index]['correctAnswer'].toString().isNotEmpty) {
      correctAnswers.add(_questions[index]['correctAnswer'].toString());
      _questions[index]['correctAnswers'] = correctAnswers;
    }

    final controller = TextEditingController(text: correctAnswers.join(', '));

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Correct Answer(s) (comma separated)',
          border: OutlineInputBorder(),
          helperText: 'e.g. Cat, Dog (checkboxes) OR just Cat (radio)',
        ),
        onChanged: (v) {
          _questions[index]['correctAnswers'] = v
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
        },
      ),
    );
  }

  void _addQuestion() {
    setState(() {
      final newQ = <String, dynamic>{'id': const Uuid().v4()};
      newQ['text'] = '';
      if (_typeController.text == 'multiple-choice') {
        newQ['options'] = <String>[];
        newQ['correctAnswers'] = <String>[];
      }
      if (_typeController.text == 'true-false') {
        newQ['options'] = ['Oikein', 'Väärin'];
        newQ['correctAnswers'] = <String>[];
      }
      _questions.add(newQ);
    });
  }

  Future<void> _uploadFile(int index, String key, fp.FileType type) async {
    try {
      fp.FilePickerResult? result = await fp.FilePicker.pickFiles(
        type: type,
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        setState(() => _isUploading = true);

        final fileBytes = result.files.single.bytes!;
        final fileName = result.files.single.name;
        final extension = fileName.split('.').last;
        final storagePath = 'exercises/media/${const Uuid().v4()}.$extension';

        final ref = FirebaseStorage.instance.ref(storagePath);
        final uploadTask = await ref.putData(
          fileBytes,
          SettableMetadata(
            contentType: type == fp.FileType.image
                ? 'image/$extension'
                : 'audio/$extension',
          ),
        );
        final url = await uploadTask.ref.getDownloadURL();

        setState(() {
          _questions[index][key] = url;
          _isUploading = false;
        });
      }
    } catch (e) {
      setState(() => _isUploading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    }
  }

  void _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedExercise = Exercise(
        id: _exercise?.id ?? widget.exerciseId ?? const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        type: _typeController.text,
        readingText: _readingTextController.text.isNotEmpty
            ? _readingTextController.text
            : null,
        content: _contentController.text,
        questions: _questions,
      );

      final repository = ref.read(exerciseRepositoryProvider);
      try {
        setState(() => _isUploading = true);
        if (_exercise == null && widget.exerciseId == null) {
          await repository.createExercise(updatedExercise);
        } else {
          await repository.updateExercise(updatedExercise);
        }
        if (mounted) {
          context.pop();
        }
      } catch (e) {
        setState(() => _isUploading = false);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }
}
