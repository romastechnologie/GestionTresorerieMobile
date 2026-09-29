import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {

  final _storage = const FlutterSecureStorage();

  // Enregistrer le token
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  // Lire le token
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Supprimer le token
  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }

  // Vider le stockage  si nécessaire
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
