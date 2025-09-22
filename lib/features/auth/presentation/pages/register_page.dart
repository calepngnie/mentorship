import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomTextField(
                label: 'Prénom',
                controller: firstNameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez entrer votre prénom'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nom',
                controller: lastNameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez entrer votre nom'
                    : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Téléphone',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez entrer votre numéro de téléphone'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Mot de passe',
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Veuillez entrer un mot de passe';
                  if (value.length < 6)
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // TODO: Envoyer les données au bloc ou à l'API
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Inscription réussie (simulation)'),
                      ),
                    );
                  }
                },
                child: const Text('S’inscrire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
