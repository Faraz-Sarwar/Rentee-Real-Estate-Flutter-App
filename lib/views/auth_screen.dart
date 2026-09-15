import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/Utilities/show_message.dart';
import 'package:rentee_real_estate/components/Sign_up_view.dart';
import 'package:rentee_real_estate/components/custom_button.dart';
import 'package:rentee_real_estate/components/login_view.dart';
import 'package:rentee_real_estate/view_models/auth_vm/auth_vm.dart';
import 'package:rentee_real_estate/views/forget_password_screen.dart';

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
    final authState = ref.watch(authVmProvider);
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
                padding: const EdgeInsets.all(AppSize.medium),
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
                          Column(
                            children: [
                              LoginView(
                                emailController: loginEmailController,
                                passController: loginPassController,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordScreen(),
                                    ),
                                  ),
                                  child: const Text(
                                    'Forget password?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              CustomButton(
                                buttonContent: authState.isLoading
                                    ? const CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                onPressed: () async {
                                  await ref
                                      .read(authVmProvider.notifier)
                                      .login(
                                        loginEmailController.text.trim(),
                                        loginPassController.text.trim(),
                                      );

                                  error = (ref.read(authVmProvider).error)
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
                                width: MediaQuery.of(context).size.height * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.055,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SignUpView(
                                userNameController: signupuserController,
                                emailController: signupEmailController,
                                passController: signupPassController,
                                confirmPassController:
                                    signupConfirmPassController,

                                hintText1: "Email",
                                hintText2: "Password",
                                hintText3: "Confirm Password",
                              ),
                              CustomButton(
                                buttonContent: authState.isLoading
                                    ? const CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                    : const Text(
                                        'Sign up',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                onPressed: () async {
                                  await ref
                                      .read(authVmProvider.notifier)
                                      .SignUp(
                                        signupuserController.text.trim(),
                                        signupEmailController.text.trim(),
                                        signupPassController.text.trim(),
                                      );

                                  error = (ref.read(authVmProvider).error)
                                      ?.replaceAll('Exception: ', '');
                                  if (signupuserController.text.isEmpty ||
                                      signupEmailController.text.isEmpty ||
                                      signupPassController.text.isEmpty ||
                                      signupConfirmPassController
                                          .text
                                          .isEmpty) {
                                    Utils.showMessage(
                                      'All fields are required',
                                    );
                                  } else if (error != null) {
                                    Utils.showMessage(error!);
                                  } else {
                                    return null;
                                  }
                                },
                                width: MediaQuery.of(context).size.height * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.055,
                              ),
                            ],
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
