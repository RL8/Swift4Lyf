import 'package:flutter_test/flutter_test.dart';
import 'package:swift4lyf/features/game/utils/asset_loader.dart';
import 'package:swift4lyf/features/game/utils/clue_selector.dart';
import 'package:swift4lyf/features/game/utils/state_optimizer.dart';
import 'package:swift4lyf/features/game/state/game_state.dart';
import 'package:swift4lyf/domain/models/game/clue.dart';
import 'package:swift4lyf/domain/models/album.dart';

void main() {
  group('Performance Optimizations', () {
    test('AssetLoader caches images correctly', () async {
      final album = Album(
        id: 'test-album',
        name: 'Test Album',
        imageUrl: 'assets/test.jpg',
        releaseYear: 2020,
        color: const Color(0xFF000000),
        releaseSequence: 1,
      );

      // First load should cache
      final image1 = await AssetLoader.loadAlbumImage(album);
      // Second load should use cache
      final image2 = await AssetLoader.loadAlbumImage(album);

      expect(identical(image1, image2), isTrue);
    });

    test('ClueSelector optimizes clue selection', () {
      final clues = List.generate(
        10,
        (i) => Clue(
          id: 'clue-$i',
          text: 'Test Clue $i',
          difficulty: DifficultyLevel.easy,
          category: ClueCategory.factual,
          subCategory: ClueSubCategory.releaseInfo,
          difficultyRating: 1.0,
          metadata: {},
        ),
      );

      final selected1 = ClueSelector.selectOptimalClues(
        albumId: 'test-album',
        availableClues: clues,
        difficulty: DifficultyLevel.easy,
        count: 3,
      );

      // Second selection should use cache
      final selected2 = ClueSelector.selectOptimalClues(
        albumId: 'test-album',
        availableClues: clues,
        difficulty: DifficultyLevel.easy,
        count: 3,
      );

      expect(selected1, equals(selected2));
    });

    test('StateOptimizer prevents unnecessary updates', () {
      final baseState = GameState.initial();
      
      // Same state should not update
      expect(
        StateOptimizer.shouldUpdateState(baseState, baseState),
        isFalse,
      );

      // Minor cached data change should not update
      final minorChange = baseState.copyWith(
        cachedData: {'newKey': 'value'},
      );
      expect(
        StateOptimizer.shouldUpdateState(baseState, minorChange),
        isFalse,
      );

      // Significant change should update
      final majorChange = baseState.copyWith(
        currentSession: baseState.currentSession.copyWith(
          score: 100,
        ),
      );
      expect(
        StateOptimizer.shouldUpdateState(baseState, majorChange),
        isTrue,
      );
    });
  });
}
