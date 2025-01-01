import 'package:swift4lyf/domain/models/game/clue.dart';
import 'package:collection/collection.dart';

class ClueSelector {
  // Cache for optimized clue selection
  static final Map<String, List<Clue>> _albumClueCache = {};
  static final Map<String, DateTime> _cacheTimestamp = {};
  static const Duration _cacheDuration = Duration(minutes: 30);

  // Efficient clue selection with caching
  static List<Clue> selectOptimalClues({
    required String albumId,
    required List<Clue> availableClues,
    required DifficultyLevel difficulty,
    required int count,
    List<String> excludeIds = const [],
  }) {
    // Check cache validity
    if (_isValidCache(albumId)) {
      final cachedClues = _albumClueCache[albumId]!;
      return _filterCachedClues(cachedClues, count, excludeIds);
    }

    // Sort clues by difficulty and category distribution
    final sortedClues = _sortCluesByOptimality(availableClues, difficulty);
    
    // Update cache
    _albumClueCache[albumId] = sortedClues;
    _cacheTimestamp[albumId] = DateTime.now();

    return _filterCachedClues(sortedClues, count, excludeIds);
  }

  // Private helper methods
  static bool _isValidCache(String albumId) {
    if (!_albumClueCache.containsKey(albumId)) return false;
    
    final timestamp = _cacheTimestamp[albumId];
    if (timestamp == null) return false;

    return DateTime.now().difference(timestamp) < _cacheDuration;
  }

  static List<Clue> _filterCachedClues(
    List<Clue> clues,
    int count,
    List<String> excludeIds,
  ) {
    return clues
        .where((clue) => !excludeIds.contains(clue.id))
        .take(count)
        .toList();
  }

  static List<Clue> _sortCluesByOptimality(
    List<Clue> clues,
    DifficultyLevel targetDifficulty,
  ) {
    return clues.sorted((a, b) {
      // Primary sort by difficulty match
      final diffA = _difficultyMatch(a.difficulty, targetDifficulty);
      final diffB = _difficultyMatch(b.difficulty, targetDifficulty);
      if (diffA != diffB) return diffB.compareTo(diffA);

      // Secondary sort by category priority
      final catA = _categoryPriority(a.category);
      final catB = _categoryPriority(b.category);
      return catA.compareTo(catB);
    });
  }

  static double _difficultyMatch(
    DifficultyLevel clueLevel,
    DifficultyLevel targetLevel,
  ) {
    if (clueLevel == targetLevel) return 1.0;
    
    final diffMap = {
      DifficultyLevel.easy: 0,
      DifficultyLevel.hard: 1,
      DifficultyLevel.beast: 2,
    };

    final diff = (diffMap[clueLevel]! - diffMap[targetLevel]!).abs();
    return 1.0 / (1 + diff);
  }

  static int _categoryPriority(ClueCategory category) {
    switch (category) {
      case ClueCategory.factual:
        return 0;
      case ClueCategory.musical:
        return 1;
      case ClueCategory.contextual:
        return 2;
      case ClueCategory.special:
        return 3;
    }
  }

  // Cache management
  static void clearCache() {
    _albumClueCache.clear();
    _cacheTimestamp.clear();
  }

  static void removeFromCache(String albumId) {
    _albumClueCache.remove(albumId);
    _cacheTimestamp.remove(albumId);
  }
}
