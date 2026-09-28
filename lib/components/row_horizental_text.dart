import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';

class RowHorizentalText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? size;
  const RowHorizentalText({
    super.key,
    required this.icon,
    required this.text,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: size ?? 32),
        const SizedBox(width: AppSize.small),
        Text(text),
      ],
    );
  }
}
