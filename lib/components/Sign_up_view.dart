import 'package:flutter/material.dart';
import 'package:rentee_real_estate/components/custom_button.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;

  final String? hintText1;
  final String? hintText2;
  final String? hintText3;
  final Widget buttonContent;
  final VoidCallback onPressed;
  const SignUpView({
    super.key,
    required this.userNameController,
    required this.emailController,
    required this.passController,
    required this.confirmPassController,
    this.hintText1,
    this.hintText2,
    this.hintText3,
    required this.buttonContent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        CustomTextField(controller: userNameController, hintText: "Username"),
        const SizedBox(height: 16),
        CustomTextField(controller: emailController, hintText: "Email"),
        const SizedBox(height: 16),
        CustomTextField(controller: passController, hintText: "Password"),
        const SizedBox(height: 16),
        CustomTextField(
          controller: confirmPassController,
          hintText: "Confirm password",
        ),
        const SizedBox(height: 32),
        CustomButton(
          buttonContent: buttonContent,
          onPressed: onPressed,
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
        ),
      ],
    );
    ;
  }
}
