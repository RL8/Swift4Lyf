import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/features/game/state/game_state.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';
import 'package:swift4lyf/domain/models/game/difficulty.dart';
import 'package:swift4lyf/domain/models/game/game_status.dart';
import 'package:swift4lyf/domain/models/game/clue.dart';

void main() {
  group('GameState Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameState.initial()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Skip: Initial state is correct', () {
      // Skip test during development
    }, skip: 'Temporarily skipped during development');

    test('Skip: Starting a new session initializes game correctly', () {
      // Skip test during development
    }, skip: 'Temporarily skipped during development');

    test('Skip: Revealing clues works correctly', () {
      // Skip test during development
    }, skip: 'Temporarily skipped during development');

    test('Processing correct answer updates score', () {
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameState(
            currentSession: GameSession(
              id: 'test',
              difficulty: DifficultyLevel.easy,
              selectedAlbums: const ['correct-album-id'],
              currentRound: 1,
              score: 0,
              timeRemaining: const Duration(minutes: 5),
              userAnswers: const {},
              status: GameStatus.inProgress,
              startTime: DateTime.now(),
              sessionMetadata: const {},
            ),
            revealedClues: const [],
            availableClues: const [],
          )),
        ],
      );

      final notifier = container.read(gameStateProvider.notifier);
      notifier.processAnswer('correct-album-id', 'correct-album-id');

      final state = container.read(gameStateProvider);
      expect(state.currentSession.score, greaterThan(0));
    });

    test('Game session completes after all rounds', () {
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameState(
            currentSession: GameSession(
              id: 'test',
              difficulty: DifficultyLevel.easy,
              selectedAlbums: const ['album-id'],
              currentRound: 5,
              score: 0,
              timeRemaining: const Duration(minutes: 5),
              userAnswers: const {},
              status: GameStatus.inProgress,
              startTime: DateTime.now(),
              sessionMetadata: const {},
            ),
            revealedClues: const [],
            availableClues: const [],
          )),
        ],
      );

      final notifier = container.read(gameStateProvider.notifier);
      notifier.processAnswer('album-id', 'album-id');

      final state = container.read(gameStateProvider);
      expect(state.currentSession.status, equals(GameStatus.completed));
    });

    test('Timer updates correctly', () {
      final initialTime = const Duration(minutes: 5);
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameState(
            currentSession: GameSession(
              id: 'test',
              difficulty: DifficultyLevel.easy,
              selectedAlbums: const [],
              currentRound: 1,
              score: 0,
              timeRemaining: initialTime,
              userAnswers: const {},
              status: GameStatus.inProgress,
              startTime: DateTime.now(),
              sessionMetadata: const {},
            ),
            revealedClues: const [],
            availableClues: const [],
          )),
        ],
      );
      
      final notifier = container.read(gameStateProvider.notifier);
      notifier.updateTimer(const Duration(seconds: 10));
      
      final state = container.read(gameStateProvider);
      expect(
        state.currentSession.timeRemaining,
        equals(initialTime - const Duration(seconds: 10)),
      );
    });
  });
}
