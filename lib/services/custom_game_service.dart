import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../domain/models/game/custom_game.dart';

class CustomGameService {
  final _db = FirebaseFirestore.instance;
  
  Future<CustomGame?> createGame(CustomGame game) async {
    try {
      await _db.collection('custom_games').doc(game.id).set(game.toJson());
      return game;
    } catch (e) {
      debugPrint('Failed to create custom game: $e');
      return null;
    }
  }

  Future<CustomGame?> getGame(String gameId) async {
    try {
      final doc = await _db.collection('custom_games').doc(gameId).get();
      if (doc.exists) {
        return CustomGame.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Failed to get custom game: $e');
      return null;
    }
  }

  Future<List<CustomGame>> getUserGames(String userId) async {
    try {
      final snapshot = await _db
          .collection('custom_games')
          .where('creatorId', isEqualTo: userId)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CustomGame.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Failed to get user games: $e');
      return [];
    }
  }

  Future<bool> joinGame(String gameId, String userId) async {
    try {
      final game = await getGame(gameId);
      if (game != null && game.isActive) {
        await _db
            .collection('custom_games')
            .doc(gameId)
            .collection('players')
            .doc(userId)
            .set({
          'joinedAt': DateTime.now().toIso8601String(),
          'status': 'joined',
        });
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Failed to join game: $e');
      return false;
    }
  }

  Future<bool> submitScore(String gameId, String userId, int score) async {
    try {
      await _db.collection('custom_games').doc(gameId).update({
        'playerScores.$userId': score,
      });
      return true;
    } catch (e) {
      debugPrint('Failed to submit score: $e');
      return false;
    }
  }

  Stream<CustomGame?> watchGame(String gameId) {
    return _db
        .collection('custom_games')
        .doc(gameId)
        .snapshots()
        .map((doc) => doc.exists ? CustomGame.fromJson(doc.data()!) : null);
  }
}
