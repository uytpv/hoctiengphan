import 'package:flutter/material.dart';
import '../../services/lesson_audio_manager.dart';

/// Thanh điều khiển âm thanh cố định gọn gàng 1 dòng (Single-line Sticky Audio Bar).
/// Chiều cao tối ưu chỉ ~48px, gồm đầy đủ:
/// [Play/Pause] [Thời gian] [Thanh trượt Slider] [Tốc độ 1x] [Nút X đóng]
class StickyLessonAudioBar extends StatelessWidget {
  const StickyLessonAudioBar({super.key});

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LessonAudioManager.instance,
      builder: (context, child) {
        final manager = LessonAudioManager.instance;
        if (!manager.hasTrack) {
          return const SizedBox.shrink();
        }

        final position = manager.position;
        final duration = manager.duration;
        final isPlaying = manager.isPlaying;
        final maxMs = duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1.0;
        final currentMs = position.inMilliseconds.toDouble().clamp(0.0, maxMs);

        return Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
            border: const Border(
              top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // 1. Nút Play / Pause tròn gọn gàng
                  GestureDetector(
                    onTap: () => manager.togglePlay(),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0056D2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // 2. Thời gian: 01:05 / 01:52
                  Text(
                    '${_formatDuration(position)} / ${_formatDuration(duration)}',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),

                  // 3. Slider trượt mỏng gọn
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.5,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                        activeTrackColor: const Color(0xFF0056D2),
                        inactiveTrackColor: const Color(0xFFE2E8F0),
                        thumbColor: const Color(0xFF0056D2),
                      ),
                      child: Slider(
                        value: currentMs,
                        max: maxMs,
                        onChanged: (val) {
                          manager.seek(Duration(milliseconds: val.toInt()));
                        },
                      ),
                    ),
                  ),

                  // 4. Nút tốc độ phát (0.8x / 1.0x / 1.2x)
                  InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () => manager.cycleSpeed(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${manager.speed}x',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0056D2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),

                  // 5. Nút tắt player (X)
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18, color: Color(0xFF94A3B8)),
                    tooltip: 'Đóng',
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 26, minHeight: 26),
                    onPressed: () => manager.stop(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
