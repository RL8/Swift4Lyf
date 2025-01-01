import 'package:swift4lyf/features/game/state/game_state.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';

class StateOptimizer {
  // Minimize state updates by comparing changes
  static bool shouldUpdateState(GameState oldState, GameState newState) {
    // Quick reference equality check
    if (identical(oldState, newState)) return false;

    // Check only relevant fields for game progress
    if (_hasSignificantChanges(oldState, newState)) {
      return true;
    }

    // Avoid updates for non-essential changes
    return false;
  }

  // Optimize state size for persistence
  static GameState optimizeForStorage(GameState state) {
    return state.copyWith(
      // Clear non-essential cached data
      cachedData: _filterCachedData(state.cachedData),
      // Keep only necessary clues
      availableClues: state.availableClues.take(5).toList(),
    );
  }

  // Private helper methods
  static bool _hasSignificantChanges(GameState oldState, GameState newState) {
    // Check game status change
    if (oldState.currentSession.status != newState.currentSession.status) {
      return true;
    }

    // Check score change
    if (oldState.currentSession.score != newState.currentSession.score) {
      return true;
    }

    // Check round change
    if (oldState.currentSession.currentRound != newState.currentSession.currentRound) {
      return true;
    }

    // Check revealed clues change
    if (oldState.revealedClues.length != newState.revealedClues.length) {
      return true;
    }

    // Check significant time change (more than 1 second)
    final oldTime = oldState.currentSession.timeRemaining;
    final newTime = newState.currentSession.timeRemaining;
    if ((oldTime - newTime).abs() > const Duration(seconds: 1)) {
      return true;
    }

    return false;
  }

  static Map<String, dynamic> _filterCachedData(Map<String, dynamic> cachedData) {
    // Keep only essential cached data
    return Map.fromEntries(
      cachedData.entries.where((entry) => _isEssentialCacheKey(entry.key))
    );
  }

  static bool _isEssentialCacheKey(String key) {
    const essentialKeys = {
      'lastScore',
      'highScore',
      'currentStreak',
      'selectedAlbums',
    };
    return essentialKeys.contains(key);
  }

  // Memory optimization
  static void cleanupMemory(GameState state) {
    // Clear non-essential caches
    state.cachedData.removeWhere(
      (key, _) => !_isEssentialCacheKey(key)
    );
  }
}
