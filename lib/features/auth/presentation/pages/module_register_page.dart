import '../../../../core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class ModuleRegisterPage extends StatefulWidget {
  final String moduleType;
  
  const ModuleRegisterPage({
    super.key,
    required this.moduleType,
  });

  @override
  State<ModuleRegisterPage> createState() => _ModuleRegisterPageState();
}

class _ModuleRegisterPageState extends State<ModuleRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String _userType = 'apprenant'; // Default to apprenant
  bool _acceptedTerms = false;

  String get _moduleTitle {
    switch (widget.moduleType) {
      case 'Éducation':
        return 'Éducation';
      case 'Professionnel':
        return 'Professionnel';
      case 'Entrepreneuriat':
        return 'Entrepreneuriat';
      case 'Développement Personnel':
        return 'Développement Personnel';
      default:
        return 'Module';
    }
  }

  IconData get _moduleIcon {
    switch (widget.moduleType) {
      case 'Éducation':
        return Icons.school;
      case 'Professionnel':
        return Icons.work;
      case 'Entrepreneuriat':
        return Icons.business;
      case 'Développement Personnel':
        return Icons.psychology;
      default:
        return Icons.apps;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription - $_moduleTitle'),
  backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistrationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.go('/login/${widget.moduleType}');
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Module icon and title
                    Icon(
                      _moduleIcon,
                      size: 60,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Inscription - $_moduleTitle',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    
                    // LinkedIn registration option for professional and entrepreneurship modules
                    if (widget.moduleType == 'professional' || widget.moduleType == 'entrepreneurship') ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.business,
                              size: 40,
                              color: const Color(0xFF0077B5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Inscription rapide avec LinkedIn',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0077B5),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Importez automatiquement vos informations professionnelles',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return ElevatedButton.icon(
                                  onPressed: state is AuthLoading ? null : () {
                                    context.read<AuthBloc>().add(
                                      LinkedInSignUpRequested(
                                        moduleType: widget.moduleType,
                                        userType: _userType,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.business, color: Colors.white),
                                  label: const Text(
                                    'S\'inscrire avec LinkedIn',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0077B5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('OU INSCRIPTION MANUELLE'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                    
                    // User type selection
                    Text(
                      'Je suis :',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Apprenant'),
                            subtitle: const Text('Je cherche un mentor'),
                            value: 'apprenant',
                            groupValue: _userType,
                            onChanged: (value) {
                              setState(() {
                                _userType = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Mentor'),
                            subtitle: const Text('Je veux aider'),
                            value: 'mentor',
                            groupValue: _userType,
                            onChanged: (value) {
                              setState(() {
                                _userType = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Name field
                    CustomTextField(
                      controller: _nameController,
                      label: 'Nom complet',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
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
                    
                    // Phone field
                    CustomTextField(
                      controller: _phoneController,
                      label: 'Numéro de téléphone',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre numéro';
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
                          return 'Veuillez entrer un mot de passe';
                        }
                        if (value.length < 6) {
                          return 'Le mot de passe doit contenir au moins 6 caractères';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Confirm password field
                    CustomTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirmer le mot de passe',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez confirmer votre mot de passe';
                        }
                        if (value != _passwordController.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    // Terms and conditions
                    CheckboxListTile(
                      title: const Text(
                        'J\'accepte les conditions d\'utilisation et la politique de confidentialité (RGPD)',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: _acceptedTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptedTerms = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 24),
                    
                    // Register button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: 'S\'inscrire',
                          isLoading: state is AuthLoading,
                          onPressed: _acceptedTerms ? () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                SignUpRequested(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                  firstName: _nameController.text.trim().split(' ').first,
                                  lastName: _nameController.text.trim().split(' ').skip(1).join(' '),
                                  phone: _phoneController.text.trim(),
                                  userType: _userType,
                                  module: widget.moduleType,
                                ),
                              );
                            }
                          } : null,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Login link
                    TextButton(
                      onPressed: () => context.go('/login/${widget.moduleType}'),
                      child: const Text('Déjà un compte ? Se connecter'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
