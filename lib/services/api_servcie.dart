import 'package:dio/dio.dart';

class ApiService {
  // Adresse IP du PC qui héberge le backend (à adapter si elle change)
  static const String ipAddress = "192.168.8.37";
  static const int port = 3001;

  final Dio _dio = Dio(); // instance de Dio

  String? bearerToken = ""; // token à intégrer pour l'authentification

  ApiService() {
    _initialize();
  }

  // Initialisation de Dio
  void _initialize() {
    final String baseUrl = "http://$ipAddress:$port/api";

    _dio.options.baseUrl = baseUrl;
    // Évite que l'app reste bloquée si le serveur est injoignable
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _setHeaders();
  }

  // Définir l'entête des requêtes Dio
  void _setHeaders() {
    _dio.options.headers = {
      "Accept": "application/json",
      if (bearerToken != null && bearerToken!.isNotEmpty)
        "Authorization": "Bearer $bearerToken",
    };
  }

  // Connexion
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      Response response = await _dio.post('/login', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200 && response.data['token'] != null) {
        bearerToken = response.data['token'];
        _setHeaders();
        return response.data;
      }
    } catch (e) {
      // print("⚠️ Erreur lors de la connexion : $e");
    }
    return null;
  }

  // Enregistrement
  Future<Map<String, dynamic>?> register(
      String name, String email, String password) async {
    try {
      Response response = await _dio.post('/register', data: {
        "name": name,
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      }
    } catch (e) {
      // print("⚠️ Erreur lors de l'enregistrement : $e");
    }
    return null;
  }

  // Déconnexion
  Future<void> logout() async {
    try {
      await _dio.post('/logout');
    } catch (e) {
      // print("⚠️ Erreur lors de la déconnexion : $e");
    } finally {
      // Dans tous les cas, on oublie le token localement
      bearerToken = null;
      _setHeaders();
    }
  }

  // Profil utilisateur
  //Future<User?> getUserProfile();
  //Future<void> updateUserProfile(User updatedUser);
}