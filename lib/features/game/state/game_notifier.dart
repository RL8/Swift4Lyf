import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';
import 'package:swift4lyf/domain/models/game/album.dart';
import 'package:swift4lyf/domain/models/game/user_answer.dart';
import 'package:swift4lyf/domain/models/game/difficulty.dart';
import 'package:swift4lyf/domain/models/game/game_status.dart';
import 'package:swift4lyf/features/game/controllers/clue_manager.dart';
import 'package:swift4lyf/features/game/controllers/score_calculator.dart';
import 'package:swift4lyf/features/game/state/game_state.dart';

class GameNotifier extends StateNotifier<GameState> {
  final ClueManager clueManager;
  final ScoreCalculator scoreCalculator;

  GameNotifier({
    required this.clueManager,
    required this.scoreCalculator,
  }) : super(GameState.initial());

  void initializeSession(DifficultyLevel difficulty) {
    state = state.copyWith(
      currentSession: GameSession(
        id: DateTime.now().toIso8601String(),
        difficulty: difficulty,
        selectedAlbums: [],
        currentRound: 1,
        score: 0,
        userAnswers: {},
        status: GameStatus.notStarted,
        startTime: DateTime.now(),
      ),
      availableClues: clueManager.getCluesForDifficulty(difficulty),
      revealedClues: [],
      isLoading: false,
      error: null,
    );
  }

  Future<void> processAnswer(String selectedAlbumId, String correctAlbumId) async {
    if (!_canProcessAnswer()) return;

    final isCorrect = selectedAlbumId == correctAlbumId;
    final timeSpent = _getTimeSpentOnCurrentRound();
    final pointsEarned = isCorrect
        ? scoreCalculator.calculateScore(
            difficulty: state.currentSession.difficulty,
            timeSpent: timeSpent.inSeconds,
            cluesUsed: state.revealedClues.length,
          )
        : 0;

    final userAnswer = UserAnswer(
      albumId: selectedAlbumId,
      isCorrect: isCorrect,
      timeSpentSeconds: timeSpent.inSeconds,
      pointsEarned: pointsEarned,
      cluesUsed: state.revealedClues.map((c) => c.id).toList(),
    );

    final updatedAnswers = Map<String, UserAnswer>.from(state.currentSession.userAnswers)
      ..['${state.currentSession.currentRound}'] = userAnswer;

    state = state.copyWith(
      currentSession: state.currentSession.copyWith(
        userAnswers: updatedAnswers,
        score: state.currentSession.score + pointsEarned,
        currentRound: state.currentSession.currentRound + 1,
      ),
    );

    if (state.currentSession.currentRound > 5) {
      _completeGame();
    }
  }

  void revealNextClue() {
    if (state.currentSession.status != GameStatus.inProgress) return;
    if (state.availableClues.isEmpty) return;

    final nextClue = state.availableClues.first;
    state = state.copyWith(
      availableClues: state.availableClues.sublist(1),
      revealedClues: [...state.revealedClues, nextClue],
    );
  }

  void _completeGame() {
    state = state.copyWith(
      currentSession: state.currentSession.copyWith(
        status: GameStatus.completed,
      ),
    );
  }

  void resetGame() {
    state = GameState.initial();
  }

  bool _canProcessAnswer() {
    return state.currentSession.status == GameStatus.inProgress;
  }

  Duration _getTimeSpentOnCurrentRound() {
    return DateTime.now().difference(state.currentSession.startTime);
  }
}
