import 'dart:convert';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Renders Quill Delta JSON content stored by the admin tool.
///
/// Supports:
///   - Plain text inserts (with bold/italic/underline attributes)
///   - Inline images  {"insert": {"image": "url"}}
///   - Newlines as paragraph breaks
///
/// Usage:
///   QuillContentRenderer(deltaJson: lesson['lessonContent']['text'])
class QuillContentRenderer extends StatelessWidget {
  const QuillContentRenderer({
    super.key,
    required this.deltaJson,
    this.textStyle,
  });

  /// Raw value from Firestore – may be:
  ///   • A JSON string  "[{\"insert\":\"...\"}]"
  ///   • A plain string  "Just some text"
  ///   • null / empty
  final dynamic deltaJson;
  final TextStyle? textStyle;

  // ── Delta parsing ─────────────────────────────────────
  static List<_Op> _parse(dynamic raw) {
    if (raw == null) return [];

    String src = raw is String ? raw : raw.toString();
    src = src.trim();

    // Try to detect Quill Delta JSON (starts with '[')
    if (src.startsWith('[')) {
      try {
        final list = jsonDecode(src) as List<dynamic>;
        return list.map(_Op.fromJson).whereType<_Op>().toList();
      } catch (_) {
        // Fall through to plain text
      }
    }

    // Plain text – wrap in a single insert op
    return [_Op.text(src)];
  }

  // ── Build ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final ops = _parse(deltaJson);
    if (ops.isEmpty) {
      return const SizedBox.shrink();
    }

    final baseStyle =
        textStyle ?? AppTextStyles.bodyLg.copyWith(height: 1.8);

    // Group consecutive text ops into RichText spans, flush on image ops
    final widgets = <Widget>[];
    final textBuffer = <TextSpan>[];

    void flushText() {
      if (textBuffer.isEmpty) return;
      widgets.add(
        SelectableText.rich(
          TextSpan(
            style: baseStyle,
            children: List.of(textBuffer),
          ),
        ),
      );
      textBuffer.clear();
    }

    for (final op in ops) {
      if (op.isImage) {
        flushText();
        widgets.add(_ImageBlock(url: op.imageUrl!));
        widgets.add(const SizedBox(height: 12));
      } else {
        // Split text by newlines to preserve paragraph breaks
        final parts = op.text!.split('\n');
        for (var i = 0; i < parts.length; i++) {
          final part = parts[i];
          if (part.isNotEmpty) {
            textBuffer.add(TextSpan(
              text: part,
              style: _attrStyle(baseStyle, op.attrs),
            ));
          }
          // Newline between parts → flush paragraph
          if (i < parts.length - 1) {
            if (textBuffer.isNotEmpty) {
              flushText();
              widgets.add(const SizedBox(height: 6));
            } else if (widgets.isNotEmpty) {
              // Empty line → extra spacing
              widgets.add(const SizedBox(height: 4));
            }
          }
        }
      }
    }
    flushText();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  // ── Attribute → TextStyle ─────────────────────────────
  static TextStyle _attrStyle(
      TextStyle base, Map<String, dynamic>? attrs) {
    if (attrs == null || attrs.isEmpty) return base;
    var s = base;
    if (attrs['bold'] == true) s = s.copyWith(fontWeight: FontWeight.bold);
    if (attrs['italic'] == true) s = s.copyWith(fontStyle: FontStyle.italic);
    if (attrs['underline'] == true) {
      s = s.copyWith(decoration: TextDecoration.underline);
    }
    if (attrs['color'] != null) {
      final hex = attrs['color'] as String?;
      if (hex != null) {
        final c = _hexColor(hex);
        if (c != null) s = s.copyWith(color: c);
      }
    }
    return s;
  }

  static Color? _hexColor(String hex) {
    try {
      final h = hex.replaceAll('#', '');
      return Color(int.parse('FF$h', radix: 16));
    } catch (_) {
      return null;
    }
  }
}

// ─────────────────────────────────────────────────────────
// Delta Op model
// ─────────────────────────────────────────────────────────
class _Op {
  const _Op._({this.text, this.imageUrl, this.attrs});

  final String? text;
  final String? imageUrl;
  final Map<String, dynamic>? attrs;

  bool get isImage => imageUrl != null;

  factory _Op.text(String t, [Map<String, dynamic>? attrs]) =>
      _Op._(text: t, attrs: attrs);

  factory _Op.image(String url) => _Op._(imageUrl: url);

  static _Op? fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return null;
    final insert = json['insert'];
    final attrs =
        (json['attributes'] as Map<String, dynamic>?) ?? {};

    if (insert is String) {
      return _Op.text(insert, attrs.isEmpty ? null : attrs);
    } else if (insert is Map<String, dynamic>) {
      final imgUrl = insert['image'] as String?;
      if (imgUrl != null) return _Op.image(imgUrl);
    }
    return null;
  }
}

// ─────────────────────────────────────────────────────────
// Image block widget with error/loading states
// ─────────────────────────────────────────────────────────
class _ImageBlock extends StatelessWidget {
  const _ImageBlock({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.borderLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image_outlined,
                  color: AppColors.neutral, size: 24),
              SizedBox(width: 8),
              Text('Không tải được ảnh',
                  style: TextStyle(color: AppColors.neutral)),
            ],
          ),
        ),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return Container(
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
              color: AppColors.primary,
            ),
          );
        },
      ),
    );
  }
}
