import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/domain/models/game/game_status.dart';
import 'package:swift4lyf/features/game/controllers/clue_manager.dart';
import 'package:swift4lyf/features/game/controllers/score_calculator.dart';
import 'package:swift4lyf/features/game/state/game_notifier.dart';
import 'package:swift4lyf/features/game/state/game_state.dart';

// Controllers
final clueManagerProvider = Provider<ClueManager>((ref) => ClueManager());
final scoreCalculatorProvider = Provider<ScoreCalculator>((ref) => ScoreCalculator());

// Game State
final gameStateProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(
    clueManager: ref.watch(clueManagerProvider),
    scoreCalculator: ref.watch(scoreCalculatorProvider),
  );
});

// Derived States
final gameStatusProvider = Provider<GameStatus>((ref) {
  return ref.watch(gameStateProvider).currentSession.status;
});

final gameScoreProvider = Provider<int>((ref) {
  return ref.watch(gameStateProvider).currentSession.score;
});

final currentRoundProvider = Provider<int>((ref) {
  return ref.watch(gameStateProvider).currentSession.currentRound;
});

final availableCluesProvider = Provider((ref) {
  return ref.watch(gameStateProvider).availableClues;
});

final revealedCluesProvider = Provider((ref) {
  return ref.watch(gameStateProvider).revealedClues;
});
