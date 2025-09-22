class GamificationStats {
  final int totalPoints;
  final int currentLevel;
  final int pointsToNextLevel;
  final double progressToNextLevel;
  final List<Badge> badges;
  final int currentStreak;
  final int longestStreak;
  final Map<String, int> modulePoints;

  const GamificationStats({
    required this.totalPoints,
    required this.currentLevel,
    required this.pointsToNextLevel,
    required this.progressToNextLevel,
    required this.badges,
    required this.currentStreak,
    required this.longestStreak,
    required this.modulePoints,
  });
}

class Badge {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final BadgeType type;
  final DateTime? earnedAt;
  final bool isEarned;

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.type,
    this.earnedAt,
    required this.isEarned,
  });
}

enum BadgeType { bronze, silver, gold, platinum, special }

class Challenge {
  final String id;
  final String title;
  final String description;
  final int pointsReward;
  final DateTime deadline;
  final double progress;
  final bool isCompleted;
  final ChallengeType type;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsReward,
    required this.deadline,
    required this.progress,
    required this.isCompleted,
    required this.type,
  });
}

enum ChallengeType { daily, weekly, monthly, special }
