import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';
import 'package:rentee_real_estate/firebase_options.dart';
import 'package:rentee_real_estate/views/auth_wrapper.dart';
import 'package:rentee_real_estate/views/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

final onboardKey = 'hasSeenOnboarding';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool(onboardKey) ?? false;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp(hasSeenOnboarding: seenOnboarding)));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, required this.hasSeenOnboarding});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        fontFamily: "Poppins",
      ),
      home: hasSeenOnboarding ? const AuthWrapper() : const OnBoardingScreen(),
    );
  }
}
