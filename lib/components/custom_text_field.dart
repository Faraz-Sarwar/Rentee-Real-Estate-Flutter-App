import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: hintText,
        prefixIcon: const Icon(Icons.email_outlined),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
