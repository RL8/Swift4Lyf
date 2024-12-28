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

  static Map<String, dynamic> get firebaseConfig => {
        'apiKey': apiKey,
        'authDomain': authDomain,
        'projectId': projectId,
        'databaseURL': databaseUrl,
      };
}

class FirebaseService {
  final String baseUrl;
  
  FirebaseService() : baseUrl = FirebaseConfig.databaseUrl;
  
  Future<Map<String, dynamic>> get(String path) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$path.json?key=${FirebaseConfig.apiKey}'),
    );
    return json.decode(response.body);
  }
  
  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$path.json?key=${FirebaseConfig.apiKey}'),
      body: json.encode(data),
    );
    return json.decode(response.body);
  }
}
