import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithEmailAndPasswrod(
    String email,
    String password,
  ) async {
    try {
      UserCredential? userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(
            const Duration(seconds: 15),
          ); // Request timeout after 15 seconds
      if (userCredential.user != null) {
        return userCredential;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      //Handling of Firebase exception codes
      if (e.code == "invalid-email") {
        throw Exception("Please enter a valid email!");
      } else if (e.code == "wrong-password" ||
          e.code == "user-not-found" ||
          e.code == "invalid-credential") {
        throw Exception("Invalid email or password! Please try again");
      } else {
        throw Exception("An unknown error occured. Please try again later");
      }
    } on SocketException {
      throw Exception("Login failed. No internet connection");
    } on TimeoutException {
      throw Exception("Request timed out! Check your internet connection");
    } catch (e) {
      throw Exception("An unexpected error occured! $e");
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
  ) async {
    try {
      UserCredential? userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 15));
      if (userCredential.user != null) {
        final uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'name': userName,
          'email': email,
        });
        return userCredential;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw Exception("This email is already in use, try Login");
      } else if (e.code == "invalid-email") {
        throw Exception("Please enter a valid email!");
      } else if (e.code == "weak-password") {
        throw Exception("Password should be at least 6 characters");
      } else if (e.code == "operation-not-allowed") {
        throw Exception(
          "Sign-up is currently unavailable. Please try again later",
        );
      } else if (e.code == "too-many-requests") {
        throw Exception("Too many attempts. Please wait and try again");
      } else if (e.code == "network-request-failed") {
        throw Exception("Sign up failed. Check your internet connection");
      } else {
        throw Exception("An unknown error occured. Please try again later");
      }
    } on SocketException {
      throw Exception("Login failed! No internet connection");
    } on TimeoutException {
      throw Exception("Request timed out! Check your internet connection");
    } catch (e) {
      throw Exception("An unexpected error occured! $e");
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      // Handle invalid formatting immediately
      if (e.code == "invalid-email" || e.code == "auth/invalid-email") {
        throw Exception("Please enter a valid email address.");
      }
      // Handle network or configuration issues
      else if (e.code == "network-request-failed") {
        throw Exception(
          "Network error. Please check your internet connection.",
        );
      }
      // Fallback for any other Firebase-specific errors
      else {
        throw Exception("Could not process request. Please try again later.");
      }
    } catch (e) {
      // Catch-all for non-Firebase exceptions
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // google sign in object and initialization.
      final GoogleSignIn _googleSign = GoogleSignIn.instance;
      await _googleSign.initialize();

      final GoogleSignInAccount googleAccount = await _googleSign
          .authenticate();

      final googleAuth = googleAccount.authentication;
      final googleCredentails = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredentials = await _auth.signInWithCredential(
        googleCredentails,
      );
      // Save the Google signed in user in firestore.
      final user = userCredentials.user;
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'email': user!.email,
      });

      return userCredentials.user;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      } else {
        throw Exception("Google sign in failed");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception('Something went wrong! please try againt later');
    }
  }
}
