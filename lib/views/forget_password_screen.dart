import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/Utilities/show_message.dart';
import 'package:rentee_real_estate/components/custom_button.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';
import 'package:rentee_real_estate/view_models/auth_vm/auth_vm.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final forgetPassController = TextEditingController();
  String? error;
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authVmProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Restore password'),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.medium),
        child: Column(
          children: <Widget>[
            CustomTextField(
              icon: Icons.email_outlined,
              controller: forgetPassController,
              hintText: 'Enter your email',
              hideText: false,
            ),
            const SizedBox(height: 16),
            CustomButton(
              buttonContent: authState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              onPressed: () async {
                await ref
                    .read(authVmProvider.notifier)
                    .sendForgotPassEmail(forgetPassController.text.trim());
                forgetPassController.clear();
                error = ref.read(authVmProvider).error;
                if (error != null) {
                  Utils.showMessage(error!);
                } else {
                  Utils.showMessage(
                    'Forget password link sent! Please check your email',
                  );
                }
              },
              width: MediaQuery.of(context).size.height * 0.2,
              height: MediaQuery.of(context).size.height * 0.055,
            ),
          ],
        ),
      ),
    );
  }
}
