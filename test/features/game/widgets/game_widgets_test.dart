import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/features/game/widgets/timer_display.dart';
import 'package:swift4lyf/features/game/widgets/score_display.dart';
import 'package:swift4lyf/features/game/widgets/clue_display.dart';
import 'package:swift4lyf/features/game/widgets/game_controls.dart';
import 'package:swift4lyf/features/game/state/game_providers.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';
import 'package:swift4lyf/domain/models/game/clue.dart';

void main() {
  group('Game Widgets Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameState(
            currentSession: GameSession(
              id: 'test',
              difficulty: DifficultyLevel.easy,
              selectedAlbums: const [],
              currentRound: 1,
              score: 0,
              timeRemaining: const Duration(minutes: 5),
              userAnswers: const {},
              status: GameStatus.notStarted,
              startTime: DateTime.now(),
              sessionMetadata: const {},
            ),
            revealedClues: const [],
            availableClues: const [],
          )),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('TimerDisplay shows correct time format', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: Scaffold(
              body: TimerDisplay(),
            ),
          ),
        ),
      );

      expect(find.byType(TimerDisplay), findsOneWidget);
      // Verify time format (MM:SS)
      expect(find.textContaining(RegExp(r'^\d{1,2}:\d{2}$')), findsOneWidget);
    });

    testWidgets('ScoreDisplay shows current score and round', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: Scaffold(
              body: ScoreDisplay(),
            ),
          ),
        ),
      );

      expect(find.byType(ScoreDisplay), findsOneWidget);
      expect(find.text('Score'), findsOneWidget);
      expect(find.text('Round'), findsOneWidget);
      expect(find.text('0'), findsOneWidget); // Initial score
      expect(find.text('1'), findsOneWidget); // Initial round
    });

    testWidgets('ClueDisplay shows clues correctly', (tester) async {
      final clue = Clue(
        id: 'test-clue',
        text: 'Test clue text',
        difficulty: DifficultyLevel.easy,
        category: ClueCategory.factual,
        subCategory: ClueSubCategory.releaseInfo,
        difficultyRating: 1.0,
        metadata: const {},
      );

      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameState(
            currentSession: GameSession(
              id: 'test',
              difficulty: DifficultyLevel.easy,
              selectedAlbums: const [],
              currentRound: 1,
              score: 0,
              timeRemaining: const Duration(minutes: 5),
              userAnswers: const {},
              status: GameStatus.inProgress,
              startTime: DateTime.now(),
              sessionMetadata: const {},
            ),
            revealedClues: [clue],
            availableClues: const [],
          )),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: Scaffold(
              body: ClueDisplay(),
            ),
          ),
        ),
      );

      expect(find.byType(ClueDisplay), findsOneWidget);
      expect(find.text('Test clue text'), findsOneWidget);
    });

    testWidgets('GameControls shows correct buttons based on game status', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: Scaffold(
              body: GameControls(),
            ),
          ),
        ),
      );

      expect(find.text('Start Round'), findsOneWidget);

      // Change game status to in progress
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameState(
            currentSession: GameSession(
              id: 'test',
              difficulty: DifficultyLevel.easy,
              selectedAlbums: const [],
              currentRound: 1,
              score: 0,
              timeRemaining: const Duration(minutes: 5),
              userAnswers: const {},
              status: GameStatus.inProgress,
              startTime: DateTime.now(),
              sessionMetadata: const {},
            ),
            revealedClues: const [],
            availableClues: const [
              Clue(
                id: 'test-clue',
                text: 'Test clue text',
                difficulty: DifficultyLevel.easy,
                category: ClueCategory.factual,
                subCategory: ClueSubCategory.releaseInfo,
                difficultyRating: 1.0,
                metadata: {},
              ),
            ],
          )),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: Scaffold(
              body: GameControls(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Reveal Clue'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });
  });
}
