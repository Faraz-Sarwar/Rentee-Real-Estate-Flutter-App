import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  DateTime date;
  final String imageUrl;
  final String location;
  final String name;
  final int price;
  final String? remarks;
  final DateTime time;
  final String uid;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.imageUrl,
    required this.location,
    required this.name,
    required this.price,
    this.remarks,
    required this.time,
    required this.uid,
  });

  /// Create an AppointmentModel from a Firestore document snapshot.
  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return AppointmentModel(
      id: doc.id,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: (data['imageUrl'] ?? '') as String,
      location: (data['location'] ?? '') as String,
      name: (data['name'] ?? '') as String,
      price: (data['price'] ?? 0) as int,
      remarks: data['remarks'] as String?,
      time: (data['time'] as Timestamp?)?.toDate() ?? DateTime.now(),
      uid: (data['uid'] ?? '') as String,
    );
  }

  /// Create an AppointmentModel from a plain map (e.g. from a REST API or cache).
  factory AppointmentModel.fromMap(Map<String, dynamic> data, String id) {
    return AppointmentModel(
      id: id,
      date: data['date'] is Timestamp
          ? (data['date'] as Timestamp).toDate()
          : DateTime.parse(data['date'] as String),
      imageUrl: (data['imageUrl'] ?? '') as String,
      location: (data['location'] ?? '') as String,
      name: (data['name'] ?? '') as String,
      price: (data['price'] ?? 0) as int,
      remarks: data['remarks'] as String?,
      time: data['time'] is Timestamp
          ? (data['time'] as Timestamp).toDate()
          : DateTime.parse(data['time'] as String),
      uid: (data['uid'] ?? '') as String,
    );
  }

  /// Convert this model into a map suitable for writing to Firestore.
  /// (id is excluded since it's the document ID, not a field.)
  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'imageUrl': imageUrl,
      'location': location,
      'name': name,
      'price': price,
      'remarks': remarks,
      'time': Timestamp.fromDate(time),
      'uid': uid,
    };
  }

  AppointmentModel copyWith({
    String? id,
    DateTime? date,
    String? imageUrl,
    String? location,
    String? name,
    int? price,
    String? remarks,
    DateTime? time,
    String? uid,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      name: name ?? this.name,
      price: price ?? this.price,
      remarks: remarks ?? this.remarks,
      time: time ?? this.time,
      uid: uid ?? this.uid,
    );
  }
}
