import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String id;
  final String mentorId;
  final String learnerId;
  final String module;
  final DateTime scheduledAt;
  final int durationMinutes;
  final String status;
  final String? meetingLink;
  final double? amount;
  final bool isPaid;

  const SessionEntity({
    required this.id,
    required this.mentorId,
    required this.learnerId,
    required this.module,
    required this.scheduledAt,
    this.durationMinutes = 60,
    this.status = 'scheduled',
    this.meetingLink,
    this.amount,
    this.isPaid = false,
  });

  @override
  List<Object?> get props => [
    id, mentorId, learnerId, module, scheduledAt,
    durationMinutes, status, meetingLink, amount, isPaid
  ];
}
