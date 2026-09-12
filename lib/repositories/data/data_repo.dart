import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/models/user_model.dart';

final dataRepoProvider = Provider<DataRepo>((ref) => DataRepo());

class DataRepo {
  final collection = FirebaseFirestore.instance.collection('properties');
  Future<List<PropertyModel>> getProperties() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map((data) => PropertyModel.fromFirestore(data))
        .toList();
  }

  Future<UserModel> getUserInfo(uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final user = UserModel.fromFirestore(doc);

    return user;
  }
}
