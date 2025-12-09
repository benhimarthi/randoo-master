import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.profilePic,
    required super.userType,
    required super.createdAt,
  });

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      userType: map['userType'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profilePic,
    String? userType,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  DataMap toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'profilePic': profilePic,
    'userType': userType,
    'createdAt': createdAt.toIso8601String(),
  };
}
