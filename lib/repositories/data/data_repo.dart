import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/models/user_model.dart';

final dataRepoProvider = Provider<DataRepo>((ref) => DataRepo());

class DataRepo {
  final Propcollection = FirebaseFirestore.instance.collection('properties');

  Future<void> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception("No internet connection");
    }
  }

  Future<List<PropertyModel>> getProperties() async {
    try {
      await _checkInternetConnection();
      final snapshot = await Propcollection.get();
      return snapshot.docs
          .map((data) => PropertyModel.fromFirestore(data))
          .toList();
    } on TimeoutException {
      throw Exception(
        "Request timed out, Please check your internet connection",
      );
    } catch (e) {
      if (e.toString().contains('No internet connection')) {
        throw Exception("No internet connection");
      }
      throw Exception("Unable to fetch data, try again later");
    }
  }

  Future<UserModel> getUserInfo(uid) async {
    try {
      await _checkInternetConnection();
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      return UserModel.fromFirestore(doc);
    } on TimeoutException {
      throw Exception(
        "Request timed out, Please check your internet connection",
      );
    } catch (e) {
      if (e.toString().contains('No internet connection')) {
        throw Exception("No internet connection");
      }
      throw Exception("Unable to user data, try again later");
    }
  }

  Future<Set<String>> getPropertyType() async {
    try {
      await _checkInternetConnection();
      Set<String> PropType = {};
      final snapshot = await Propcollection.get();
      final docs = snapshot.docs
          .map((data) => PropertyModel.fromFirestore(data))
          .toList();

      for (var property in docs) {
        PropType.add(property.propertyType);
      }
      return PropType;
    } on TimeoutException {
      throw Exception(
        "Request timed out, Please check your internet connection",
      );
    } catch (e) {
      if (e.toString().contains('No internet connection')) {
        throw Exception("No internet connection");
      }
      throw Exception("Failed to get property types!, try again later");
    }
  }
}
