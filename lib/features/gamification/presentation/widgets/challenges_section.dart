import 'package:flutter/material.dart';
import '../../domain/entities/gamification_entity.dart';

class ChallengesSection extends StatelessWidget {
  final List<Challenge> challenges;
  final Color primaryColor;

  const ChallengesSection({
    super.key,
    required this.challenges,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeChallenges = challenges.where((c) => !c.isCompleted).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.flag, color: primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Défis actifs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...activeChallenges.map(
              (challenge) => _buildChallengeItem(challenge),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeItem(Challenge challenge) {
    final daysLeft = challenge.deadline.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  challenge.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+${challenge.pointsReward} pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            challenge.description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: challenge.progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(challenge.progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getChallengeTypeText(challenge.type),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                daysLeft > 0
                    ? '$daysLeft jours restants'
                    : 'Expire aujourd\'hui',
                style: TextStyle(
                  fontSize: 10,
                  color: daysLeft <= 1 ? Colors.red : Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getChallengeTypeText(ChallengeType type) {
    switch (type) {
      case ChallengeType.daily:
        return 'QUOTIDIEN';
      case ChallengeType.weekly:
        return 'HEBDOMADAIRE';
      case ChallengeType.monthly:
        return 'MENSUEL';
      case ChallengeType.special:
        return 'SPÉCIAL';
    }
  }
}
