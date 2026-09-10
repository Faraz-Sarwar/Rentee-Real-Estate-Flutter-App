import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentee_real_estate/views/auth_screen.dart';
import 'package:rentee_real_estate/views/home_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // authStateChanges() constantly checks weather user auth data
      // has changed (means if user is still logged in or has logged out).
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return const HomeScreen();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
