import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profilePic;
  final String userType;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.userType,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, email];
}
