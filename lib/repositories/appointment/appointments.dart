import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/property_model.dart';

final appointmentsRepoProvider = Provider<AppointmentsRepo>(
  (ref) => AppointmentsRepo(),
);

class AppointmentsRepo {
  final _appointments = FirebaseFirestore.instance.collection('appointments');

  Future<void> saveAppointment({
    required PropertyModel property,
    required DateTime date,
    required DateTime time,
    String? remarks,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await _appointments
          .add({
            'uid': uid,
            'name': property.name,
            'imageUrl': property.imageUrl,
            'location': property.location,
            'price': property.price,
            'date': date,
            'time': time,
            'remarks': remarks,
          })
          .timeout(const Duration(seconds: 60));
    } on SocketException {
      throw Exception("No internet connection, try again later");
    } on TimeoutException {
      throw Exception("Request timed out, try again later");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
