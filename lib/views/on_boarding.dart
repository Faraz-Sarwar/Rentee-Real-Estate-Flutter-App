import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';
import 'package:rentee_real_estate/main.dart';
import 'package:rentee_real_estate/views/auth_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  Future<void> completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardKey, true);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const AuthWrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: AppColors.white,
        pages: <PageViewModel>[
          PageViewModel(
            title: "Find Your Ideal Home",
            body:
                "Explore a wide range of rental properties and discover a home that matches your needs, lifestyle, and budget.",
            image: Image.asset(
              "assets/images/onboard_1.png",
              fit: BoxFit.cover,
            ),
            decoration: PageDecoration(bodyTextStyle: TextStyle(fontSize: 16)),
          ),

          PageViewModel(
            title: "Explore & Compare",
            body:
                "Browse property details, compare your options, and find the right place with everything you need in one app.",
            image: Image.asset(
              "assets/images/onboard_2.png",
              fit: BoxFit.cover,
            ),
            decoration: PageDecoration(bodyTextStyle: TextStyle(fontSize: 16)),
          ),
        ],
        showDoneButton: true,
        done: const Text('Done'),
        onDone: () => completeOnboarding(context),
        showSkipButton: true,
        skip: const Text('Skip'),
        onSkip: () => completeOnboarding(context),
        showNextButton: true,
        next: const Text('Next'),
        showBackButton: true,
        back: const Text('Go back'),
        dotsDecorator: DotsDecorator(
          activeSize: Size(22, 5),
          color: AppColors.primarySoft,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
