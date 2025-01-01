import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/features/game/screens/welcome_screen.dart';
import 'package:swift4lyf/features/game/screens/game_screen.dart';
import 'package:swift4lyf/features/game/screens/result_screen.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';
import 'package:swift4lyf/domain/models/game/difficulty.dart';
import 'package:swift4lyf/domain/models/game/game_status.dart';
import 'package:swift4lyf/features/game/state/game_providers.dart';
import 'package:swift4lyf/features/game/widgets/timer_display.dart';
import 'package:swift4lyf/features/game/widgets/score_display.dart';
import 'package:swift4lyf/features/game/widgets/clue_display.dart';
import 'package:swift4lyf/features/game/widgets/game_controls.dart';

void main() {
  group('Game Screens Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameNotifier(
            clueManager: ref.watch(clueManagerProvider),
            scoreCalculator: ref.watch(scoreCalculatorProvider),
          )..initializeSession(DifficultyLevel.easy)),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('WelcomeScreen shows difficulty selection', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: WelcomeScreen(),
          ),
        ),
      );

      expect(find.text('Taylor Swift Album Game'), findsOneWidget);
      expect(find.text('Select Difficulty'), findsOneWidget);
      
      // Verify all difficulty options are present
      expect(find.text('EASY'), findsOneWidget);
      expect(find.text('HARD'), findsOneWidget);
      expect(find.text('BEAST'), findsOneWidget);
    });

    testWidgets('Skip: GameScreen shows all game components', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: GameScreen(),
          ),
        ),
      );

      // Verify all major components are present
      expect(find.byType(TimerDisplay), findsOneWidget);
      expect(find.byType(ScoreDisplay), findsOneWidget);
      expect(find.byType(ClueDisplay), findsOneWidget);
      expect(find.byType(GameControls), findsOneWidget);
    }, skip: 'Temporarily skipped during development');

    testWidgets('ResultScreen shows game summary', (tester) async {
      container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith((ref) => GameNotifier(
            clueManager: ref.watch(clueManagerProvider),
            scoreCalculator: ref.watch(scoreCalculatorProvider),
          )..initializeSession(DifficultyLevel.easy)),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: ResultScreen(),
          ),
        ),
      );

      // Verify result components
      expect(find.text('Game Complete!'), findsOneWidget);
      expect(find.text('Final Score'), findsOneWidget);
      expect(find.text('1000'), findsOneWidget);
      expect(find.text('Game Statistics'), findsOneWidget);
      expect(find.text('Play Again'), findsOneWidget);
    });
  });
}
