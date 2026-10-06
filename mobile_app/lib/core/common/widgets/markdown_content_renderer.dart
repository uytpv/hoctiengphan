import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' hide PlayerState;
import 'package:flutter_tts/flutter_tts.dart';
import '../../services/lesson_audio_manager.dart';

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

class DialogueSyntax extends md.InlineSyntax {
  DialogueSyntax()
      : super(r'\[dialogue:([^\|\]]+)\|([^\|\]]+)\|([^\|\]]*)(?:\|([^\]]*))?\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final speaker = match.group(1)!.trim();
    final finnish = match.group(2)!.trim();
    final vietnamese = match.group(3)!.trim();
    final note = match.group(4)?.trim() ?? '';
    final element = md.Element.empty('dialogue');
    element.attributes['speaker'] = speaker;
    element.attributes['fi'] = finnish;
    element.attributes['vi'] = vietnamese;
    element.attributes['note'] = note;
    parser.addNode(element);
    return true;
  }
}

class ReaderSyntax extends md.InlineSyntax {
  ReaderSyntax() : super(r'\[reader:([^\|\]]+)\|([^\]]+)\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final finnish = match.group(1)!.trim();
    final vietnamese = match.group(2)!.trim();
    final element = md.Element.empty('reader');
    element.attributes['fi'] = finnish;
    element.attributes['vi'] = vietnamese;
    parser.addNode(element);
    return true;
  }
}

class DialogueToggleSyntax extends md.InlineSyntax {
  DialogueToggleSyntax() : super(r'\[dialogue_toggle(?::([^\]]+))?\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final title = match.group(1)?.trim() ?? 'Bản dịch song ngữ tiếng Việt';
    final element = md.Element.empty('dialoguetoggle');
    element.attributes['title'] = title;
    parser.addNode(element);
    return true;
  }
}

/// Bộ điều khiển trạng thái hiển thị bản dịch cho toàn bộ bài học
class DialogueStateController {
  static final ValueNotifier<bool> showAllTranslations = ValueNotifier<bool>(false);

  static void reset() {
    showAllTranslations.value = false;
  }
}

/// Trình render nội dung bài học bằng Markdown có hỗ trợ các shortcode tương tác.
class MarkdownContentRenderer extends StatelessWidget {
  final String content;
  final ScrollController? scrollController;
  final Function(String vocabId)? onVocabTapped;
  final Function(String audioUrl)? onAudioPlayed;
  final Function(String exerciseId, bool isCompleted)? onExerciseCompleted;

  const MarkdownContentRenderer({
    super.key,
    required this.content,
    this.scrollController,
    this.onVocabTapped,
    this.onAudioPlayed,
    this.onExerciseCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      selectable: true,
      shrinkWrap: true,
      extensionSet: md.ExtensionSet.gitHubFlavored,
      inlineSyntaxes: [
        VocabSyntax(),
        AudioSyntax(),
        ExerciseSyntax(),
        VideoSyntax(),
        GrammarSyntax(),
        DialogueSyntax(),
        ReaderSyntax(),
        DialogueToggleSyntax(),
      ],
      builders: {
        'vocab': VocabElementBuilder(onTap: (vocabId, text) {
          if (onVocabTapped != null) {
            onVocabTapped!(vocabId);
          } else {
            _showVocabBottomSheet(context, vocabId, text);
          }
        }),
        'audio': AudioElementBuilder(onPlay: onAudioPlayed),
        'exercise': ExerciseElementBuilder(onCompleted: onExerciseCompleted),
        'video': VideoElementBuilder(),
        'grammar': GrammarElementBuilder(onVocabTapped: onVocabTapped, onAudioPlayed: onAudioPlayed),
        'dialogue': DialogueElementBuilder(),
        'reader': ReaderElementBuilder(),
        'dialoguetoggle': DialogueToggleElementBuilder(),
      },
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(fontSize: 18, height: 1.6, color: Colors.black87),
        h1: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.5, color: Colors.blueAccent),
        h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.5, color: Colors.blueAccent),
        h3: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, height: 1.5, color: Colors.blueAccent),
        listBullet: const TextStyle(fontSize: 18),
        tableBorder: TableBorder.all(color: Colors.grey.shade300, width: 0.8),
        tableHead: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        tableBody: const TextStyle(fontSize: 16, color: Colors.black87),
        tableCellsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xFF757575),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _VocabAudioButton(audioUrl: audioUrl, text: finnish),
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

/// Nút phát âm thanh từ vựng (hỗ trợ phát MP3 ghi âm sẵn hoặc tự phát TTS Phần Lan native miễn phí)
class _VocabAudioButton extends StatefulWidget {
  final String? audioUrl;
  final String text;
  const _VocabAudioButton({this.audioUrl, required this.text});

  @override
  State<_VocabAudioButton> createState() => _VocabAudioButtonState();
}

class _VocabAudioButtonState extends State<_VocabAudioButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Đăng ký các sự kiện TTS
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
      // Nếu đang phát, bấm loa sẽ dừng lại
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
        // Ưu tiên 1: Phát file ghi âm của giáo viên
        setState(() => _isPlaying = true);
        await _audioPlayer.play(UrlSource(widget.audioUrl!));
        _audioPlayer.onPlayerComplete.first.then((_) {
          if (mounted) setState(() => _isPlaying = false);
        });
      } else {
        // Ưu tiên 2: Gọi Native Text-to-Speech đọc tiếng Phần Lan (fi-FI)
        await _flutterTts.setLanguage("fi-FI");
        await _flutterTts.setSpeechRate(0.45); // Tốc độ đọc chậm rãi, chuẩn học tập
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
      // Khi đang phát, icon chuyển thành Icons.stop để thể hiện trạng thái bấm vào để dừng
      icon: Icon(_isPlaying ? Icons.stop : Icons.volume_up_outlined),
      style: IconButton.styleFrom(
        backgroundColor: Colors.blueAccent.withValues(alpha: 0.1),
        foregroundColor: Colors.blueAccent,
      ),
    );
  }
}

/// Element Builder cho Từ vựng
class VocabElementBuilder extends MarkdownElementBuilder {
  final void Function(String id, String text) onTap;

  VocabElementBuilder({required this.onTap});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final vocabId = element.attributes['id'] ?? '';
    final text = element.textContent;

    return GestureDetector(
      onTap: () => onTap(vocabId, text),
      child: Text(
        text,
        style: preferredStyle?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent.shade700,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
          decorationColor: Colors.blueAccent,
        ) ?? TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent.shade700,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
          decorationColor: Colors.blueAccent,
        ),
      ),
    );
  }
}

/// Element Builder cho Audio
class AudioElementBuilder extends MarkdownElementBuilder {
  final Function(String url)? onPlay;

  AudioElementBuilder({this.onPlay});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final url = element.attributes['url'] ?? '';
    if (url.isEmpty) return const SizedBox.shrink();

    return _EmbeddedAudioPlayer(audioUrl: url, onPlay: onPlay);
  }
}

class _EmbeddedAudioPlayer extends StatefulWidget {
  final String audioUrl;
  final Function(String url)? onPlay;

  const _EmbeddedAudioPlayer({required this.audioUrl, this.onPlay});

  @override
  State<_EmbeddedAudioPlayer> createState() => _EmbeddedAudioPlayerState();
}

class _EmbeddedAudioPlayerState extends State<_EmbeddedAudioPlayer> {
  @override
  void initState() {
    super.initState();
    LessonAudioManager.instance.addListener(_onAudioUpdate);
  }

  @override
  void dispose() {
    LessonAudioManager.instance.removeListener(_onAudioUpdate);
    super.dispose();
  }

  void _onAudioUpdate() {
    if (mounted) setState(() {});
  }

  Future<void> _togglePlay() async {
    final manager = LessonAudioManager.instance;
    if (manager.currentUrl == widget.audioUrl) {
      await manager.togglePlay();
    } else {
      widget.onPlay?.call(widget.audioUrl);
      await manager.play(widget.audioUrl);
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final manager = LessonAudioManager.instance;
    final isThisTrack = manager.currentUrl == widget.audioUrl;
    final isPlaying = isThisTrack && manager.isPlaying;
    final position = isThisTrack ? manager.position : Duration.zero;
    final duration = isThisTrack ? manager.duration : Duration.zero;

    final maxMs = duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1.0;
    final currentMs = position.inMilliseconds.toDouble().clamp(0.0, maxMs);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPlaying ? const Color(0xFFEFF6FF) : Colors.blueAccent.withValues(alpha: 0.05),
        border: Border.all(
          color: isPlaying ? Colors.blueAccent : Colors.blueAccent.withValues(alpha: 0.15),
          width: isPlaying ? 1.5 : 1.0,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          IconButton.filled(
            onPressed: _togglePlay,
            icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 28),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF0056D2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isPlaying ? 'Đang phát âm thanh bài học...' : 'Nghe bài hội thoại / từ vựng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: isPlaying ? const Color(0xFF0056D2) : const Color(0xFF1E293B),
                      ),
                    ),
                    if (isThisTrack)
                      Text(
                        '${manager.speed}x',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0056D2),
                        ),
                      ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                    activeTrackColor: const Color(0xFF0056D2),
                    inactiveTrackColor: Colors.blueAccent.withValues(alpha: 0.2),
                    thumbColor: const Color(0xFF0056D2),
                  ),
                  child: Slider(
                    value: currentMs,
                    max: maxMs,
                    onChanged: (val) {
                      if (isThisTrack) {
                        manager.seek(Duration(milliseconds: val.toInt()));
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(position), style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    Text(_formatDuration(duration), style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Element Builder cho Video
class VideoElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final videoId = element.attributes['id'] ?? '';
    if (videoId.isEmpty) return const SizedBox.shrink();

    return _EmbeddedVideoPlayer(videoId: videoId);
  }
}

class _EmbeddedVideoPlayer extends StatefulWidget {
  final String videoId;
  const _EmbeddedVideoPlayer({required this.videoId});

  @override
  State<_EmbeddedVideoPlayer> createState() => _EmbeddedVideoPlayerState();
}

class _EmbeddedVideoPlayerState extends State<_EmbeddedVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}

/// Element Builder cho Bài tập (Exercise)
class ExerciseElementBuilder extends MarkdownElementBuilder {
  final Function(String id, bool isCompleted)? onCompleted;

  ExerciseElementBuilder({this.onCompleted});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final id = element.attributes['id'] ?? '';
    if (id.isEmpty) return const SizedBox.shrink();

    return _EmbeddedExerciseWidget(exerciseId: id, onCompleted: onCompleted);
  }
}

class _EmbeddedExerciseWidget extends StatefulWidget {
  final String exerciseId;
  final Function(String id, bool isCompleted)? onCompleted;

  const _EmbeddedExerciseWidget({required this.exerciseId, this.onCompleted});

  @override
  State<_EmbeddedExerciseWidget> createState() => _EmbeddedExerciseWidgetState();
}

class _EmbeddedExerciseWidgetState extends State<_EmbeddedExerciseWidget> {
  bool _isLoading = true;
  Map<String, dynamic>? _exerciseData;
  List<dynamic> _questions = [];
  List<dynamic> _rawQuestions = [];
  
  // Trạng thái trả lời
  int _currentIndex = 0;
  int? _selectedOption; // Cho MULTIPLE_CHOICE
  String _inputText = ''; // Cho FILL_IN_BLANK
  bool? _selectedTrueFalse; // Cho TRUE_FALSE
  
  bool _isSubmitted = false;
  bool _isCorrect = false;
  String _explanation = '';
  
  // Đếm số câu đúng
  int _correctAnswersCount = 0;
  bool _exerciseFinished = false;

  @override
  void initState() {
    super.initState();
    _loadExercise();
  }

  /// Chuẩn hóa câu hỏi và xáo trộn ngẫu nhiên thứ tự các lựa chọn trắc nghiệm
  /// để tránh tình trạng đáp án đúng luôn nằm ở vị trí đầu tiên (A).
  List<Map<String, dynamic>> _processAndShuffleQuestions(List rawQuestions) {
    final List<Map<String, dynamic>> normalizedQuestions = [];
    final random = Random();

    for (var q in rawQuestions) {
      if (q is String) {
        normalizedQuestions.add({
          'prompt': q,
          'type': 'FILL_IN_BLANK',
          'correctText': '',
          'explanation': '',
        });
      } else if (q is Map) {
        final qMap = Map<String, dynamic>.from(q);
        final type = qMap['type'] ?? 'MULTIPLE_CHOICE';

        if (type == 'MULTIPLE_CHOICE' && qMap['options'] is List) {
          final originalOptions = List<dynamic>.from(qMap['options'] as List);
          final dynamic rawCorrectIndex = qMap['correctIndex'];
          final int? correctIndex = rawCorrectIndex is int
              ? rawCorrectIndex
              : int.tryParse(rawCorrectIndex?.toString() ?? '');

          if (originalOptions.length > 1 &&
              correctIndex != null &&
              correctIndex >= 0 &&
              correctIndex < originalOptions.length) {
            // Ghép từng lựa chọn với index gốc trước khi shuffle
            final indexedEntries = originalOptions.asMap().entries.toList()..shuffle(random);
            final shuffledOptions = indexedEntries.map((e) => e.value).toList();
            final newCorrectIndex = indexedEntries.indexWhere((e) => e.key == correctIndex);

            qMap['options'] = shuffledOptions;
            qMap['correctIndex'] = newCorrectIndex;
          }
        }

        normalizedQuestions.add(qMap);
      }
    }
    return normalizedQuestions;
  }

  Future<void> _loadExercise() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('exercises').doc(widget.exerciseId).get();
      if (mounted) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          final rawQuestions = data['questions'] as List? ?? [];
          
          final normalizedQuestions = _processAndShuffleQuestions(rawQuestions);

          setState(() {
            _exerciseData = data;
            _rawQuestions = rawQuestions;
            _questions = normalizedQuestions;
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _submitAnswer() {
    if (_questions.isEmpty || _currentIndex >= _questions.length) return;
    
    final question = _questions[_currentIndex] as Map<String, dynamic>;
    final type = question['type'] ?? 'MULTIPLE_CHOICE';
    bool correct = false;

    if (type == 'MULTIPLE_CHOICE') {
      final correctIndex = question['correctIndex'];
      correct = _selectedOption == correctIndex;
    } else if (type == 'FILL_IN_BLANK') {
      final correctText = (question['correctText'] ?? '').toString().trim().toLowerCase();
      correct = _inputText.trim().toLowerCase() == correctText;
    } else if (type == 'TRUE_FALSE') {
      final correctIndex = question['correctIndex'] ?? 0;
      final ans = _selectedTrueFalse == true ? 0 : 1;
      correct = ans == correctIndex;
    }

    setState(() {
      _isSubmitted = true;
      _isCorrect = correct;
      _explanation = question['explanation'] ?? '';
      if (correct) {
        _correctAnswersCount++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _selectedOption = null;
        _inputText = '';
        _selectedTrueFalse = null;
        _isSubmitted = false;
        _isCorrect = false;
        _explanation = '';
      } else {
        _exerciseFinished = true;
        if (widget.onCompleted != null) {
          widget.onCompleted!(widget.exerciseId, true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (_exerciseData == null || _questions.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        color: Colors.red.withValues(alpha: 0.05),
        child: const Text('Không thể tải bài tập hoặc bài tập không có câu hỏi.'),
      );
    }

    if (_exerciseFinished) {
      final percent = ((_correctAnswersCount / _questions.length) * 100).toInt();
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.08),
          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 12),
            const Text(
              'Đã hoàn thành bài tập!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Kết quả: $_correctAnswersCount / ${_questions.length} câu đúng ($percent%)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _questions = _processAndShuffleQuestions(_rawQuestions);
                  _currentIndex = 0;
                  _selectedOption = null;
                  _inputText = '';
                  _selectedTrueFalse = null;
                  _isSubmitted = false;
                  _isCorrect = false;
                  _explanation = '';
                  _correctAnswersCount = 0;
                  _exerciseFinished = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Làm lại'),
            ),
          ],
        ),
      );
    }

    final question = _questions[_currentIndex] as Map<String, dynamic>;
    final prompt = question['prompt'] ?? '';
    final type = question['type'] ?? 'MULTIPLE_CHOICE';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Câu hỏi ${_currentIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.blueAccent
                  ),
                ),
              ),
              Text(
                type == 'MULTIPLE_CHOICE'
                    ? 'Trắc nghiệm'
                    : type == 'TRUE_FALSE'
                        ? 'Đúng / Sai'
                        : 'Điền từ',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            prompt,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, height: 1.4),
          ),
          const SizedBox(height: 16),
          
          if (type == 'MULTIPLE_CHOICE') _buildMultipleChoice(question),
          if (type == 'TRUE_FALSE') _buildTrueFalse(),
          if (type == 'FILL_IN_BLANK') _buildFillInBlank(),
          
          const SizedBox(height: 16),
          
          if (_isSubmitted) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isCorrect ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _isCorrect ? Colors.green.withValues(alpha: 0.3) : Colors.red.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _isCorrect ? Icons.check_circle : Icons.cancel,
                        color: _isCorrect ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isCorrect ? 'Chính xác!' : 'Chưa đúng',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  if (_explanation.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Giải thích: $_explanation',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: !_isSubmitted 
                  ? (_hasSelectedAnswer() ? _submitAnswer : null)
                  : _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: !_isSubmitted ? Colors.blueAccent : Colors.grey.shade800,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(!_isSubmitted ? 'Nộp bài' : 'Tiếp theo'),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasSelectedAnswer() {
    final question = _questions[_currentIndex] as Map<String, dynamic>;
    final type = question['type'] ?? 'MULTIPLE_CHOICE';
    if (type == 'MULTIPLE_CHOICE') return _selectedOption != null;
    if (type == 'TRUE_FALSE') return _selectedTrueFalse != null;
    if (type == 'FILL_IN_BLANK') return _inputText.trim().isNotEmpty;
    return false;
  }

  Widget _buildMultipleChoice(Map<String, dynamic> question) {
    final options = question['options'] is List ? (question['options'] as List) : [];
    return Column(
      children: List.generate(options.length, (index) {
        final option = options[index];
        final isSelected = _selectedOption == index;
        
        Color itemColor = Colors.white;
        Color borderColor = Colors.grey.shade300;
        
        if (isSelected && !_isSubmitted) {
          itemColor = Colors.blueAccent.withValues(alpha: 0.05);
          borderColor = Colors.blueAccent;
        } else if (_isSubmitted) {
          final correctIndex = question['correctIndex'];
          if (index == correctIndex) {
            itemColor = Colors.green.withValues(alpha: 0.1);
            borderColor = Colors.green;
          } else if (isSelected && !_isCorrect) {
            itemColor = Colors.red.withValues(alpha: 0.1);
            borderColor = Colors.red;
          }
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: itemColor,
            border: Border.all(color: borderColor, width: isSelected || _isSubmitted ? 1.5 : 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            onTap: _isSubmitted ? null : () => setState(() => _selectedOption = index),
            leading: CircleAvatar(
              radius: 12,
              backgroundColor: isSelected ? Colors.blueAccent : Colors.grey[200],
              child: Text(
                String.fromCharCode(65 + index), 
                style: TextStyle(
                  fontSize: 11, 
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black87
                ),
              ),
            ),
            title: Text(option.toString()),
          ),
        );
      }),
    );
  }

  Widget _buildTrueFalse() {
    return Row(
      children: [
        Expanded(
          child: _buildTrueFalseButton(true, 'Đúng', Icons.check),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTrueFalseButton(false, 'Sai', Icons.close),
        ),
      ],
    );
  }

  Widget _buildTrueFalseButton(bool value, String label, IconData icon) {
    final isSelected = _selectedTrueFalse == value;
    Color buttonColor = Colors.white;
    Color borderColor = Colors.grey.shade300;

    if (isSelected && !_isSubmitted) {
      buttonColor = Colors.blueAccent.withValues(alpha: 0.05);
      borderColor = Colors.blueAccent;
    } else if (_isSubmitted) {
      final question = _questions[_currentIndex] as Map<String, dynamic>;
      final correctIndex = question['correctIndex'] ?? 0;
      final isCorrectAns = (correctIndex == 0 && value) || (correctIndex == 1 && !value);
      
      if (isCorrectAns) {
        buttonColor = Colors.green.withValues(alpha: 0.1);
        borderColor = Colors.green;
      } else if (isSelected && !_isCorrect) {
        buttonColor = Colors.red.withValues(alpha: 0.1);
        borderColor = Colors.red;
      }
    }

    return InkWell(
      onTap: _isSubmitted ? null : () => setState(() => _selectedTrueFalse = value),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: borderColor, width: isSelected || _isSubmitted ? 1.5 : 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? Colors.blueAccent 
                  : _isSubmitted && ((_questions[_currentIndex]['correctIndex'] ?? 0) == (value ? 0 : 1))
                      ? Colors.green 
                      : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFillInBlank() {
    return TextFormField(
      enabled: !_isSubmitted,
      decoration: const InputDecoration(
        hintText: 'Nhập câu trả lời của bạn...',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onChanged: (val) => setState(() => _inputText = val),
    );
  }
}

class GrammarElementBuilder extends MarkdownElementBuilder {
  final Function(String vocabId)? onVocabTapped;
  final Function(String audioUrl)? onAudioPlayed;

  GrammarElementBuilder({this.onVocabTapped, this.onAudioPlayed});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final id = element.attributes['id'] ?? '';
    if (id.isEmpty) return const SizedBox.shrink();

    return _EmbeddedGrammarWidget(
      grammarId: id,
      onVocabTapped: onVocabTapped,
      onAudioPlayed: onAudioPlayed,
    );
  }
}

class _EmbeddedGrammarWidget extends StatefulWidget {
  final String grammarId;
  final Function(String vocabId)? onVocabTapped;
  final Function(String audioUrl)? onAudioPlayed;

  const _EmbeddedGrammarWidget({
    required this.grammarId,
    this.onVocabTapped,
    this.onAudioPlayed,
  });

  @override
  State<_EmbeddedGrammarWidget> createState() => _EmbeddedGrammarWidgetState();
}

class _EmbeddedGrammarWidgetState extends State<_EmbeddedGrammarWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = true;
  Map<String, dynamic>? _grammarData;

  @override
  void initState() {
    super.initState();
    _loadGrammar();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadGrammar() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('grammars').doc(widget.grammarId).get();
      if (mounted) {
        if (doc.exists) {
          setState(() {
            _grammarData = doc.data();
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleAudio(String url) async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      if (widget.onAudioPlayed != null) {
        widget.onAudioPlayed!(url);
      }
      setState(() => _isPlaying = true);
      await _audioPlayer.play(UrlSource(url));
      _audioPlayer.onPlayerComplete.first.then((_) {
        if (mounted) setState(() => _isPlaying = false);
      });
    }
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
                      _VocabAudioButton(audioUrl: audioUrl, text: finnish),
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (_grammarData == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple.withValues(alpha: 0.05),
          border: Border.all(color: Colors.purple.withValues(alpha: 0.15)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.school, color: Colors.purple),
            const SizedBox(width: 8),
            Text(
              'Không tìm thấy chủ đề ngữ pháp nhúng (ID: ${widget.grammarId})',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
          ],
        ),
      );
    }

    final title = _grammarData!['title'] ?? 'Ngữ pháp';
    final content = _grammarData!['content'] ?? '';
    final audioUrl = _grammarData!['audioUrl'] as String?;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.02),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.15), width: 1.5),
        borderRadius: BorderRadius.circular(16),
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
                    const Icon(Icons.school, color: Colors.purple, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.purple,
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
                    backgroundColor: Colors.purple.withValues(alpha: 0.1),
                    foregroundColor: Colors.purple,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
          const Divider(height: 24, color: Colors.purple),
          
          MarkdownBody(
            data: content,
            selectable: true,
            extensionSet: md.ExtensionSet.gitHubFlavored,
            inlineSyntaxes: [
              VocabSyntax(),
              AudioSyntax(),
              DialogueSyntax(),
              ReaderSyntax(),
              DialogueToggleSyntax(),
            ],
            builders: {
              'vocab': VocabElementBuilder(onTap: (vocabId, text) {
                if (widget.onVocabTapped != null) {
                  widget.onVocabTapped!(vocabId);
                } else {
                  _showVocabBottomSheet(context, vocabId, text);
                }
              }),
              'audio': AudioElementBuilder(onPlay: widget.onAudioPlayed),
              'dialogue': DialogueElementBuilder(),
              'reader': ReaderElementBuilder(),
              'dialoguetoggle': DialogueToggleElementBuilder(),
            },
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF0F1114)),
              h1: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
              h2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
              h3: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
              tableBorder: TableBorder.all(color: Colors.purple.withValues(alpha: 0.15), width: 1),
              tableHead: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F1114)),
              tableBody: const TextStyle(fontSize: 15, color: Color(0xFF0F1114)),
              tableCellsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

/// Element Builder cho Hội thoại tương tác từng câu
class DialogueElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final speaker = element.attributes['speaker'] ?? '';
    final fi = element.attributes['fi'] ?? '';
    final vi = element.attributes['vi'] ?? '';
    final note = element.attributes['note'] ?? '';
    return _InteractiveDialogueCard(
      speaker: speaker,
      fi: fi,
      vi: vi,
      note: note,
    );
  }
}

/// Element Builder cho Đoạn văn đọc hiểu tương tác từng câu
class ReaderElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final fi = element.attributes['fi'] ?? '';
    final vi = element.attributes['vi'] ?? '';
    return _InteractiveReaderCard(
      fi: fi,
      vi: vi,
    );
  }
}

/// Element Builder cho Thanh điều khiển bật/tắt toàn bộ bản dịch
class DialogueToggleElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final title = element.attributes['title'] ?? 'Bản dịch song ngữ tiếng Việt';
    return _DialogueToggleWidget(title: title);
  }
}

/// Widget thanh bật/tắt toàn bộ bản dịch tiếng Việt
class _DialogueToggleWidget extends StatefulWidget {
  final String title;
  const _DialogueToggleWidget({required this.title});

  @override
  State<_DialogueToggleWidget> createState() => _DialogueToggleWidgetState();
}

class _DialogueToggleWidgetState extends State<_DialogueToggleWidget> {
  @override
  void initState() {
    super.initState();
    DialogueStateController.showAllTranslations.addListener(_update);
  }

  @override
  void dispose() {
    DialogueStateController.showAllTranslations.removeListener(_update);
    super.dispose();
  }

  void _update() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final showAll = DialogueStateController.showAllTranslations.value;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.translate, size: 18, color: Colors.blueAccent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  showAll ? 'Đang hiện toàn bộ bản dịch tiếng Việt' : 'Chạm từng câu để xem dịch, hoặc bật công tắc',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: showAll,
            activeTrackColor: Colors.blueAccent,
            onChanged: (val) {
              DialogueStateController.showAllTranslations.value = val;
            },
          ),
        ],
      ),
    );
  }
}

/// Nút đọc âm thanh TTS native cho câu tiếng Phần Lan
class _SentenceTtsButton extends StatefulWidget {
  final String text;
  const _SentenceTtsButton({required this.text});

  @override
  State<_SentenceTtsButton> createState() => _SentenceTtsButtonState();
}

class _SentenceTtsButtonState extends State<_SentenceTtsButton> {
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
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak() async {
    if (_isPlaying) {
      await _flutterTts.stop();
      if (mounted) setState(() => _isPlaying = false);
      return;
    }
    try {
      await _flutterTts.setLanguage("fi-FI");
      await _flutterTts.setSpeechRate(0.42);
      if (mounted) setState(() => _isPlaying = true);
      await _flutterTts.speak(widget.text);
    } catch (_) {
      if (mounted) setState(() => _isPlaying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _speak,
      tooltip: 'Nghe phát âm chuẩn (fi-FI)',
      icon: Icon(
        _isPlaying ? Icons.stop_circle : Icons.volume_up_outlined,
        size: 18,
        color: _isPlaying ? Colors.redAccent : const Color(0xFF0056D2),
      ),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 26, minHeight: 26),
    );
  }
}

/// Thẻ hội thoại tương tác theo từng câu thoại chuẩn giáo trình
class _InteractiveDialogueCard extends StatefulWidget {
  final String speaker;
  final String fi;
  final String vi;
  final String note;

  const _InteractiveDialogueCard({
    required this.speaker,
    required this.fi,
    required this.vi,
    this.note = '',
  });

  @override
  State<_InteractiveDialogueCard> createState() => _InteractiveDialogueCardState();
}

class _InteractiveDialogueCardState extends State<_InteractiveDialogueCard> {
  bool? _localOverride;

  @override
  void initState() {
    super.initState();
    DialogueStateController.showAllTranslations.addListener(_onGlobalChange);
  }

  @override
  void dispose() {
    DialogueStateController.showAllTranslations.removeListener(_onGlobalChange);
    super.dispose();
  }

  void _onGlobalChange() {
    if (mounted) {
      setState(() {
        _localOverride = null;
      });
    }
  }

  bool get _isVisible =>
      _localOverride ?? DialogueStateController.showAllTranslations.value;

  Color _getSpeakerColor(String speaker) {
    final s = speaker.trim().toLowerCase();
    if (s.contains('alex')) return const Color(0xFF2563EB); // Royal Blue
    if (s.contains('pedro')) return const Color(0xFF0D9488); // Teal
    if (s.contains('olga')) return const Color(0xFF9333EA); // Purple
    if (s.contains('hanna')) return const Color(0xFFE11D48); // Rose
    if (s.contains('päivi') || s.contains('paivi') || s.contains('opettaja')) return const Color(0xFFD97706); // Amber
    if (s.contains('mikko')) return const Color(0xFF4F46E5); // Indigo
    if (s.contains('kyllikki')) return const Color(0xFF0891B2); // Cyan
    if (s.contains('jari')) return const Color(0xFFEA580C); // Orange
    if (s.contains('janita')) return const Color(0xFFDB2777); // Pink
    if (s.contains('myyjä') || s.contains('myyja') || s.contains('virkailija')) return const Color(0xFF059669); // Emerald
    return const Color(0xFF475569); // Slate
  }

  @override
  Widget build(BuildContext context) {
    final color = _getSpeakerColor(widget.speaker);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      decoration: BoxDecoration(
        color: _isVisible ? color.withValues(alpha: 0.04) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(
            color: _isVisible ? color.withValues(alpha: 0.15) : const Color(0xFFF1F5F9),
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _localOverride = !_isVisible;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên người nói dạng badge inline nhỏ gọn
                    Container(
                      margin: const EdgeInsets.only(top: 1, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.speaker,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    // Câu tiếng Phần Lan nguyên văn
                    Expanded(
                      child: Text(
                        widget.fi,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.38,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Icon dịch gọn gàng
                    IconButton(
                      icon: Icon(
                        Icons.g_translate_rounded,
                        size: 17,
                        color: _isVisible ? color : const Color(0xFF94A3B8),
                      ),
                      tooltip: _isVisible ? 'Ẩn bản dịch' : 'Xem bản dịch',
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 26, minHeight: 26),
                      onPressed: () {
                        setState(() {
                          _localOverride = !_isVisible;
                        });
                      },
                    ),
                  ],
                ),
                // Bản dịch hiển thị ngay dưới câu khi mở
                if (_isVisible) ...[
                  Container(
                    margin: const EdgeInsets.only(top: 4, left: 4, bottom: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border(
                        left: BorderSide(color: color, width: 2.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.vi,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF334155),
                            height: 1.35,
                          ),
                        ),
                        if (widget.note.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            '💡 ${widget.note}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF92400E),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Thẻ đọc hiểu tương tác từng câu (không kèm tên nhân vật)
class _InteractiveReaderCard extends StatefulWidget {
  final String fi;
  final String vi;
  const _InteractiveReaderCard({required this.fi, required this.vi});

  @override
  State<_InteractiveReaderCard> createState() => _InteractiveReaderCardState();
}

class _InteractiveReaderCardState extends State<_InteractiveReaderCard> {
  bool? _localOverride;

  @override
  void initState() {
    super.initState();
    DialogueStateController.showAllTranslations.addListener(_onGlobalChange);
  }

  @override
  void dispose() {
    DialogueStateController.showAllTranslations.removeListener(_onGlobalChange);
    super.dispose();
  }

  void _onGlobalChange() {
    if (mounted) {
      setState(() {
        _localOverride = null;
      });
    }
  }

  bool get _isVisible =>
      _localOverride ?? DialogueStateController.showAllTranslations.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      decoration: BoxDecoration(
        color: _isVisible ? const Color(0xFFF8FAFC) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _localOverride = !_isVisible;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.fi,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.38,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: Icon(
                        Icons.g_translate_rounded,
                        size: 17,
                        color: _isVisible ? const Color(0xFF0056D2) : const Color(0xFF94A3B8),
                      ),
                      tooltip: _isVisible ? 'Ẩn bản dịch' : 'Xem bản dịch',
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 26, minHeight: 26),
                      onPressed: () {
                        setState(() {
                          _localOverride = !_isVisible;
                        });
                      },
                    ),
                  ],
                ),
                if (_isVisible) ...[
                  Container(
                    margin: const EdgeInsets.only(top: 4, left: 4, bottom: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                      border: const Border(
                        left: BorderSide(color: Color(0xFF0056D2), width: 2.5),
                      ),
                    ),
                    child: Text(
                      widget.vi,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF334155),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
