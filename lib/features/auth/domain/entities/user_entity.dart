import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? phoneNumber;
  final String role;
  final String userType; // 'apprenant' or 'mentor'
  final bool isPremium;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> selectedModules;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  
  const UserEntity({
    required this.id,
    required this.email,
    this.phoneNumber,
    required this.role,
    required this.userType,
    required this.firstName,
    required this.lastName,
    this.isPremium = false,
    required this.createdAt,
    this.updatedAt,
    this.selectedModules = const [],
    this.profileImageUrl,
  });
  
  @override
  List<Object?> get props => [
    id, email, phoneNumber, role, userType, firstName, lastName, isPremium, createdAt, updatedAt, selectedModules, profileImageUrl
  ];
}
