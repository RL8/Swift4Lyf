import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_service.dart';

final scoreProvider = StateNotifierProvider<ScoreNotifier, List<Map<String, dynamic>>>(
  (ref) => ScoreNotifier(),
);

class ScoreNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final _firebase = FirebaseService();
  
  ScoreNotifier() : super([]);

  Future<void> loadTopScores() async {
    state = await _firebase.getTopScores();
  }

  Future<void> saveScore(int score) async {
    final user = await _firebase.signInAnonymously();
    if (user != null) {
      await _firebase.saveGameScore(user.user!.uid, score);
      await loadTopScores(); // Refresh scores
    }
  }
}
