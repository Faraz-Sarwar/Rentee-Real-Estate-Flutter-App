import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';
import 'package:rentee_real_estate/Utilities/show_message.dart';
import 'package:rentee_real_estate/components/Sign_up_view.dart';
import 'package:rentee_real_estate/components/login_view.dart';
import 'package:rentee_real_estate/view_models/auth_vm/auth_vm.dart';
import 'package:rentee_real_estate/views/home_screen.dart';

class AuthScreen extends ConsumerWidget {
  AuthScreen({super.key});

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  'assets/images/login_image.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        unselectedLabelStyle: TextStyle(fontSize: 16),
                        unselectedLabelColor: AppColors.primaryLight,
                        labelStyle: TextStyle(fontSize: 18),
                        indicatorColor: AppColors.primary,
                        tabs: [const Text('Login'), const Text('Register')],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        children: <Widget>[
                          LoginView(
                            emailController: emailController,
                            passController: passController,
                            buttonContent: authState.isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Login'),
                            onPressed: () async {
                              await ref
                                  .read(authProvider.notifier)
                                  .login(
                                    emailController.text.trim(),
                                    passController.text.trim(),
                                  );

                              error = (ref.read(authProvider).error)
                                  ?.replaceAll('Exception: ', '');

                              if (error != null) {
                                Utils.showMessage(error!);
                              }
                              if (emailController.text.isEmpty ||
                                  passController.text.isEmpty) {
                                Utils.showMessage(
                                  'Email and Password are required',
                                );
                              }
                            },
                          ),
                          SignUpView(
                            userNameController: userController,
                            emailController: emailController,
                            passController: passController,
                            confirmPassController: confirmPassController,
                            buttonContent: authState.isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Sign up'),
                            hintText1: "Email",
                            hintText2: "Password",
                            hintText3: "Confirm Password",
                            onPressed: () async {
                              await ref
                                  .read(authProvider.notifier)
                                  .SignUp(
                                    userController.text.trim(),
                                    emailController.text.trim(),
                                    passController.text.trim(),
                                  );

                              error = (ref.read(authProvider).error)
                                  ?.replaceAll('Exception: ', '');

                              if (error != null) {
                                Utils.showMessage(error!);
                              }
                              if (userController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passController.text.isEmpty ||
                                  confirmPassController.text.isEmpty) {
                                Utils.showMessage('All fields are required');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
