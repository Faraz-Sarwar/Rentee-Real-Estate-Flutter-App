import 'package:flutter/material.dart';
import 'package:rentee_real_estate/components/custom_button.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passController;
  final Widget buttonContent;
  final VoidCallback onPressed;
  const LoginView({
    super.key,
    required this.emailController,
    required this.passController,
    required this.buttonContent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        CustomTextField(controller: emailController, hintText: "Email"),
        const SizedBox(height: 16),
        CustomTextField(controller: passController, hintText: "Password"),
        const SizedBox(height: 32),
        CustomButton(
          buttonContent: buttonContent,
          onPressed: onPressed,
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
        ),
      ],
    );
  }
}
