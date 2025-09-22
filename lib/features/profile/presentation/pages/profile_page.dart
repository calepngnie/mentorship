import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Éditer le profil',
            onPressed: user == null
                ? null
                : () async {
                    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                    final data = doc.data() ?? {};
                    final firstNameController = TextEditingController(text: data['firstName'] ?? '');
                    final lastNameController = TextEditingController(text: data['lastName'] ?? '');
                    final phoneController = TextEditingController(text: data['phoneNumber'] ?? user.phoneNumber ?? '');
                    final birthDateController = TextEditingController(text: data['birthDate'] ?? '');
                    final statusController = TextEditingController(text: data['status'] ?? '');
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Éditer le profil'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: firstNameController,
                                decoration: const InputDecoration(labelText: 'Prénom'),
                              ),
                              TextField(
                                controller: lastNameController,
                                decoration: const InputDecoration(labelText: 'Nom'),
                              ),
                              TextField(
                                controller: phoneController,
                                decoration: const InputDecoration(labelText: 'Téléphone'),
                              ),
                              TextField(
                                controller: birthDateController,
                                decoration: const InputDecoration(labelText: 'Date de naissance'),
                              ),
                              TextField(
                                controller: statusController,
                                decoration: const InputDecoration(labelText: 'Statut'),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Annuler'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                                'firstName': firstNameController.text,
                                'lastName': lastNameController.text,
                                'phoneNumber': phoneController.text,
                                'birthDate': birthDateController.text,
                                'status': statusController.text,
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            },
                            child: const Text('Enregistrer'),
                          ),
                        ],
                      ),
                    );
                  },
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('Aucun utilisateur connecté'))
          : FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final data = snapshot.data?.data();
                return Padding(
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
                              Text(
                                data?['firstName'] != null && data?['lastName'] != null
                                    ? '${data?['firstName']} ${data?['lastName']}'
                                    : (user.displayName ?? 'Prénom Nom'),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(user.email ?? '', style: const TextStyle(color: Colors.grey)),
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
                        subtitle: Text(data?['phoneNumber'] ?? user.phoneNumber ?? 'Non renseigné'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text('Date de naissance'),
                        subtitle: Text(data?['birthDate'] ?? 'Non renseignée'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.school),
                        title: const Text('Statut'),
                        subtitle: Text(data?['status'] ?? 'Non renseigné'),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            if (context.mounted) {
                              Navigator.of(context).pushReplacementNamed('/login');
                            }
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Se déconnecter'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
