import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonContent;
  final double width;
  final double height;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.buttonContent,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

        // minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
        minimumSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: buttonContent,
    );
  }
}
