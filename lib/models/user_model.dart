import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;

  UserModel({required this.id, required this.email, required this.name});

  /// Create a UserModel from a Firestore document snapshot.
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return UserModel(
      id: doc.id,
      email: (data['email'] ?? '') as String,
      name: (data['name'] ?? '') as String,
    );
  }

  /// Create a UserModel from a plain map (e.g. from a REST API or cache).
  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: (data['email'] ?? '') as String,
      name: (data['name'] ?? '') as String,
    );
  }

  /// Convert this model into a map suitable for writing to Firestore.
  /// (id is excluded since it's the document ID, not a field.)
  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name};
  }

  UserModel copyWith({String? id, String? email, String? name}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
