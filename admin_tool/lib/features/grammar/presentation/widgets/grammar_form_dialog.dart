import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../../domain/grammar.dart';
import '../../data/grammar_repository.dart';
import 'package:admin_tool/features/lesson/presentation/widgets/markdown_preview.dart';

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
  late TextEditingController _contentController;
  late TextEditingController _audioUrlController;
  bool _uploadingAudio = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.grammar?.title ?? '');
    _slugController = TextEditingController(text: widget.grammar?.slug ?? '');
    
    // Xử lý dữ liệu cũ từ Quill Delta (nếu có) sang văn bản thường / Markdown
    String initialContent = widget.grammar?.content ?? '';
    try {
      final decoded = jsonDecode(initialContent);
      if (decoded is Map || decoded is List) {
        // Delta JSON
        final ops = decoded['ops'] as List?;
        if (ops != null) {
          final sb = StringBuffer();
          for (final op in ops) {
            if (op is Map && op.containsKey('insert')) {
              sb.write(op['insert']);
            }
          }
          initialContent = sb.toString();
        }
      }
    } catch (_) {
      // Đã là plain text / Markdown sẵn
    }
    
    _contentController = TextEditingController(text: initialContent);
    _audioUrlController = TextEditingController(text: widget.grammar?.audioUrl ?? '');

    // Đăng ký listener để tự động cập nhật Live Preview khi gõ
    _contentController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _contentController.dispose();
    _audioUrlController.dispose();
    super.dispose();
  }

  Future<void> _uploadAudio() async {
    final result = await FilePicker.pickFiles(
      type: FileType.audio,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    setState(() {
      _uploadingAudio = true;
    });

    try {
      final file = result.files.first;
      final fileName = '${const Uuid().v4()}_${file.name}';
      final ref = FirebaseStorage.instance.ref().child('audios/grammars/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(file.bytes!);
      } else {
        throw Exception('Chỉ hỗ trợ upload trực tiếp từ Admin Tool Web');
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _audioUrlController.text = downloadUrl;
        _uploadingAudio = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tải lên file phát âm thành công!')),
        );
      }
    } catch (e) {
      setState(() {
        _uploadingAudio = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi upload file: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.grammar == null ? 'Thêm Ngữ pháp' : 'Sửa Ngữ pháp'),
      content: SizedBox(
        width: 1000,
        height: 650,
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cột trái: Nhập thông tin & Soạn thảo Markdown
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Tiêu đề ngữ pháp *',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (v) => v?.isEmpty ?? true ? 'Vui lòng nhập tiêu đề' : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _slugController,
                                decoration: const InputDecoration(
                                  labelText: 'Kappale / Chương (Ví dụ: Kappale 1)',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // File Audio phát âm
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _audioUrlController,
                                decoration: const InputDecoration(
                                  labelText: 'URL file phát âm bài Ngữ pháp (Tùy chọn)',
                                  border: OutlineInputBorder(),
                                  hintText: 'https://...',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 54,
                              child: ElevatedButton.icon(
                                onPressed: _uploadingAudio ? null : _uploadAudio,
                                icon: _uploadingAudio
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                      )
                                    : const Icon(Icons.upload_file),
                                label: Text(_uploadingAudio ? 'Đang tải...' : 'Tải lên MP3'),
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
                        const SizedBox(height: 16),
                        
                        // Text Area nhập Markdown
                        TextFormField(
                          controller: _contentController,
                          maxLines: 18,
                          decoration: const InputDecoration(
                            labelText: 'Nội dung ngữ pháp (Markdown) *',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                            hintText: 'Soạn thảo bằng Markdown. Có thể viết các bảng chia từ. Ví dụ:\n| Ngôi | Tiếng Phần Lan | Nghĩa |\n|---|---|---|\n| minä | olen | tôi là |',
                          ),
                          validator: (v) => v?.isEmpty ?? true ? 'Vui lòng nhập nội dung' : null,
                          style: const TextStyle(fontFamily: 'Courier', fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Thanh chia dọc
              const VerticalDivider(width: 1, thickness: 1),
              
              // Cột phải: Live Preview
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.visibility, size: 18, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'Xem trước thời gian thực (Live Preview)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFF9FAFB),
                          ),
                          child: SingleChildScrollView(
                            child: MarkdownPreview(content: _contentController.text),
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent.shade700,
            foregroundColor: Colors.white,
          ),
          child: const Text('Lưu'),
        ),
      ],
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final grammar = Grammar(
        id: widget.grammar?.id ?? '',
        title: _titleController.text,
        slug: _slugController.text.trim().isEmpty ? null : _slugController.text.trim(),
        content: _contentController.text,
        audioUrl: _audioUrlController.text.trim().isEmpty ? null : _audioUrlController.text.trim(),
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
        }
      }
    }
  }
}
