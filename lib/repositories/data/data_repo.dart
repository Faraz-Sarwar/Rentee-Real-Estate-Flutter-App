import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/models/user_model.dart';

final dataRepoProvider = Provider<DataRepo>((ref) => DataRepo());

class DataRepo {
  final Propcollection = FirebaseFirestore.instance.collection('properties');
  Future<List<PropertyModel>> getProperties() async {
    try {
      final snapshot = await Propcollection.get().timeout(
        const Duration(seconds: 30),
      );
      return snapshot.docs
          .map((data) => PropertyModel.fromFirestore(data))
          .toList();
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception(
        "Request timed out, Please check your internet connection",
      );
    } catch (e) {
      throw Exception("Unable to fetch data, try again later");
    }
  }

  Future<UserModel> getUserInfo(uid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      return UserModel.fromFirestore(doc);
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception(
        "Request timed out, Please check your internet connection",
      );
    } catch (e) {
      throw Exception("Unable to user data, try again later");
    }
  }

  Future<Set<String>> getPropertyType() async {
    try {
      Set<String> PropType = {};
      final snapshot = await Propcollection.get().timeout(
        const Duration(seconds: 30),
      );
      final docs = snapshot.docs
          .map((data) => PropertyModel.fromFirestore(data))
          .toList();

      for (var property in docs) {
        PropType.add(property.propertyType);
      }
      return PropType;
    } on SocketException {
      throw Exception("No internet connection");
    } on TimeoutException {
      throw Exception(
        "Request timed out, Please check your internet connection",
      );
    } catch (e) {
      throw Exception("Failed to get property types!, try again later");
    }
  }
}
