import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

/// Các class InlineSyntax để parse shortcodes tùy chỉnh trong Markdown
class VocabSyntax extends md.InlineSyntax {
  VocabSyntax() : super(r'\[vocab:([^\|\]]+)\|([^\]]+)\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final vocabId = match.group(1)!;
    final text = match.group(2)!;
    final element = md.Element('vocab', [md.Text(text)]);
    element.attributes['id'] = vocabId;
    parser.addNode(element);
    return true;
  }
}

class AudioSyntax extends md.InlineSyntax {
  AudioSyntax() : super(r'\[audio:([^\]]+)\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final url = match.group(1)!;
    final element = md.Element.empty('audio');
    element.attributes['url'] = url;
    parser.addNode(element);
    return true;
  }
}

class ExerciseSyntax extends md.InlineSyntax {
  ExerciseSyntax() : super(r'\[exercise:([^\]]+)\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final id = match.group(1)!;
    final element = md.Element.empty('exercise');
    element.attributes['id'] = id;
    parser.addNode(element);
    return true;
  }
}

class VideoSyntax extends md.InlineSyntax {
  VideoSyntax() : super(r'\[video:([^\]]+)\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final id = match.group(1)!;
    final element = md.Element.empty('video');
    element.attributes['id'] = id;
    parser.addNode(element);
    return true;
  }
}

class GrammarSyntax extends md.InlineSyntax {
  GrammarSyntax() : super(r'\[grammar:([^\]]+)\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final id = match.group(1)!;
    final element = md.Element.empty('grammar');
    element.attributes['id'] = id;
    parser.addNode(element);
    return true;
  }
}

/// Widget Render Preview nội dung bài học kiểu Markdown có các shortcodes cho Admin Tool.
class MarkdownPreview extends StatelessWidget {
  final String content;

  const MarkdownPreview({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return const Center(
        child: Text(
          'Nội dung xem trước sẽ hiển thị ở đây...',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }

    return MarkdownBody(
      data: content,
      selectable: false,
      extensionSet: md.ExtensionSet.gitHubFlavored,
      inlineSyntaxes: [
        VocabSyntax(),
        AudioSyntax(),
        ExerciseSyntax(),
        VideoSyntax(),
        GrammarSyntax(),
      ],
      builders: {
        'vocab': AdminVocabElementBuilder(context),
        'audio': AdminAudioElementBuilder(),
        'exercise': AdminExerciseElementBuilder(),
        'video': AdminVideoElementBuilder(),
        'grammar': AdminGrammarElementBuilder(),
      },
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
        h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.4, color: Colors.blueAccent),
        h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4, color: Colors.blueAccent),
        h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.4, color: Colors.blueAccent),
        listBullet: const TextStyle(fontSize: 16),
        tableBorder: TableBorder.all(color: Colors.grey.shade300, width: 0.8),
        tableHead: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
        tableBody: const TextStyle(fontSize: 15, color: Colors.black87),
        tableCellsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}

class AdminVocabElementBuilder extends MarkdownElementBuilder {
  final BuildContext context;
  AdminVocabElementBuilder(this.context);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final vocabId = element.attributes['id'] ?? '';
    final text = element.textContent;

    return GestureDetector(
      onTap: () => _showVocabBottomSheet(context, vocabId, text),
      child: Text(
        text,
        style: preferredStyle?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
          decorationColor: Colors.blueAccent,
        ) ?? const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
          decorationColor: Colors.blueAccent,
        ),
      ),
    );
  }

  void _showVocabBottomSheet(BuildContext context, String vocabId, String originalText) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('vocabularies').doc(vocabId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      originalText,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text('Không tìm thấy thông tin chi tiết của từ vựng này.'),
                  ],
                ),
              );
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final finnish = data['finnish'] ?? originalText;
            final vietnamese = data['vietnamese'] ?? '';
            final english = data['english'] ?? '';
            final pronunciation = data['pronunciation'] ?? '';
            final audioUrl = data['audioUrl'] ?? '';

            return Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              finnish,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            if (pronunciation.isNotEmpty)
                              Text(
                                '/$pronunciation/',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF757575),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _AdminVocabAudioButton(audioUrl: audioUrl, text: finnish),
                    ],
                  ),
                  const Divider(height: 24),
                  const Text(
                    'Nghĩa tiếng Việt:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vietnamese,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  if (english.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text(
                      'Tiếng Anh:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      english,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

/// Nút phát âm thanh từ vựng cho Admin Tool (Web) hỗ trợ phát MP3 hoặc Native TTS (fi-FI)
class _AdminVocabAudioButton extends StatefulWidget {
  final String? audioUrl;
  final String text;
  const _AdminVocabAudioButton({this.audioUrl, required this.text});

  @override
  State<_AdminVocabAudioButton> createState() => _AdminVocabAudioButtonState();
}

class _AdminVocabAudioButtonState extends State<_AdminVocabAudioButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _flutterTts.setStartHandler(() {
      if (mounted) setState(() => _isPlaying = true);
    });
    _flutterTts.setCompletionHandler(() {
      if (mounted) setState(() => _isPlaying = false);
    });
    _flutterTts.setErrorHandler((msg) {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _play() async {
    if (_isPlaying) {
      try {
        if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
          await _audioPlayer.stop();
        } else {
          await _flutterTts.stop();
        }
        setState(() => _isPlaying = false);
      } catch (_) {}
      return;
    }

    try {
      if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
        setState(() => _isPlaying = true);
        await _audioPlayer.play(UrlSource(widget.audioUrl!));
        _audioPlayer.onPlayerComplete.first.then((_) {
          if (mounted) setState(() => _isPlaying = false);
        });
      } else {
        await _flutterTts.setLanguage("fi-FI");
        await _flutterTts.setSpeechRate(0.45);
        await _flutterTts.speak(widget.text);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isPlaying = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi âm thanh: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: _play,
      icon: Icon(_isPlaying ? Icons.stop : Icons.volume_up_outlined),
      style: IconButton.styleFrom(
        backgroundColor: Colors.blueAccent.withOpacity(0.1),
        foregroundColor: Colors.blueAccent,
      ),
    );
  }
}

class AdminAudioElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final url = element.attributes['url'] ?? '';
    final fileName = url.split('/').last.split('?').first;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.05),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.volume_up, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'File nghe nhúng: $fileName',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueAccent),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminVideoElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final id = element.attributes['id'] ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.05),
        border: Border.all(color: Colors.redAccent.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.play_circle_filled, color: Colors.redAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Video YouTube (ID: $id)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.redAccent),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminExerciseElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final id = element.attributes['id'] ?? '';

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('exercises').doc(id).get(),
      builder: (context, snapshot) {
        String title = 'Bài tập nhúng ($id)';
        int questionsCount = 0;

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          title = data['title'] ?? data['titleFi'] ?? 'Bài tập: ${data['instructionFi'] ?? id}';
          final questions = data['questions'] as List?;
          questionsCount = questions?.length ?? 0;
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.05),
            border: Border.all(color: Colors.green.withOpacity(0.15)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.quiz, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.green),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (questionsCount > 0)
                      Text(
                        'Số câu hỏi: $questionsCount câu',
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AdminGrammarElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final id = element.attributes['id'] ?? '';
    if (id.isEmpty) return const SizedBox.shrink();

    return _AdminEmbeddedGrammar(grammarId: id);
  }
}

class _AdminEmbeddedGrammar extends StatefulWidget {
  final String grammarId;
  const _AdminEmbeddedGrammar({required this.grammarId});

  @override
  State<_AdminEmbeddedGrammar> createState() => _AdminEmbeddedGrammarState();
}

class _AdminEmbeddedGrammarState extends State<_AdminEmbeddedGrammar> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio(String url) async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      setState(() => _isPlaying = true);
      await _audioPlayer.play(UrlSource(url));
      _audioPlayer.onPlayerComplete.first.then((_) {
        if (mounted) setState(() => _isPlaying = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('grammars').doc(widget.grammarId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.05),
              border: Border.all(color: Colors.purple.withOpacity(0.15)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.bookmark, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'Không tìm thấy ngữ pháp nhúng (ID: ${widget.grammarId})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.purple),
                ),
              ],
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final title = data['title'] ?? 'Ngữ pháp';
        final content = data['content'] ?? '';
        final audioUrl = data['audioUrl'] as String?;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.01),
            border: Border.all(color: Colors.purple.withOpacity(0.15), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.history_edu, color: Colors.purple),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 15, 
                              color: Colors.purple
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (audioUrl != null && audioUrl.isNotEmpty)
                    IconButton.filledTonal(
                      onPressed: () => _toggleAudio(audioUrl),
                      icon: Icon(_isPlaying ? Icons.stop : Icons.volume_up),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.purple.withOpacity(0.08),
                        foregroundColor: Colors.purple,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                ],
              ),
              const Divider(height: 20, color: Colors.purple),
              
              MarkdownBody(
                data: content,
                extensionSet: md.ExtensionSet.gitHubFlavored,
                inlineSyntaxes: [
                  VocabSyntax(),
                  AudioSyntax(),
                ],
                builders: {
                  'vocab': AdminVocabElementBuilder(context),
                  'audio': AdminAudioElementBuilder(),
                },
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
                  h1: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                  h2: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.purple),
                  h3: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.purple),
                  tableBorder: TableBorder.all(color: Colors.grey.shade300, width: 0.8),
                  tableHead: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                  tableBody: const TextStyle(fontSize: 14, color: Colors.black87),
                  tableCellsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
