import 'package:flutter/material.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passController;
  const LoginView({
    super.key,
    required this.emailController,
    required this.passController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        CustomTextField(
          icon: Icons.email_outlined,
          controller: emailController,
          hintText: "Email",
          hideText: false,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          icon: Icons.lock_outline_rounded,
          controller: passController,
          hintText: "Password",
          hideText: true,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
