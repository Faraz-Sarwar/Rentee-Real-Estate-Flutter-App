import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        throw Exception("Login failed. Check your internet connection");
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
}
