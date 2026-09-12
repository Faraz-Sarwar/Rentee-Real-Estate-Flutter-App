import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String id;
  final int area;
  final int bathrooms;
  final int bedrooms;
  final String description;
  final String imageUrl;
  final String location;
  final String name;
  final bool parking;
  final int price;
  final String pricePeriod;
  final String propertyType;
  final double rating;
  final int reviews;

  PropertyModel({
    required this.id,
    required this.area,
    required this.bathrooms,
    required this.bedrooms,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.name,
    required this.parking,
    required this.price,
    required this.pricePeriod,
    required this.propertyType,
    required this.rating,
    required this.reviews,
  });

  /// Create a PropertyModel from a Firestore document snapshot.
  factory PropertyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return PropertyModel(
      id: doc.id,
      area: (data['area'] ?? 0) as int,
      bathrooms: (data['bathrooms'] ?? 0) as int,
      bedrooms: (data['bedrooms'] ?? 0) as int,
      description: (data['description'] ?? '') as String,
      imageUrl: (data['imageUrl'] ?? '') as String,
      location: (data['location'] ?? '') as String,
      name: (data['name'] ?? '') as String,
      parking: (data['parking'] ?? false) as bool,
      price: (data['price'] ?? 0) as int,
      pricePeriod: (data['pricePeriod'] ?? '') as String,
      propertyType: (data['propertyType'] ?? '') as String,
      rating: ((data['rating'] ?? 0) as num).toDouble(),
      reviews: (data['reviews'] ?? 0) as int,
    );
  }

  /// Create a PropertyModel from a plain map (e.g. from a REST API or cache).
  factory PropertyModel.fromMap(Map<String, dynamic> data, String id) {
    return PropertyModel(
      id: id,
      area: (data['area'] ?? 0) as int,
      bathrooms: (data['bathrooms'] ?? 0) as int,
      bedrooms: (data['bedrooms'] ?? 0) as int,
      description: (data['description'] ?? '') as String,
      imageUrl: (data['imageUrl'] ?? '') as String,
      location: (data['location'] ?? '') as String,
      name: (data['name'] ?? '') as String,
      parking: (data['parking'] ?? false) as bool,
      price: (data['price'] ?? 0) as int,
      pricePeriod: (data['pricePeriod'] ?? '') as String,
      propertyType: (data['propertyType'] ?? '') as String,
      rating: ((data['rating'] ?? 0) as num).toDouble(),
      reviews: (data['reviews'] ?? 0) as int,
    );
  }

  /// Convert this model into a map suitable for writing to Firestore.
  /// (id is excluded since it's the document ID, not a field.)
  Map<String, dynamic> toMap() {
    return {
      'area': area,
      'bathrooms': bathrooms,
      'bedrooms': bedrooms,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'name': name,
      'parking': parking,
      'price': price,
      'pricePeriod': pricePeriod,
      'propertyType': propertyType,
      'rating': rating,
      'reviews': reviews,
    };
  }

  PropertyModel copyWith({
    String? id,
    int? area,
    int? bathrooms,
    int? bedrooms,
    String? description,
    String? imageUrl,
    String? location,
    String? name,
    bool? parking,
    int? price,
    String? pricePeriod,
    String? propertyType,
    double? rating,
    int? reviews,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      area: area ?? this.area,
      bathrooms: bathrooms ?? this.bathrooms,
      bedrooms: bedrooms ?? this.bedrooms,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      name: name ?? this.name,
      parking: parking ?? this.parking,
      price: price ?? this.price,
      pricePeriod: pricePeriod ?? this.pricePeriod,
      propertyType: propertyType ?? this.propertyType,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
    );
  }
}
