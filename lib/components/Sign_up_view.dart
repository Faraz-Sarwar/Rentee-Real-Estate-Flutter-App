import 'package:flutter/material.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;

  final String? hintText1;
  final String? hintText2;
  final String? hintText3;
  const SignUpView({
    super.key,
    required this.userNameController,
    required this.emailController,
    required this.passController,
    required this.confirmPassController,
    this.hintText1,
    this.hintText2,
    this.hintText3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        CustomTextField(
          controller: userNameController,
          hintText: "Username",
          hideText: false,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: emailController,
          hintText: "Email",
          hideText: false,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: passController,
          hintText: "Password",
          hideText: true,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: confirmPassController,
          hintText: "Confirm password",
          hideText: true,
        ),
        const SizedBox(height: 32),
      ],
    );
    ;
  }
}
