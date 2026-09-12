import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';
import 'package:rentee_real_estate/Utilities/show_message.dart';
import 'package:rentee_real_estate/components/Sign_up_view.dart';
import 'package:rentee_real_estate/components/login_view.dart';
import 'package:rentee_real_estate/view_models/auth_vm/auth_vm.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();
  final signupuserController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPassController = TextEditingController();
  final signupConfirmPassController = TextEditingController();
  String? error;

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPassController.dispose();
    signupuserController.dispose();
    signupEmailController.dispose();
    signupPassController.dispose();
    signupConfirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            emailController: loginEmailController,
                            passController: loginPassController,
                            buttonContent: authState.isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : const Text('Login'),
                            onPressed: () async {
                              await ref
                                  .read(authProvider.notifier)
                                  .login(
                                    loginEmailController.text.trim(),
                                    loginPassController.text.trim(),
                                  );

                              error = (ref.read(authProvider).error)
                                  ?.replaceAll('Exception: ', '');
                              if (loginEmailController.text.isEmpty ||
                                  loginPassController.text.isEmpty) {
                                Utils.showMessage(
                                  'Email and Password are required',
                                );
                              } else if (error != null) {
                                Utils.showMessage(error!);
                              } else {
                                return null;
                              }
                            },
                          ),
                          SignUpView(
                            userNameController: signupuserController,
                            emailController: signupEmailController,
                            passController: signupPassController,
                            confirmPassController: signupConfirmPassController,
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
                                    signupuserController.text.trim(),
                                    signupEmailController.text.trim(),
                                    signupPassController.text.trim(),
                                  );

                              error = (ref.read(authProvider).error)
                                  ?.replaceAll('Exception: ', '');
                              if (signupuserController.text.isEmpty ||
                                  signupEmailController.text.isEmpty ||
                                  signupPassController.text.isEmpty ||
                                  signupConfirmPassController.text.isEmpty) {
                                Utils.showMessage('All fields are required');
                              } else if (error != null) {
                                Utils.showMessage(error!);
                              } else {
                                return null;
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
