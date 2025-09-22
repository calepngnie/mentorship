import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../gamification/domain/entities/gamification_entity.dart' as gamif;
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../../gamification/presentation/widgets/badges_section.dart';
import '../../../gamification/presentation/widgets/challenges_section.dart';

class EntrepreneurshipLearnerDashboard extends StatelessWidget {
  const EntrepreneurshipLearnerDashboard({super.key});

  gamif.GamificationStats get _mockGamificationStats => const gamif.GamificationStats(
    totalPoints: 1450,
    currentLevel: 9,
    pointsToNextLevel: 550,
    progressToNextLevel: 0.45,
    badges: [
      gamif.Badge(
        id: 'idea_generator',
        name: 'Générateur d\'idées',
        description: 'Développer votre première idée d\'entreprise',
        iconPath: '',
        type: gamif.BadgeType.bronze,
        isEarned: true,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'business_planner',
        name: 'Planificateur',
        description: 'Compléter un business plan',
        iconPath: '',
        type: gamif.BadgeType.silver,
        isEarned: true,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'funding_seeker',
        name: 'Chercheur de fonds',
        description: 'Postuler à 5 financements',
        iconPath: '',
        type: gamif.BadgeType.gold,
        isEarned: false,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'startup_founder',
        name: 'Fondateur',
        description: 'Lancer officiellement votre startup',
        iconPath: '',
        type: gamif.BadgeType.platinum,
        isEarned: false,
        earnedAt: null,
      ),
    ],
    currentStreak: 18,
    longestStreak: 25,
    modulePoints: {
      'education': 0,
      'professional': 0,
      'entrepreneurship': 1450,
      'personal_development': 0,
    },
  );

  List<gamif.Challenge> get _mockChallenges => [
    gamif.Challenge(
      id: 'business_plan_section',
      title: 'Section business plan',
      description: 'Compléter une section de votre business plan cette semaine',
      pointsReward: 150,
      deadline: DateTime.now().add(const Duration(days: 5)),
      progress: 0.7,
      isCompleted: false,
      type: gamif.ChallengeType.weekly,
    ),
    gamif.Challenge(
      id: 'market_research',
      title: 'Étude de marché quotidienne',
      description: 'Analyser 3 concurrents aujourd\'hui',
      pointsReward: 40,
      deadline: DateTime.now().add(const Duration(hours: 10)),
      progress: 0.33,
      isCompleted: false,
      type: gamif.ChallengeType.daily,
    ),
    gamif.Challenge(
      id: 'funding_applications',
      title: 'Candidatures financement',
      description: 'Postuler à 3 opportunités de financement ce mois',
      pointsReward: 300,
      deadline: DateTime.now().add(const Duration(days: 20)),
      progress: 0.66,
      isCompleted: false,
      type: gamif.ChallengeType.monthly,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrepreneuriat - Apprenant'),
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
              primaryColor: Colors.orange[600]!,
            ),

            SizedBox(height: 24),

            // Business Progress
            Text(
              'Mon projet entrepreneurial',
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
                    title: 'Business Plan',
                    value: '60%',
                    progress: 0.6,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                    title: 'Financement',
                    value: '25%',
                    progress: 0.25,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            BadgesSection(
              badges: _mockGamificationStats.badges,
              primaryColor: Colors.orange[600]!,
            ),

            SizedBox(height: 24),

            ChallengesSection(
              challenges: _mockChallenges,
              primaryColor: Colors.orange[600]!,
            ),

            SizedBox(height: 24),

            // Entrepreneurship Actions
            Text(
              'Mes outils entrepreneur',
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
                  icon: Icons.lightbulb,
                  title: 'Mon idée',
                  subtitle: 'Développement',
                  color: Colors.yellow[700]!,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.business_center,
                  title: 'Business Plan',
                  subtitle: 'Création',
                  color: Colors.orange,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.monetization_on,
                  title: 'Financement',
                  subtitle: 'Recherche',
                  color: Colors.green,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.people,
                  title: 'Équipe',
                  subtitle: 'Recrutement',
                  color: Colors.blue,
                  onTap: () {},
                ),
              ],
            ),

            SizedBox(height: 24),

            // Funding Opportunities
            Text(
              'Opportunités de financement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            SizedBox(height: 16),

            _buildFundingOpportunity(
              name: 'Concours Innovation 2024',
              amount: '50 000€',
              deadline: '15 Mars 2024',
              type: 'Concours',
            ),
            SizedBox(height: 12),
            _buildFundingOpportunity(
              name: 'Bourse French Tech',
              amount: '25 000€',
              deadline: '30 Mars 2024',
              type: 'Subvention',
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
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Projet'),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Financement',
          ),
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

  Widget _buildFundingOpportunity({
    required String name,
    required String amount,
    required String deadline,
    required String type,
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
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.monetization_on, color: Colors.orange, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Montant: $amount',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  'Échéance: $deadline',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              type,
              style: TextStyle(
                color: Colors.orange,
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
