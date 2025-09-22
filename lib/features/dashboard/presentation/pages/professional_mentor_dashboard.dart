import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../gamification/domain/entities/gamification_entity.dart' as gamif;
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../../gamification/presentation/widgets/badges_section.dart';
import '../../../gamification/presentation/widgets/challenges_section.dart';

class ProfessionalMentorDashboard extends StatelessWidget {
  const ProfessionalMentorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final stats = gamif.GamificationStats(
      totalPoints: 3800,
      currentLevel: 12,
      pointsToNextLevel: 700,
      progressToNextLevel: 0.84,
      badges: [
        gamif.Badge(
          id: 'recruteur_expert',
          name: 'Recruteur Expert',
          description: 'A aidé 10 mentorés à trouver un emploi',
          iconPath: '',
          type: gamif.BadgeType.gold,
          earnedAt: DateTime.now().subtract(const Duration(days: 10)),
          isEarned: true,
        ),
        gamif.Badge(
          id: 'coach_carriere',
          name: 'Coach Carrière',
          description: 'A accompagné 5 mentorés dans leur évolution',
          iconPath: '',
          type: gamif.BadgeType.silver,
          earnedAt: DateTime.now().subtract(const Duration(days: 20)),
          isEarned: true,
        ),
        gamif.Badge(
          id: 'networker_pro',
          name: 'Networker Pro',
          description: 'A organisé 3 événements de networking',
          iconPath: '',
          type: gamif.BadgeType.bronze,
          earnedAt: DateTime.now().subtract(const Duration(days: 30)),
          isEarned: true,
        ),
        gamif.Badge(
          id: 'leader_inspirant',
          name: 'Leader Inspirant',
          description: 'A inspiré 20 mentorés',
          iconPath: '',
          type: gamif.BadgeType.special,
          earnedAt: null,
          isEarned: false,
        ),
      ],
      currentStreak: 22,
      longestStreak: 30,
      modulePoints: {'professional': 3800},
    );
    final challenges = [
      gamif.Challenge(
        id: 'c1',
        title: 'Aider 3 personnes à décrocher un emploi',
        description: 'Aider 3 mentorés à obtenir un poste',
        pointsReward: 300,
        deadline: DateTime.now().add(const Duration(days: 5)),
        progress: 0.66,
        isCompleted: false,
        type: gamif.ChallengeType.weekly,
      ),
      gamif.Challenge(
        id: 'c2',
        title: 'Réviser 10 CV cette semaine',
        description: 'Relire et corriger 10 CV de mentorés',
        pointsReward: 150,
        deadline: DateTime.now().add(const Duration(days: 7)),
        progress: 0.7,
        isCompleted: false,
        type: gamif.ChallengeType.weekly,
      ),
      gamif.Challenge(
        id: 'c3',
        title: 'Organiser 5 simulations d\'entretien',
        description: 'Préparer 5 mentorés à l\'entretien',
        pointsReward: 200,
        deadline: DateTime.now().add(const Duration(days: 10)),
        progress: 0.4,
        isCompleted: false,
        type: gamif.ChallengeType.weekly,
      ),
    ];
    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard Mentor - Professionnel'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GamificationHeader(
              stats: stats,
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 24),
            _buildMyMenteesSection(context),
            const SizedBox(height: 24),
            _buildCVReviewSection(context),
            const SizedBox(height: 24),
            _buildJobOpportunitiesSection(context),
            const SizedBox(height: 24),
            BadgesSection(
              badges: stats.badges,
              primaryColor: primaryColor,
            ),
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

  Widget _buildMyMenteesSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people_outline, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Mes Mentorés (8)',
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
                final mentees = [
                  {
                    'name': 'Alex Dupont',
                    'status': 'En recherche',
                    'field': 'Développement',
                    'lastContact': '1j',
                  },
                  {
                    'name': 'Julie Moreau',
                    'status': 'Entretien prévu',
                    'field': 'Marketing',
                    'lastContact': '2h',
                  },
                  {
                    'name': 'Thomas Bernard',
                    'status': 'Offre reçue',
                    'field': 'Finance',
                    'lastContact': '30min',
                  },
                ];
                final mentee = mentees[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(
                      mentee['status'].toString(),
                    ),
                    child: Text(mentee['name'].toString().substring(0, 1)),
                  ),
                  title: Text(mentee['name'].toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${mentee['field']} • ${mentee['status']}'),
                      Text('Dernier contact: ${mentee['lastContact']}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCVReviewSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.description, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'CV à Réviser (5)',
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
                final cvs = [
                  {
                    'name': 'CV_Alex_Dupont.pdf',
                    'submitted': '2h',
                    'priority': 'Haute',
                  },
                  {
                    'name': 'CV_Julie_Moreau.pdf',
                    'submitted': '1j',
                    'priority': 'Moyenne',
                  },
                  {
                    'name': 'CV_Thomas_Bernard.pdf',
                    'submitted': '3j',
                    'priority': 'Basse',
                  },
                ];
                final cv = cvs[index];

                return ListTile(
                  leading: Icon(
                    Icons.picture_as_pdf,
                    color: _getPriorityColor(cv['priority'].toString()),
                  ),
                  title: Text(cv['name'].toString()),
                  subtitle: Text(
                    'Soumis il y a ${cv['submitted']} • Priorité ${cv['priority']}',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Réviser'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobOpportunitiesSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.work_outline, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Opportunités à Partager',
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
              itemCount: 2,
              itemBuilder: (context, index) {
                final jobs = [
                  {
                    'title': 'Développeur Full Stack',
                    'company': 'TechCorp',
                    'location': 'Paris',
                    'salary': '45-55k€',
                  },
                  {
                    'title': 'Chef de Projet Marketing',
                    'company': 'MarketPro',
                    'location': 'Lyon',
                    'salary': '40-50k€',
                  },
                ];
                final job = jobs[index];

                return ListTile(
                  leading: const Icon(
                    Icons.business_center,
                    color: Colors.green,
                  ),
                  title: Text(job['title'].toString()),
                  subtitle: Text(
                    '${job['company']} • ${job['location']} • ${job['salary']}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
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
                    'Mentorés',
                    '8',
                    Icons.people,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'CV Révisés',
                    '23',
                    Icons.description,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Placements',
                    '5',
                    Icons.work,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Taux Succès',
                    '85%',
                    Icons.trending_up,
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En recherche':
        return Colors.orange;
      case 'Entretien prévu':
        return Colors.blue;
      case 'Offre reçue':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Haute':
        return Colors.red;
      case 'Moyenne':
        return Colors.orange;
      case 'Basse':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
