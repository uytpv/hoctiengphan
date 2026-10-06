import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/immersion_resource.dart';
import '../../data/immersion_repository.dart';

class ImmersionFormDialog extends ConsumerStatefulWidget {
  final ImmersionResource? initialResource;

  const ImmersionFormDialog({super.key, this.initialResource});

  @override
  ConsumerState<ImmersionFormDialog> createState() => _ImmersionFormDialogState();
}

class _ImmersionFormDialogState extends ConsumerState<ImmersionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late ImmersionType _selectedType;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _mediaUrlController;
  late final TextEditingController _thumbnailUrlController;
  late final TextEditingController _originalContentController;
  late final TextEditingController _vietnameseTranslationController;
  late final TextEditingController _vocabNotesController;
  late final TextEditingController _tagsController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final r = widget.initialResource;
    _selectedType = r?.type ?? ImmersionType.music;
    _titleController = TextEditingController(text: r?.title ?? '');
    _descriptionController = TextEditingController(text: r?.description ?? '');
    _mediaUrlController = TextEditingController(text: r?.mediaUrl ?? '');
    _thumbnailUrlController = TextEditingController(text: r?.thumbnailUrl ?? '');
    _originalContentController = TextEditingController(text: r?.originalContent ?? '');
    _vietnameseTranslationController = TextEditingController(text: r?.vietnameseTranslation ?? '');
    _vocabNotesController = TextEditingController(text: r?.vocabularyNotes.join(', ') ?? '');
    _tagsController = TextEditingController(text: r?.tags.join(', ') ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _mediaUrlController.dispose();
    _thumbnailUrlController.dispose();
    _originalContentController.dispose();
    _vietnameseTranslationController.dispose();
    _vocabNotesController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final repo = ref.read(immersionRepositoryProvider);
      final vocabNotes = _vocabNotesController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      final tags = _tagsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final resource = ImmersionResource(
        id: widget.initialResource?.id ?? '',
        type: _selectedType,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        mediaUrl: _mediaUrlController.text.trim().isEmpty ? null : _mediaUrlController.text.trim(),
        thumbnailUrl: _thumbnailUrlController.text.trim().isEmpty ? null : _thumbnailUrlController.text.trim(),
        originalContent: _originalContentController.text.trim().isEmpty ? null : _originalContentController.text.trim(),
        vietnameseTranslation: _vietnameseTranslationController.text.trim().isEmpty ? null : _vietnameseTranslationController.text.trim(),
        vocabularyNotes: vocabNotes,
        tags: tags,
      );

      if (widget.initialResource != null) {
        await repo.updateImmersionResource(resource);
      } else {
        await repo.createImmersionResource(resource);
      }

      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi lưu tài nguyên: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialResource != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 750),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEdit ? 'Chỉnh Sửa Tài Nguyên Đời Sống' : 'Thêm Tài Nguyên Đời Sống Mới',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        DropdownButtonFormField<ImmersionType>(
                          initialValue: _selectedType,
                          decoration: const InputDecoration(
                            labelText: 'Loại tài nguyên *',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                          items: const [
                            DropdownMenuItem(value: ImmersionType.music, child: Text('🎵 Âm nhạc (Bài hát Phần Lan)')),
                            DropdownMenuItem(value: ImmersionType.movie, child: Text('🎬 Phim ảnh / Video clip ngắn')),
                            DropdownMenuItem(value: ImmersionType.streetSign, child: Text('🚏 Biển báo / Chỉ dẫn đường phố')),
                            DropdownMenuItem(value: ImmersionType.practicalLife, child: Text('🛒 Đời sống thực tế (Siêu thị, Thông báo...)')),
                          ],
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedType = val);
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Tiêu đề tài nguyên *',
                            hintText: 'VD: Kuumaa - Tulipalo hoặc Biển chỉ dẫn ga tàu Helsinki',
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty ? 'Vui lòng nhập tiêu đề' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Mô tả / Ngữ cảnh văn hóa',
                            hintText: 'Giải thích ngắn gọn ý nghĩa hoặc bối cảnh đời sống thực tế',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _mediaUrlController,
                                decoration: InputDecoration(
                                  labelText: _selectedType == ImmersionType.streetSign ? 'URL Hình ảnh biển báo' : 'URL Âm thanh / Video (Youtube/Storage)',
                                  hintText: 'https://...',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.link),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _thumbnailUrlController,
                                decoration: const InputDecoration(
                                  labelText: 'URL Ảnh bìa / Thumbnail (tùy chọn)',
                                  hintText: 'https://...',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.image),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _originalContentController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            labelText: _selectedType == ImmersionType.music ? 'Lời bài hát gốc (Tiếng Phần)' : 'Văn bản gốc / Transcript (Tiếng Phần Lan)',
                            hintText: 'Dán toàn bộ lời bài hát hoặc chữ trên biển báo tại đây...',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _vietnameseTranslationController,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            labelText: 'Bản dịch nghĩa Tiếng Việt (Đối chiếu từng dòng)',
                            hintText: 'Bản dịch nghĩa chi tiết giúp người học hiểu tường tận...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _vocabNotesController,
                          decoration: const InputDecoration(
                            labelText: 'Từ vựng quan trọng cần chú ý (phân cách bằng dấu phẩy)',
                            hintText: 'VD: tulipalo, sammuttaa, varoitus',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.spellcheck),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _tagsController,
                          decoration: const InputDecoration(
                            labelText: 'Thẻ phân loại / Tags (phân cách bằng dấu phẩy)',
                            hintText: 'VD: A1.1, pop, giao thông, kappale 1',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.label_outline),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Hủy'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _handleSave,
                      icon: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.save),
                      label: Text(isEdit ? 'CẬP NHẬT' : 'LƯU TÀI NGUYÊN'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
