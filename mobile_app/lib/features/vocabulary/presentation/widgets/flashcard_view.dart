import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/vocabulary.dart';

class FlashcardView extends StatefulWidget {
  final Vocabulary vocabulary;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;

  const FlashcardView({
    super.key,
    required this.vocabulary,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutCubic),
    );

    _flutterTts.setStartHandler(() {
      if (mounted) setState(() => _isPlaying = true);
    });
    _flutterTts.setCompletionHandler(() {
      if (mounted) setState(() => _isPlaying = false);
    });
    _flutterTts.setErrorHandler((_) {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  void didUpdateWidget(covariant FlashcardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.vocabulary.id != widget.vocabulary.id) {
      _animController.reset();
      _stopAudio();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      await _flutterTts.stop();
      if (mounted) setState(() => _isPlaying = false);
    } catch (_) {}
  }

  Future<void> _playAudio(String text, {String? url}) async {
    if (_isPlaying) {
      await _stopAudio();
      return;
    }

    try {
      if (url != null && url.isNotEmpty) {
        setState(() => _isPlaying = true);
        await _audioPlayer.play(UrlSource(url));
        _audioPlayer.onPlayerComplete.first.then((_) {
          if (mounted) setState(() => _isPlaying = false);
        });
      } else {
        setState(() => _isPlaying = true);
        await _flutterTts.setLanguage("fi-FI");
        await _flutterTts.setSpeechRate(0.85);
        await _flutterTts.speak(text);
      }
    } catch (_) {
      if (mounted) setState(() => _isPlaying = false);
    }
  }

  void _flipCard() {
    if (_animController.isCompleted) {
      _animController.reverse();
    } else {
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isUnder = (angle > pi / 2);

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isUnder
                ? Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: _buildBackCard(),
                  )
                : _buildFrontCard(),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    final vocab = widget.vocabulary;
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 340),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header row: Category tag + Audio button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (vocab.category != null && vocab.category!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    vocab.category!,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              IconButton.filledTonal(
                icon: Icon(
                  _isPlaying ? Icons.stop_rounded : Icons.volume_up_rounded,
                  color: AppColors.primary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
                onPressed: () => _playAudio(vocab.finnish, url: vocab.audioUrl),
                tooltip: 'Kuuntele • Nghe phát âm',
              ),
            ],
          ),

          // Central word & pronunciation
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vocab.finnish,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingXl.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.surfaceDark,
                  ),
                ),
                if (vocab.pronunciation != null && vocab.pronunciation!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    '/${vocab.pronunciation}/',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.neutral,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Hint at bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.flip_rounded, size: 16, color: AppColors.neutral),
              const SizedBox(width: 6),
              Text(
                'Kosketa kääntääksesi • Nhấn để lật thẻ',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.neutral,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    final vocab = widget.vocabulary;
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 340),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFDFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header row: Meaning indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.done.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded,
                        size: 14, color: AppColors.done),
                    const SizedBox(width: 4),
                    Text(
                      'Merkitys • Ý nghĩa',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.done,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                icon: Icon(
                  _isPlaying ? Icons.stop_rounded : Icons.volume_up_rounded,
                  color: AppColors.primary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
                onPressed: () => _playAudio(vocab.finnish, url: vocab.audioUrl),
              ),
            ],
          ),

          // Central meanings
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text(
                  vocab.vietnamese,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingLg.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
                if (vocab.english.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    vocab.english,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.neutral,
                    ),
                  ),
                ],
                if (vocab.example != null && vocab.example!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                vocab.example!,
                                style: AppTextStyles.bodyMd.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.surfaceDark,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _playAudio(vocab.example!),
                              borderRadius: BorderRadius.circular(16),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.volume_down_rounded,
                                    size: 20, color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                        if (vocab.exampleTranslation != null &&
                            vocab.exampleTranslation!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            vocab.exampleTranslation!,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.neutral,
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

          // Hint at bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.refresh_rounded, size: 16, color: AppColors.neutral),
              const SizedBox(width: 6),
              Text(
                'Kosketa kääntääksesi takaisin • Chạm để quay lại',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.neutral,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
