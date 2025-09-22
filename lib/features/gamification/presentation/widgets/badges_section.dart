import 'package:flutter/material.dart';
import '../../domain/entities/gamification_entity.dart' as gamif;

class BadgesSection extends StatelessWidget {
  final List<gamif.Badge> badges;
  final Color primaryColor;

  const BadgesSection({
    super.key,
    required this.badges,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final earnedBadges = badges.where((badge) => badge.isEarned).toList();
    final availableBadges = badges
        .where((badge) => !badge.isEarned)
        .take(3)
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events, color: primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Badges',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${earnedBadges.length}/${badges.length}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (earnedBadges.isNotEmpty) ...[
              const Text(
                'Badges obtenus',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: earnedBadges.length,
                  itemBuilder: (context, index) {
                    return _buildBadgeItem(earnedBadges[index], true);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (availableBadges.isNotEmpty) ...[
              const Text(
                'Prochains badges',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: availableBadges.length,
                  itemBuilder: (context, index) {
                    return _buildBadgeItem(availableBadges[index], false);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeItem(gamif.Badge badge, bool isEarned) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isEarned ? _getBadgeColor(badge.type) : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: isEarned
                  ? [
                      BoxShadow(
                        color: _getBadgeColor(badge.type).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              _getBadgeIcon(badge.type),
              color: isEarned ? Colors.white : Colors.grey[500],
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            badge.name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isEarned ? Colors.black87 : Colors.grey[500],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(gamif.BadgeType type) {
    switch (type) {
      case gamif.BadgeType.bronze:
        return const Color(0xFFCD7F32);
      case gamif.BadgeType.silver:
        return const Color(0xFFC0C0C0);
      case gamif.BadgeType.gold:
        return const Color(0xFFFFD700);
      case gamif.BadgeType.platinum:
        return const Color(0xFFE5E4E2);
      case gamif.BadgeType.special:
        return primaryColor;
    }
  }

  IconData _getBadgeIcon(gamif.BadgeType type) {
    switch (type) {
      case gamif.BadgeType.bronze:
        return Icons.workspace_premium;
      case gamif.BadgeType.silver:
        return Icons.military_tech;
      case gamif.BadgeType.gold:
        return Icons.emoji_events;
      case gamif.BadgeType.platinum:
        return Icons.diamond;
      case gamif.BadgeType.special:
        return Icons.star;
    }
  }
}
