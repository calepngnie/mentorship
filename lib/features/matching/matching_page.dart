import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:math' show max;
import 'mentor_profile_card.dart';

class MatchingPage extends StatefulWidget {
  final List<double> userFeatures;
  const MatchingPage({Key? key, required this.userFeatures}) : super(key: key);

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  Interpreter? _interpreter;
  int? _mentorId;
  double? _matchScore;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    setState(() {
      _loading = true;
      _error = null;
      _mentorId = null;
    });
    try {
      // Try the most likely asset name first, then a common alternate.
      // Some artifacts or notebooks export the model as "mentor_recommender.tflite",
      // while the asset bundled here is named "mentor_recommen.tflite".
      // Attempt both so the app is resilient to naming mismatches during testing.
      try {
        _interpreter = await Interpreter.fromAsset('mentor_recommen.tflite');
      } catch (e1) {
        // First name failed, try the alternative full name
        try {
          _interpreter = await Interpreter.fromAsset(
            'mentor_recommender.tflite',
          );
        } catch (e2) {
          // Both attempts failed -> throw combined error so outer catch shows it
          throw Exception(
            'Impossible de charger les assets suivants: "mentor_recommen.tflite" '
            '(err: $e1), "mentor_recommender.tflite" (err: $e2)',
          );
        }
      }
      await _predictMentor();
    } catch (e) {
      setState(
        () => _error =
            'Erreur lors du chargement du modèle : $e\n\n'
            'Vérifiez que le fichier TFLite est présent dans assets/ et déclaré dans pubspec.yaml. '
            'Nom recommandé du fichier : "mentor_recommender.tflite".',
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _predictMentor() async {
    if (_interpreter == null) {
      setState(() => _error = 'Modèle non initialisé');
      return;
    }

    try {
      // Normalisation des caractéristiques utilisateur
      final normalizedFeatures = widget.userFeatures
          .map((f) => f / 100.0)
          .toList();

      // Préparation de l'entrée avec la bonne forme
      var input = [normalizedFeatures];

      // Préparation de la sortie
      var output = List.filled(
        1 * 3,
        0.0,
      ).reshape([1, 3]); // [1, 3] pour les 3 meilleurs matchs

      // Exécution de la prédiction
      _interpreter!.run(input, output);

      // Traitement des résultats
      final predictions = output[0];
      final bestMatch = predictions.indexOf(predictions.reduce(max));

      setState(() {
        _mentorId = bestMatch;
        _matchScore = predictions[bestMatch];
      });

      print(
        'Prédiction effectuée : Score de correspondance = ${(_matchScore! * 100).toStringAsFixed(1)}%',
      );
    } catch (e) {
      setState(() => _error = 'Erreur lors de la prédiction : $e');
      print('Erreur de prédiction : $e');
    }
    // Optionnel : vous pouvez logger la prédiction ici
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche de mentor')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48),
                  SizedBox(height: 16),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _loadModel,
                    icon: Icon(Icons.refresh),
                    label: Text('Relancer la recherche'),
                  ),
                ],
              )
            : _mentorId != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MentorProfileCard(
                    mentorId: _mentorId!,
                    onContact: () {
                      // TODO: ouvrir la messagerie ou le profil détaillé
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Fonctionnalité à venir : contacter le mentor.',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    label: const Text('Retour'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, color: Colors.grey, size: 48),
                  SizedBox(height: 16),
                  Text('Aucun mentor trouvé.'),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _loadModel,
                    icon: Icon(Icons.refresh),
                    label: Text('Relancer la recherche'),
                  ),
                ],
              ),
      ),
    );
  }
}
