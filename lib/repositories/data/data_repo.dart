import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/models/user_model.dart';

final dataRepoProvider = Provider<DataRepo>((ref) => DataRepo());

class DataRepo {
  final collection = FirebaseFirestore.instance.collection('properties');
  Future<List<PropertyModel>> getProperties() async {
    try {
      final snapshot = await collection.get().timeout(
        const Duration(seconds: 30),
      );
      return snapshot.docs
          .map((data) => PropertyModel.fromFirestore(data))
          .toList();
    } on SocketException catch (e) {
      throw Exception('No internet connection');
    } on TimeoutException catch (e) {
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
    } on SocketException catch (e) {
      throw Exception('No internet connection');
    } on TimeoutException catch (e) {
      throw Exception(
        "Request timed out, Please check your internet connection",
      );
    } catch (e) {
      throw Exception("Unable to user data, try again later");
    }
  }
}
