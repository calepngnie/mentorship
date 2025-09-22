import '../../../../core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class ModuleLoginPage extends StatefulWidget {
  final String moduleType;
  
  const ModuleLoginPage({
    super.key,
    required this.moduleType,
  });

  @override
  State<ModuleLoginPage> createState() => _ModuleLoginPageState();
}

class _ModuleLoginPageState extends State<ModuleLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get _moduleTitle {
    switch (widget.moduleType) {
      case 'education':
        return 'Éducation';
      case 'professional':
        return 'Professionnel';
      case 'entrepreneurship':
        return 'Entrepreneuriat';
      case 'personal_development':
        return 'Développement Personnel';
      default:
        return 'Module';
    }
  }

  IconData get _moduleIcon {
    switch (widget.moduleType) {
      case 'education':
        return Icons.school;
      case 'professional':
        return Icons.work;
      case 'entrepreneurship':
        return Icons.business;
      case 'personal_development':
        return Icons.psychology;
      default:
        return Icons.apps;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion - $_moduleTitle'),
  backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            final userType = state.user.userType; // Assuming UserEntity has userType property
            if (userType == 'apprenant') {
              context.go('/dashboard/learner/${widget.moduleType}');
            } else if (userType == 'mentor') {
              context.go('/dashboard/mentor/${widget.moduleType}');
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Module icon and title
                  Icon(
                    _moduleIcon,
                    size: 80,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Module $_moduleTitle',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connectez-vous pour accéder au module $_moduleTitle',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  // Email field
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Password field
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Mot de passe',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // LinkedIn login option for professional and entrepreneurship modules
                  if (widget.moduleType == 'professional' || widget.moduleType == 'entrepreneurship') ...[
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OU'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // LinkedIn login button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          onPressed: state is AuthLoading ? null : () {
                            context.read<AuthBloc>().add(
                              LinkedInSignInRequested(moduleType: widget.moduleType),
                            );
                          },
                          icon: const Icon(Icons.business, color: Colors.white),
                          label: const Text(
                            'Continuer avec LinkedIn',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0077B5), // LinkedIn blue
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                  
                  const SizedBox(height: 24),
                  
                  // Login button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Se connecter',
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignInRequested(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Register link
                  TextButton(
                    onPressed: () => context.go('/register/${widget.moduleType}'),
                    child: const Text('Pas encore de compte ? S\'inscrire'),
                  ),
                  
                  // Back to modules
                  TextButton(
                    onPressed: () => context.go('/welcome'),
                    child: const Text('Retour aux modules'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
