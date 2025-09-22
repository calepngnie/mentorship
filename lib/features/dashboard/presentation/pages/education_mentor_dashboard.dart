import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../gamification/domain/entities/gamification_entity.dart'
    as gamif;
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../../gamification/presentation/widgets/badges_section.dart';
import '../../../gamification/presentation/widgets/challenges_section.dart';

class EducationMentorDashboard extends StatelessWidget {
  const EducationMentorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Démo : valeurs statiques pour GamificationStats, Badges et Challenges
    final primaryColor = Theme.of(context).primaryColor;
    final stats = gamif.GamificationStats(
      totalPoints: 2450,
      currentLevel: 8,
      pointsToNextLevel: 550,
      progressToNextLevel: 0.82,
      badges: [
        gamif.Badge(
          id: '1',
          name: 'Mentor Dévoué',
          description: 'A aidé 5 apprenants',
          iconPath: '',
          type: gamif.BadgeType.gold,
          earnedAt: DateTime.now().subtract(const Duration(days: 2)),
          isEarned: true,
        ),
        gamif.Badge(
          id: '2',
          name: 'Expert Pédagogue',
          description: 'A créé 3 cours',
          iconPath: '',
          type: gamif.BadgeType.silver,
          earnedAt: DateTime.now().subtract(const Duration(days: 5)),
          isEarned: true,
        ),
        gamif.Badge(
          id: '3',
          name: 'Guide Inspirant',
          description: 'A reçu 10 évaluations 5 étoiles',
          iconPath: '',
          type: gamif.BadgeType.bronze,
          earnedAt: null,
          isEarned: false,
        ),
      ],
      currentStreak: 15,
      longestStreak: 22,
      modulePoints: {'Maths': 1200, 'Histoire': 800},
    );
    final challenges = [
      gamif.Challenge(
        id: 'c1',
        title: 'Aider 5 apprenants cette semaine',
        description: 'Aider 5 apprenants à progresser',
        pointsReward: 100,
        deadline: DateTime.now().add(const Duration(days: 3)),
        progress: 0.6,
        isCompleted: false,
        type: gamif.ChallengeType.weekly,
      ),
      gamif.Challenge(
        id: 'c2',
        title: 'Créer 3 nouveaux cours',
        description: 'Créer 3 nouveaux cours pour la plateforme',
        pointsReward: 150,
        deadline: DateTime.now().add(const Duration(days: 5)),
        progress: 0.33,
        isCompleted: false,
        type: gamif.ChallengeType.weekly,
      ),
      gamif.Challenge(
        id: 'c3',
        title: 'Obtenir 10 évaluations 5 étoiles',
        description:
            'Recevoir 10 évaluations 5 étoiles de la part des apprenants',
        pointsReward: 200,
        deadline: DateTime.now().add(const Duration(days: 7)),
        progress: 0.8,
        isCompleted: false,
        type: gamif.ChallengeType.weekly,
      ),
    ];
    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard Mentor - Éducation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GamificationHeader(stats: stats, primaryColor: primaryColor),
            const SizedBox(height: 24),
            _buildMyStudentsSection(context),
            const SizedBox(height: 24),
            _buildCoursesToReviewSection(context),
            const SizedBox(height: 24),
            BadgesSection(badges: stats.badges, primaryColor: primaryColor),
            const SizedBox(height: 24),
            ChallengesSection(
              challenges: challenges,
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 24),
            _buildStatsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMyStudentsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Mes Apprenants (12)',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final students = [
                  {
                    'name': 'Marie Dubois',
                    'progress': 0.75,
                    'lastActivity': '2h',
                  },
                  {
                    'name': 'Pierre Martin',
                    'progress': 0.60,
                    'lastActivity': '1j',
                  },
                  {
                    'name': 'Sophie Laurent',
                    'progress': 0.90,
                    'lastActivity': '30min',
                  },
                ];
                final student = students[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(student['name'].toString().substring(0, 1)),
                  ),
                  title: Text(student['name'].toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dernière activité: ${student['lastActivity']}'),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: student['progress'] as double,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.message),
                    onPressed: () {},
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('Voir tous les apprenants'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesToReviewSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.rate_review, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Devoirs à Corriger (8)',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final assignments = [
                  {
                    'title': 'Dissertation sur l\'Histoire',
                    'student': 'Marie D.',
                    'due': '2j',
                  },
                  {
                    'title': 'Exercices de Mathématiques',
                    'student': 'Pierre M.',
                    'due': '1j',
                  },
                  {
                    'title': 'Analyse de Texte',
                    'student': 'Sophie L.',
                    'due': '3h',
                  },
                ];
                final assignment = assignments[index];

                return ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.orange),
                  title: Text(assignment['title'].toString()),
                  subtitle: Text(
                    'Par ${assignment['student']} • À rendre dans ${assignment['due']}',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Corriger'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistiques du Mois',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Sessions',
                    '24',
                    Icons.schedule,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Heures',
                    '48h',
                    Icons.access_time,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Note Moy.',
                    '4.8/5',
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Revenus',
                    '1,200€',
                    Icons.euro,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
