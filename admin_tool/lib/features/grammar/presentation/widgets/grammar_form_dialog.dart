import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/grammar.dart';
import '../../data/grammar_repository.dart';

class GrammarFormDialog extends ConsumerStatefulWidget {
  final Grammar? grammar;

  const GrammarFormDialog({super.key, this.grammar});

  @override
  ConsumerState<GrammarFormDialog> createState() => _GrammarFormDialogState();
}

class _GrammarFormDialogState extends ConsumerState<GrammarFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _slugController;
  late QuillController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.grammar?.title ?? '');
    _slugController = TextEditingController(text: widget.grammar?.slug ?? '');
    _contentController = _loadDelta(widget.grammar?.content ?? '');
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
      return QuillController.basic();
    }
  }

  String _saveDelta() {
    return jsonEncode(_contentController.document.toDelta().toJson());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.grammar == null ? 'Add Grammar' : 'Edit Grammar'),
      content: SizedBox(
        width: 800,
        height: 600,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title *', border: OutlineInputBorder()),
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _slugController,
                      decoration: const InputDecoration(labelText: 'Slug', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              QuillSimpleToolbar(
                controller: _contentController,
                config: const QuillSimpleToolbarConfig(),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: QuillEditor.basic(
                    controller: _contentController,
                    config: const QuillEditorConfig(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final grammar = Grammar(
        id: widget.grammar?.id ?? '',
        title: _titleController.text,
        slug: _slugController.text,
        content: _saveDelta(),
      );

      final repository = ref.read(grammarRepositoryProvider);
      try {
        if (widget.grammar == null) {
          await repository.createGrammar(grammar);
        } else {
          await repository.updateGrammar(grammar);
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
