import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';
import 'package:swift4lyf/domain/models/game/clue.dart';
import 'package:swift4lyf/domain/models/game/difficulty.dart';
import 'package:swift4lyf/domain/models/game/game_status.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required GameSession currentSession,
    required List<Clue> availableClues,
    required List<Clue> revealedClues,
    required bool isLoading,
    required String? error,
    required Map<String, dynamic> cachedData,
  }) = _GameState;

  factory GameState.initial() => GameState(
    currentSession: GameSession(
      id: '',
      difficulty: DifficultyLevel.easy,
      selectedAlbums: [],
      currentRound: 0,
      score: 0,
      userAnswers: {},
      status: GameStatus.notStarted,
      startTime: DateTime.now(),
    ),
    availableClues: [],
    revealedClues: [],
    isLoading: false,
    error: null,
    cachedData: {},
  );
}
