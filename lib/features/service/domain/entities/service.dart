import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/subscription_version.dart';
import 'package:myapp/features/service/domain/entities/town.dart';

class Service extends Equatable {
  final String id;
  final String name;
  final String description;
  final ServiceCategory category;
  final Town town;
  final String address;
  final String phoneNumber;
  final String email;
  final String ownerId;
  final List<String> imageUrls;
  final double averageRating;
  final DateTime createdAt;
  final bool status;
  final SubscriptionVersion subVersion;

  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.town,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.ownerId,
    required this.imageUrls,
    required this.averageRating,
    required this.createdAt,
    required this.status,
    required this.subVersion,
  });

  Service copyWith({
    String? id,
    String? name,
    String? description,
    ServiceCategory? category,
    Town? town,
    String? address,
    String? phoneNumber,
    String? email,
    String? ownerId,
    List<String>? imageUrls,
    double? averageRating,
    DateTime? createdAt,
    bool? status,
    SubscriptionVersion? subVersion,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      town: town ?? this.town,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      ownerId: ownerId ?? this.ownerId,
      imageUrls: imageUrls ?? this.imageUrls,
      averageRating: averageRating ?? this.averageRating,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      subVersion: subVersion ?? this.subVersion,
    );
  }

  factory Service.fromSnapshot(DocumentSnapshot snap) {
    return Service(
      id: snap.id,
      name: snap['name'],
      description: snap['description'],
      category: ServiceCategory.values.firstWhere((e) => e.name == snap['category']),
      town: Town.values.firstWhere((e) => e.name == snap['town']),
      address: snap['address'],
      phoneNumber: snap['phoneNumber'],
      email: snap['email'],
      ownerId: snap['ownerId'],
      imageUrls: List<String>.from(snap['imageUrls']),
      averageRating: (snap['averageRating'] as num).toDouble(),
      createdAt: (snap['createdAt'] as Timestamp).toDate(),
      status: snap['status'],
      subVersion: SubscriptionVersion.values.firstWhere((e) => e.name == snap['subVersion']),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'description': description,
      'category': category.name,
      'town': town.name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'ownerId': ownerId,
      'imageUrls': imageUrls,
      'averageRating': averageRating,
      'createdAt': createdAt,
      'status': status,
      'subVersion': subVersion.name,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        town,
        address,
        phoneNumber,
        email,
        ownerId,
        imageUrls,
        averageRating,
        createdAt,
        status,
        subVersion,
      ];
}
