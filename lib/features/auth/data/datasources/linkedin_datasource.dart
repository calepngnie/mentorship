import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LinkedInDataSource {
  Future<Map<String, dynamic>> authenticateWithLinkedIn();
  Future<Map<String, dynamic>> getLinkedInProfile(String accessToken);
}

class LinkedInDataSourceImpl implements LinkedInDataSource {
  final http.Client client;

  // LinkedIn OAuth 2.0 configuration
  static const String _clientId =
      'YOUR_LINKEDIN_CLIENT_ID'; // À remplacer par votre client ID
  static const String _clientSecret =
      'YOUR_LINKEDIN_CLIENT_SECRET'; // À remplacer par votre client secret
  static const String _redirectUri =
      'YOUR_REDIRECT_URI'; // À remplacer par votre redirect URI
  static const String _scope = 'r_liteprofile r_emailaddress';

  LinkedInDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> authenticateWithLinkedIn() async {
    try {
      // Cette méthode devrait ouvrir un WebView ou navigateur pour l'authentification LinkedIn
      // Pour la démo, nous simulons une réponse d'authentification réussie

      // Dans une vraie implémentation, vous utiliseriez un package comme flutter_web_auth
      // ou oauth2 pour gérer le flux OAuth complet

      // Simulation d'une réponse d'authentification LinkedIn
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simule le temps d'authentification

      return {
        'access_token':
            'simulated_access_token_${DateTime.now().millisecondsSinceEpoch}',
        'expires_in': 5184000, // 60 jours
        'scope': _scope,
      };
    } catch (e) {
      throw Exception('Erreur d\'authentification LinkedIn: $e');
    }
  }

  // Méthode complète d'authentification OAuth LinkedIn
  Future<String?> authenticateWithLinkedInOAuth() async {
    try {
      final String authUrl =
          'https://www.linkedin.com/oauth/v2/authorization?'
          'response_type=code&'
          'client_id=$_clientId&'
          'redirect_uri=$_redirectUri&'
          'scope=${Uri.encodeComponent(_scope)}&'
          'state=linkedin_${DateTime.now().millisecondsSinceEpoch}';

      // Ouvre le navigateur pour l'authentification
      final result = await FlutterWebAuth.authenticate(
        url: authUrl,
        callbackUrlScheme: Uri.parse(_redirectUri).scheme,
      );
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) {
        throw Exception('Code d\'autorisation LinkedIn manquant');
      }

      // Échange le code contre un accessToken
      final tokenResponse = await client.post(
        Uri.parse('https://www.linkedin.com/oauth/v2/accessToken'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': _redirectUri,
          'client_id': _clientId,
          'client_secret': _clientSecret,
        },
      );
      if (tokenResponse.statusCode != 200) {
        throw Exception('Erreur lors de l\'échange du code: '
            '${tokenResponse.body}');
      }
      final tokenData = json.decode(tokenResponse.body);
      final accessToken = tokenData['access_token'] as String?;
      if (accessToken == null) {
        throw Exception('AccessToken LinkedIn manquant');
      }
      return accessToken;
    } catch (e) {
      throw Exception('Erreur OAuth LinkedIn: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getLinkedInProfile(String accessToken) async {
    try {
      // Simulation d'un profil LinkedIn
      // Dans une vraie implémentation, vous feriez des appels API réels à LinkedIn

      await Future.delayed(const Duration(seconds: 1)); // Simule l'appel API

      // Profil simulé basé sur l'API LinkedIn
      return {
        'id': 'linkedin_user_${DateTime.now().millisecondsSinceEpoch}',
        'firstName': {
          'localized': {'fr_FR': 'Jean'},
          'preferredLocale': {'country': 'FR', 'language': 'fr'},
        },
        'lastName': {
          'localized': {'fr_FR': 'Dupont'},
          'preferredLocale': {'country': 'FR', 'language': 'fr'},
        },
        'profilePicture': {'displayImage': 'https://via.placeholder.com/150'},
        'emailAddress': 'jean.dupont@example.com',
        'headline': {
          'localized': {'fr_FR': 'Développeur Senior chez TechCorp'},
          'preferredLocale': {'country': 'FR', 'language': 'fr'},
        },
        'industry': {
          'localized': {'fr_FR': 'Technologies de l\'information'},
          'preferredLocale': {'country': 'FR', 'language': 'fr'},
        },
        'location': {
          'localized': {'fr_FR': 'Paris, France'},
          'preferredLocale': {'country': 'FR', 'language': 'fr'},
        },
        'positions': {
          'elements': [
            {
              'title': {
                'localized': {'fr_FR': 'Développeur Senior'},
                'preferredLocale': {'country': 'FR', 'language': 'fr'},
              },
              'companyName': {
                'localized': {'fr_FR': 'TechCorp'},
                'preferredLocale': {'country': 'FR', 'language': 'fr'},
              },
              'description': {
                'localized': {
                  'fr_FR': 'Développement d\'applications mobiles et web',
                },
                'preferredLocale': {'country': 'FR', 'language': 'fr'},
              },
            },
          ],
        },
        'skills': {
          'elements': [
            {
              'name': {
                'localized': {'fr_FR': 'Flutter'},
              },
            },
            {
              'name': {
                'localized': {'fr_FR': 'React'},
              },
            },
            {
              'name': {
                'localized': {'fr_FR': 'Node.js'},
              },
            },
            {
              'name': {
                'localized': {'fr_FR': 'Python'},
              },
            },
          ],
        },
      };
    } catch (e) {
      throw Exception('Erreur lors de la récupération du profil LinkedIn: $e');
    }
  }

  // Méthode utilitaire pour extraire les informations du profil LinkedIn
  static Map<String, dynamic> extractProfileData(
    Map<String, dynamic> linkedInProfile,
  ) {
    try {
      final firstName =
          linkedInProfile['firstName']?['localized']?['fr_FR'] ??
          linkedInProfile['firstName']?['localized']?.values?.first ??
          '';
      final lastName =
          linkedInProfile['lastName']?['localized']?['fr_FR'] ??
          linkedInProfile['lastName']?['localized']?.values?.first ??
          '';

      final headline =
          linkedInProfile['headline']?['localized']?['fr_FR'] ??
          linkedInProfile['headline']?['localized']?.values?.first ??
          '';

      final location =
          linkedInProfile['location']?['localized']?['fr_FR'] ??
          linkedInProfile['location']?['localized']?.values?.first ??
          '';

      final industry =
          linkedInProfile['industry']?['localized']?['fr_FR'] ??
          linkedInProfile['industry']?['localized']?.values?.first ??
          '';

      // Extraction des compétences
      final skills = <String>[];
      final skillsElements = linkedInProfile['skills']?['elements'] as List?;
      if (skillsElements != null) {
        for (final skill in skillsElements) {
          final skillName =
              skill['name']?['localized']?['fr_FR'] ??
              skill['name']?['localized']?.values?.first;
          if (skillName != null) {
            skills.add(skillName);
          }
        }
      }

      // Extraction de l'expérience professionnelle
      final experiences = <Map<String, String>>[];
      final positionsElements =
          linkedInProfile['positions']?['elements'] as List?;
      if (positionsElements != null) {
        for (final position in positionsElements) {
          final title =
              position['title']?['localized']?['fr_FR'] ??
              position['title']?['localized']?.values?.first ??
              '';
          final company =
              position['companyName']?['localized']?['fr_FR'] ??
              position['companyName']?['localized']?.values?.first ??
              '';
          final description =
              position['description']?['localized']?['fr_FR'] ??
              position['description']?['localized']?.values?.first ??
              '';

          experiences.add({
            'title': title,
            'company': company,
            'description': description,
          });
        }
      }

      return {
        'name': '$firstName $lastName'.trim(),
        'email': linkedInProfile['emailAddress'] ?? '',
        'headline': headline,
        'location': location,
        'industry': industry,
        'skills': skills,
        'experiences': experiences,
        'profilePicture':
            linkedInProfile['profilePicture']?['displayImage'] ?? '',
        'linkedinId': linkedInProfile['id'] ?? '',
      };
    } catch (e) {
      throw Exception('Erreur lors de l\'extraction des données du profil: $e');
    }
  }

  // Méthode pour connecter à Firebase avec un customToken obtenu via ton backend/Cloud Function
  Future<UserCredential> signInWithFirebaseCustomToken(String firebaseCustomToken) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithCustomToken(firebaseCustomToken);
      return userCredential;
    } catch (e) {
      throw Exception('Erreur lors de la connexion Firebase: $e');
    }
  }
}
