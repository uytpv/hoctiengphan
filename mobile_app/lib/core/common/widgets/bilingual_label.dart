import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Displays bilingual label: Finnish primary + secondary language in parentheses.
/// Example: "Harjoitus (Bài tập)" or "Harjoitus (Exercise)"
class BilingualLabel extends StatelessWidget {
  const BilingualLabel({
    super.key,
    required this.primary,
    required this.secondary,
    this.primaryStyle,
    this.secondaryStyle,
    this.axis = Axis.horizontal,
    this.spacing = 4.0,
    this.showParentheses = true,
  });

  final String primary;
  final String secondary;
  final TextStyle? primaryStyle;
  final TextStyle? secondaryStyle;
  final Axis axis;
  final double spacing;
  final bool showParentheses;

  @override
  Widget build(BuildContext context) {
    final secText = showParentheses ? '($secondary)' : secondary;

    if (axis == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            primary,
            style: primaryStyle ?? AppTextStyles.bilingualPrimary,
          ),
          SizedBox(width: spacing),
          Text(
            secText,
            style: secondaryStyle ??
                AppTextStyles.bilingualSecondary.copyWith(
                  color: AppColors.neutral,
                ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          primary,
          style: primaryStyle ?? AppTextStyles.bilingualPrimary,
        ),
        SizedBox(height: spacing),
        Text(
          secText,
          style: secondaryStyle ??
              AppTextStyles.bilingualSecondary.copyWith(
                color: AppColors.neutral,
              ),
        ),
      ],
    );
  }
}
