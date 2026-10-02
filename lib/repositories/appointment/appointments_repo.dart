import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/appointment_model.dart';
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

  Stream<List<AppointmentModel>> getAppointments() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _appointments
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AppointmentModel.fromFirestore(doc))
              .toList(),
        )
        .handleError((e) {
          throw Exception(e.toString());
        });
  }

  Future<void> deleteAppointment(String id) async {
    try {
      await _appointments.doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to delete appointment');
    }
  }

  Future<void> rescheduleAppointment(DateTime newDate, String id) async {
    try {
      await _appointments.doc(id).update({'date': newDate});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
