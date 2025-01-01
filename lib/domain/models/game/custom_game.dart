import 'package:cloud_firestore/cloud_firestore.dart';

class CustomGame {
  final String id;
  final String creatorId;
  final String title;
  final String difficulty;
  final List<String> albumIds;
  final int timeLimit;
  final bool isActive;
  final DateTime createdAt;
  final Map<String, int> playerScores;

  CustomGame({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.difficulty,
    required this.albumIds,
    required this.timeLimit,
    required this.isActive,
    required this.createdAt,
    required this.playerScores,
  });

  factory CustomGame.create({
    required String creatorId,
    required String title,
    required String difficulty,
    required List<String> albumIds,
    required int timeLimit,
  }) {
    return CustomGame(
      id: FirebaseFirestore.instance.collection('custom_games').doc().id,
      creatorId: creatorId,
      title: title,
      difficulty: difficulty,
      albumIds: albumIds,
      timeLimit: timeLimit,
      isActive: true,
      createdAt: DateTime.now(),
      playerScores: {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'title': title,
      'difficulty': difficulty,
      'albumIds': albumIds,
      'timeLimit': timeLimit,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'playerScores': playerScores,
    };
  }

  factory CustomGame.fromJson(Map<String, dynamic> json) {
    return CustomGame(
      id: json['id'] as String,
      creatorId: json['creatorId'] as String,
      title: json['title'] as String,
      difficulty: json['difficulty'] as String,
      albumIds: List<String>.from(json['albumIds']),
      timeLimit: json['timeLimit'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      playerScores: Map<String, int>.from(json['playerScores'] as Map),
    );
  }
}
