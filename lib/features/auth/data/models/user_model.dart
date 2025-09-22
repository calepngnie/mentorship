import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.profileImageUrl,
    super.isPremium,
    super.role = '',
    required super.createdAt,
    super.updatedAt,
    super.userType = '',
    super.selectedModules,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      profileImageUrl: entity.profileImageUrl,
      isPremium: entity.isPremium,
      role: entity.role,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      userType: entity.userType,
      selectedModules: entity.selectedModules,
    );
  }
}
