import 'package:flutter/material.dart';
import '../../domain/entities/gamification_entity.dart';

class GamificationHeader extends StatelessWidget {
  final GamificationStats stats;
  final Color primaryColor;

  const GamificationHeader({
    super.key,
    required this.stats,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildLevelInfo(), _buildPointsInfo()],
          ),
          const SizedBox(height: 16),
          _buildProgressBar(),
          const SizedBox(height: 12),
          _buildStreakInfo(),
        ],
      ),
    );
  }

  Widget _buildLevelInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Niveau ${stats.currentLevel}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${stats.pointsToNextLevel} pts pour le niveau suivant',
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPointsInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            '${stats.totalPoints}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progression',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
            Text(
              '${(stats.progressToNextLevel * 100).toInt()}%',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: stats.progressToNextLevel,
          backgroundColor: Colors.white.withOpacity(0.3),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ],
    );
  }

  Widget _buildStreakInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.local_fire_department,
          color: stats.currentStreak > 0
              ? Colors.orange
              : Colors.white.withOpacity(0.5),
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '${stats.currentStreak} jours de suite',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.emoji_events,
          color: Colors.white.withOpacity(0.7),
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          'Record: ${stats.longestStreak}',
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10),
        ),
      ],
    );
  }
}
