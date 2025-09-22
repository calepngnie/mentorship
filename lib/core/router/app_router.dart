import '../../features/profile/presentation/pages/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/module_login_page.dart';
import '../../features/auth/presentation/pages/module_register_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/modules/presentation/pages/module_selection_page.dart';
import '../../features/dashboard/presentation/pages/learner_dashboard.dart';
import '../../features/dashboard/presentation/pages/mentor_dashboard.dart';
import '../../features/dashboard/presentation/pages/education_learner_dashboard.dart';
import '../../features/dashboard/presentation/pages/professional_mentor_dashboard.dart';
import '../../features/dashboard/presentation/pages/education_mentor_dashboard.dart';
import '../../features/dashboard/presentation/pages/professional_learner_dashboard.dart';
import '../../features/dashboard/presentation/pages/personal_development_learner_dashboard.dart';
import '../../features/dashboard/presentation/pages/entrepreneurship_learner_dashboard.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/login/:moduleType',
        builder: (context, state) {
          final moduleType = state.pathParameters['moduleType']!;
          return ModuleLoginPage(moduleType: moduleType);
        },
      ),
      GoRoute(
        path: '/register/:moduleType',
        builder: (context, state) {
          final moduleType = state.pathParameters['moduleType']!;
          return ModuleRegisterPage(moduleType: moduleType);
        },
      ),
      GoRoute(
        path: '/modules',
        builder: (context, state) => const ModuleSelectionPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/dashboard/learner/:moduleType',
        builder: (context, state) {
          final moduleType = state.pathParameters['moduleType']!;
          return LearnerDashboard(module: moduleType);
        },
      ),
      GoRoute(
        path: '/dashboard/mentor/:moduleType',
        builder: (context, state) {
          final moduleType = state.pathParameters['moduleType']!;
          return MentorDashboard(module: moduleType);
        },
      ),
      GoRoute(
        path: '/dashboard/education-learner',
        builder: (context, state) => const EducationLearnerDashboard(),
      ),
      GoRoute(
        path: '/dashboard/professional-mentor',
        builder: (context, state) => const ProfessionalMentorDashboard(),
      ),
      GoRoute(
        path: '/dashboard/education-mentor',
        builder: (context, state) => const EducationMentorDashboard(),
      ),
      GoRoute(
        path: '/dashboard/professional-learner',
        builder: (context, state) => const ProfessionalLearnerDashboard(),
      ),
      GoRoute(
        path: '/dashboard/personal-development-learner',
        builder: (context, state) => const PersonalDevelopmentLearnerDashboard(),
      ),
      GoRoute(
        path: '/dashboard/entrepreneurship-learner',
        builder: (context, state) => const EntrepreneurshipLearnerDashboard(),
      ),
      GoRoute(
        path: '/dashboard/:role/:module',
        builder: (context, state) {
          final role = state.pathParameters['role']!;
          final module = state.pathParameters['module']!;
          switch (role) {
            case 'mentor':
              switch (module) {
                case 'professional':
                  return const ProfessionalMentorDashboard();
                case 'education':
                  return const EducationMentorDashboard();
                default:
                  return const MentorDashboard(module: 'default');
              }
            case 'learner':
              switch (module) {
                case 'professional':
                  return const ProfessionalLearnerDashboard();
                case 'education':
                  return const EducationLearnerDashboard();
                case 'personal-development':
                  return const PersonalDevelopmentLearnerDashboard();
                case 'entrepreneurship':
                  return const EntrepreneurshipLearnerDashboard();
                default:
                  return const LearnerDashboard(module: 'default');
              }
            default:
              return const HomePage();
          }
        },
      ),
      GoRoute(
        path: '/profile/complete/:moduleType/:userType',
        builder: (context, state) {
          final moduleType = state.pathParameters['moduleType']!;
          final userType = state.pathParameters['userType']!;
          return ProfileCompletionPage(
            moduleType: moduleType,
            userType: userType,
          );
        },
      ),
    ],
  );
}


class ProfileCompletionPage extends StatelessWidget {
  final String moduleType;
  final String userType;

  const ProfileCompletionPage({
    super.key,
    required this.moduleType,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    // Exemple de récupération de données utilisateur fictives
    final user = {
      'firstName': 'Jean',
      'lastName': 'Dupont',
      'email': 'jean.dupont@email.com',
      'phone': '+33 6 12 34 56 78',
      'birthDate': '01/01/2000',
      'status': userType == 'mentor' ? 'Mentor' : 'Apprenant',
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compléter le profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user['firstName']} ${user['lastName']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(user['email']!, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Informations personnelles', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Téléphone'),
              subtitle: Text(user['phone']!),
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Date de naissance'),
              subtitle: Text(user['birthDate']!),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Statut'),
              subtitle: Text(user['status']!),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implémenter la sauvegarde ou la validation du profil
                },
                icon: const Icon(Icons.check),
                label: const Text('Valider le profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
