import 'package:equatable/equatable.dart';

class MentorEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final List<String> expertise;
  final List<String> modules;
  final double rating;
  final int totalSessions;
  final String? bio;
  final List<String> availableSlots;
  final double? hourlyRate;

  const MentorEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    required this.expertise,
    required this.modules,
    this.rating = 0.0,
    this.totalSessions = 0,
    this.bio,
    this.availableSlots = const [],
    this.hourlyRate,
  });

  @override
  List<Object?> get props => [
    id, name, email, profileImage, expertise, modules,
    rating, totalSessions, bio, availableSlots, hourlyRate
  ];
}
