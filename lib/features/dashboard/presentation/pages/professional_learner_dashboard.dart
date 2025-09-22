import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../gamification/domain/entities/gamification_entity.dart' as gamif;
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../../gamification/presentation/widgets/badges_section.dart';
import '../../../gamification/presentation/widgets/challenges_section.dart';

class ProfessionalLearnerDashboard extends StatelessWidget {
  const ProfessionalLearnerDashboard({super.key});

  gamif.GamificationStats get _mockGamificationStats => gamif.GamificationStats(
    totalPoints: 980,
    currentLevel: 6,
    pointsToNextLevel: 220,
    progressToNextLevel: 0.64,
    badges: [
      gamif.Badge(
        id: 'cv_optimizer',
        name: 'Optimiseur CV',
        description: 'Optimiser votre CV à 100%',
        iconPath: '',
        type: gamif.BadgeType.bronze,
        isEarned: true,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'interview_ace',
        name: 'As de l\'entretien',
        description: 'Réussir 5 entretiens simulés',
        iconPath: '',
        type: gamif.BadgeType.silver,
        isEarned: false,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'networking_pro',
        name: 'Pro du réseau',
        description: 'Connecter avec 50 professionnels',
        iconPath: '',
        type: gamif.BadgeType.gold,
        isEarned: false,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'job_hunter',
        name: 'Chasseur d\'emploi',
        description: 'Postuler à 20 offres d\'emploi',
        iconPath: '',
        type: gamif.BadgeType.special,
        isEarned: true,
        earnedAt: null,
      ),
    ],
    currentStreak: 8,
    longestStreak: 15,
    modulePoints: {
      'education': 0,
      'professional': 980,
      'entrepreneurship': 0,
      'personal_development': 0,
    },
  );

  List<gamif.Challenge> get _mockChallenges => [
    gamif.Challenge(
      id: 'weekly_applications',
      title: 'Candidatures de la semaine',
      description: 'Postuler à au moins 5 offres d\'emploi cette semaine',
      pointsReward: 120,
      deadline: DateTime.now().add(const Duration(days: 4)),
      progress: 0.4,
      isCompleted: false,
      type: gamif.ChallengeType.weekly,
    ),
    gamif.Challenge(
      id: 'daily_networking',
      title: 'Networking quotidien',
      description: 'Connecter avec 2 nouveaux professionnels aujourd\'hui',
      pointsReward: 30,
      deadline: DateTime.now().add(const Duration(hours: 12)),
      progress: 0.5,
      isCompleted: false,
      type: gamif.ChallengeType.daily,
    ),
    gamif.Challenge(
      id: 'interview_prep',
      title: 'Préparation entretien',
      description: 'Compléter 3 simulations d\'entretien ce mois',
      pointsReward: 200,
      deadline: DateTime.now().add(const Duration(days: 15)),
      progress: 0.33,
      isCompleted: false,
      type: gamif.ChallengeType.monthly,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professionnel - Apprenant'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GamificationHeader(
              stats: _mockGamificationStats,
              primaryColor: Colors.green[600]!,
            ),

            SizedBox(height: 24),

            // Career Progress
            Text(
              'Mon développement professionnel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildProgressCard(
                    title: 'CV optimisé',
                    value: '85%',
                    progress: 0.85,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                    title: 'Entretiens simulés',
                    value: '3/5',
                    progress: 0.6,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            BadgesSection(
              badges: _mockGamificationStats.badges,
              primaryColor: Colors.green[600]!,
            ),

            SizedBox(height: 24),

            ChallengesSection(
              challenges: _mockChallenges,
              primaryColor: Colors.green[600]!,
            ),

            SizedBox(height: 24),

            // Professional Actions
            Text(
              'Mes outils carrière',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildActionCard(
                  icon: Icons.description,
                  title: 'Mon CV',
                  subtitle: 'Optimisation',
                  color: Colors.green,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.work,
                  title: 'Offres d\'emploi',
                  subtitle: 'Recherche ciblée',
                  color: Colors.blue,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.people,
                  title: 'Networking',
                  subtitle: 'Réseau professionnel',
                  color: Colors.orange,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.psychology,
                  title: 'Entretiens',
                  subtitle: 'Préparation',
                  color: Colors.purple,
                  onTap: () {},
                ),
              ],
            ),

            SizedBox(height: 24),

            // Job Opportunities
            Text(
              'Opportunités recommandées',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            SizedBox(height: 16),

            _buildJobOpportunity(
              company: 'TechCorp',
              position: 'Développeur Full Stack',
              location: 'Paris',
              match: '95%',
            ),
            SizedBox(height: 12),
            _buildJobOpportunity(
              company: 'InnovateLab',
              position: 'Chef de Projet Digital',
              location: 'Lyon',
              match: '88%',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Emplois'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Réseau'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobOpportunity({
    required String company,
    required String position,
    required String location,
    required String match,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.work, color: Colors.green, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  company,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  '$location • Match: $match',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              match,
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
