import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

enum ActivityStatus { todo, inProgress, done }

/// Status chip widget for activities
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.status,
  });

  final ActivityStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      ActivityStatus.done => ('Valmis', AppColors.done, const Color(0xFFE8F5F0)),
      ActivityStatus.inProgress => ('Kesken', AppColors.inProgress, const Color(0xFFE8F0FF)),
      ActivityStatus.todo => ('Tekemättä', AppColors.todo, AppColors.background),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == ActivityStatus.done)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(Icons.check_circle, size: 12, color: color),
            ),
          Text(
            label,
            style: AppTextStyles.labelMd.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

/// Circular progress indicator badge
class ProgressBadge extends StatelessWidget {
  const ProgressBadge({
    super.key,
    required this.progress,
    this.size = 48,
    this.strokeWidth = 3.5,
    this.foregroundColor,
    this.backgroundColor,
  });

  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final fg = foregroundColor ?? AppColors.primary;
    final bg = backgroundColor ?? AppColors.borderLight;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: strokeWidth,
            backgroundColor: bg,
            valueColor: AlwaysStoppedAnimation<Color>(fg),
          ),
          Text(
            '${(progress * 100).round()}%',
            style: AppTextStyles.labelMd.copyWith(
              fontSize: 10,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
