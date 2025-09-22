import 'package:flutter/material.dart';

class ModuleSelectionPage extends StatelessWidget {
  const ModuleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir un Module'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Sélection des modules - À implémenter',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
