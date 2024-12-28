import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirebaseConfig {
  static String get apiKey => const String.fromEnvironment(
        'FIREBASE_API_KEY',
        defaultValue: '',
      );
  
  static String get projectId => const String.fromEnvironment(
        'FIREBASE_PROJECT_ID',
        defaultValue: '',
      );
  
  static String get authDomain => const String.fromEnvironment(
        'FIREBASE_AUTH_DOMAIN',
        defaultValue: '',
      );
  
  static String get databaseUrl => const String.fromEnvironment(
        'FIREBASE_DATABASE_URL',
        defaultValue: '',
      );
  
  static String get storageBucket => const String.fromEnvironment(
        'FIREBASE_STORAGE_BUCKET',
        defaultValue: '',
      );
}

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  bool _initialized = false;

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  Future<void> initializeFirebase() async {
    if (_initialized) return;
    
    // Validate required configuration
    assert(FirebaseConfig.apiKey.isNotEmpty, 'FIREBASE_API_KEY is required');
    assert(FirebaseConfig.projectId.isNotEmpty, 'FIREBASE_PROJECT_ID is required');
    assert(FirebaseConfig.databaseUrl.isNotEmpty, 'FIREBASE_DATABASE_URL is required');
    
    _initialized = true;
  }

  Future<dynamic> get(String path) async {
    if (!_initialized) {
      await initializeFirebase();
    }

    final url = Uri.parse('${FirebaseConfig.databaseUrl}/$path.json?key=${FirebaseConfig.apiKey}');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      
      if (response.statusCode == 401 || response.statusCode == 403) {
        debugPrint('Firebase authentication failed. Status: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        throw Exception('Authentication failed. Please check your Firebase API key.');
      }
      
      debugPrint('Firebase request failed. Status: ${response.statusCode}');
      debugPrint('Response: ${response.body}');
      throw Exception('Failed to load data');
    } catch (e) {
      debugPrint('Firebase error: $e');
      rethrow;
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> data) async {
    if (!_initialized) {
      await initializeFirebase();
    }

    final url = Uri.parse('${FirebaseConfig.databaseUrl}/$path.json?key=${FirebaseConfig.apiKey}');
    
    try {
      final response = await http.post(
        url,
        body: json.encode(data),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      
      if (response.statusCode == 401 || response.statusCode == 403) {
        debugPrint('Firebase authentication failed. Status: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        throw Exception('Authentication failed. Please check your Firebase API key.');
      }
      
      debugPrint('Firebase request failed. Status: ${response.statusCode}');
      debugPrint('Response: ${response.body}');
      throw Exception('Failed to save data');
    } catch (e) {
      debugPrint('Firebase error: $e');
      rethrow;
    }
  }
}
