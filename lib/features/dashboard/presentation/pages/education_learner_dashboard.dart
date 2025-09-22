import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../gamification/domain/entities/gamification_entity.dart' as gamif;
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../../gamification/presentation/widgets/badges_section.dart';
import '../../../gamification/presentation/widgets/challenges_section.dart';

class EducationLearnerDashboard extends StatelessWidget {
  const EducationLearnerDashboard({super.key});

  gamif.GamificationStats get _mockGamificationStats => gamif.GamificationStats(
    totalPoints: 1250,
    currentLevel: 8,
    pointsToNextLevel: 350,
    progressToNextLevel: 0.72,
    badges: [
      gamif.Badge(
        id: 'first_course',
        name: 'Premier cours',
        description: 'Terminer votre premier cours',
        iconPath: '',
        type: gamif.BadgeType.bronze,
        isEarned: true,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'homework_master',
        name: 'Maître des devoirs',
        description: 'Rendre 10 devoirs à temps',
        iconPath: '',
        type: gamif.BadgeType.silver,
        isEarned: true,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'perfect_score',
        name: 'Score parfait',
        description: 'Obtenir 20/20 à un examen',
        iconPath: '',
        type: gamif.BadgeType.gold,
        isEarned: false,
        earnedAt: null,
      ),
      gamif.Badge(
        id: 'study_streak',
        name: 'Étudiant assidu',
        description: 'Étudier 30 jours consécutifs',
        iconPath: '',
        type: gamif.BadgeType.special,
        isEarned: false,
        earnedAt: null,
      ),
    ],
    currentStreak: 12,
    longestStreak: 28,
    modulePoints: {
      'education': 1250,
      'professional': 0,
      'entrepreneurship': 0,
      'personal_development': 0,
    },
  );

  List<gamif.Challenge> get _mockChallenges => [
    gamif.Challenge(
      id: 'weekly_homework',
      title: 'Devoirs de la semaine',
      description: 'Terminer tous les devoirs assignés cette semaine',
      pointsReward: 100,
      deadline: DateTime.now().add(const Duration(days: 3)),
      progress: 0.6,
      isCompleted: false,
      type: gamif.ChallengeType.weekly,
    ),
    gamif.Challenge(
      id: 'daily_study',
      title: 'Session d\'étude quotidienne',
      description: 'Étudier au moins 1 heure aujourd\'hui',
      pointsReward: 25,
      deadline: DateTime.now().add(const Duration(hours: 8)),
      progress: 0.8,
      isCompleted: false,
      type: gamif.ChallengeType.daily,
    ),
    gamif.Challenge(
      id: 'quiz_master',
      title: 'Maître des quiz',
      description: 'Réussir 5 quiz avec plus de 80%',
      pointsReward: 150,
      deadline: DateTime.now().add(const Duration(days: 7)),
      progress: 0.4,
      isCompleted: false,
      type: gamif.ChallengeType.weekly,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Éducation - Apprenant'),
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
              primaryColor: Colors.blue[600]!,
            ),

            SizedBox(height: 24),

            // Progress Overview
            Text(
              'Mon parcours',
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
                    title: 'Cours suivis',
                    value: '8/12',
                    progress: 0.67,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                    title: 'Devoirs rendus',
                    value: '15/18',
                    progress: 0.83,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            BadgesSection(
              badges: _mockGamificationStats.badges,
              primaryColor: Colors.blue[600]!,
            ),

            SizedBox(height: 24),

            ChallengesSection(
              challenges: _mockChallenges,
              primaryColor: Colors.blue[600]!,
            ),

            SizedBox(height: 24),

            // Education Specific Actions
            Text(
              'Mes activités',
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
                  icon: Icons.book,
                  title: 'Mes cours',
                  subtitle: 'Contenus pédagogiques',
                  color: Colors.blue,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.assignment,
                  title: 'Devoirs',
                  subtitle: 'À rendre',
                  color: Colors.orange,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.quiz,
                  title: 'Évaluations',
                  subtitle: 'Tests et examens',
                  color: Colors.red,
                  onTap: () {},
                ),
                _buildActionCard(
                  icon: Icons.school,
                  title: 'Tutoriels',
                  subtitle: 'Aide personnalisée',
                  color: Colors.purple,
                  onTap: () {},
                ),
              ],
            ),

            SizedBox(height: 24),

            // Upcoming Classes
            Text(
              'Prochains cours',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            SizedBox(height: 16),

            _buildUpcomingClass(
              subject: 'Mathématiques',
              mentor: 'Dr. Martin Dubois',
              time: 'Aujourd\'hui 14:00',
              duration: '1h30',
            ),
            SizedBox(height: 12),
            _buildUpcomingClass(
              subject: 'Physique',
              mentor: 'Prof. Sarah Laurent',
              time: 'Demain 10:00',
              duration: '2h00',
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
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Cours'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Devoirs',
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

  Widget _buildUpcomingClass({
    required String subject,
    required String mentor,
    required String time,
    required String duration,
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
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.school, color: Colors.blue, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  mentor,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  '$time • $duration',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
        ],
      ),
    );
  }
}
