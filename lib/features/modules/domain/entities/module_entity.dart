import 'package:equatable/equatable.dart';

class ModuleEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final String imagePath;
  final List<String> features;

  const ModuleEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.imagePath,
    required this.features,
  });

  @override
  List<Object> get props => [id, name, description, iconPath, imagePath, features];
}
