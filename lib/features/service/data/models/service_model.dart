import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/entities/subscription_version.dart';
import 'package:myapp/features/service/domain/entities/town.dart';

class ServiceModel extends Service {
  const ServiceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.town,
    required super.address,
    required super.phoneNumber,
    required super.email,
    required super.ownerId,
    required super.imageUrls,
    required super.averageRating,
    required super.createdAt,
    required super.status,
    required super.subVersion,
  });

  factory ServiceModel.fromMap(DataMap map) {
    return ServiceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: ServiceCategory.fromString(map['category'] as String),
      town: Town.values.firstWhere((e) => e.label == map['town']),
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      ownerId: map['ownerId'] as String,
      imageUrls: List<String>.from(map['imageUrls'] as List),
      averageRating: (map['averageRating'] as num).toDouble(),
      createdAt: DateTime.parse(map['createdAt'] as String),
      status: map['status'] as bool,
      subVersion: SubscriptionVersion.values.firstWhere(
        (e) => e.label == map['subVersion'],
      ),
    );
  }

  factory ServiceModel.fromEntity(Service entity) {
    return ServiceModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      category: entity.category,
      town: entity.town,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      ownerId: entity.ownerId,
      imageUrls: entity.imageUrls,
      averageRating: entity.averageRating,
      createdAt: entity.createdAt,
      status: entity.status,
      subVersion: entity.subVersion,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.label,
      'town': town.label,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'ownerId': ownerId,
      'imageUrls': imageUrls,
      'averageRating': averageRating,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'subVersion': subVersion.label,
    };
  }
}
