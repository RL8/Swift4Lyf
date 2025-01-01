import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift4lyf/features/game/state/game_state.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';

class GamePersistence {
  static const String _gameStateKey = 'game_state';
  static const String _sessionHistoryKey = 'session_history';

  // Save current game state
  static Future<void> saveGameState(GameState state) async {
    final prefs = await SharedPreferences.getInstance();
    final stateJson = _gameStateToJson(state);
    await prefs.setString(_gameStateKey, jsonEncode(stateJson));
  }

  // Load saved game state
  static Future<GameState?> loadGameState() async {
    final prefs = await SharedPreferences.getInstance();
    final stateString = prefs.getString(_gameStateKey);
    if (stateString == null) return null;

    try {
      final stateJson = jsonDecode(stateString) as Map<String, dynamic>;
      return _gameStateFromJson(stateJson);
    } catch (e) {
      // If there's an error loading the state, return null
      return null;
    }
  }

  // Save completed session to history
  static Future<void> saveSessionToHistory(GameSession session) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await loadSessionHistory();
    history.add(session);

    // Keep only last 50 sessions
    if (history.length > 50) {
      history.removeAt(0);
    }

    final historyJson = history.map((s) => s.toJson()).toList();
    await prefs.setString(_sessionHistoryKey, jsonEncode(historyJson));
  }

  // Load session history
  static Future<List<GameSession>> loadSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString(_sessionHistoryKey);
    if (historyString == null) return [];

    try {
      final historyJson = jsonDecode(historyString) as List;
      return historyJson
          .map((json) => GameSession.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Clear all saved game data
  static Future<void> clearAllGameData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_gameStateKey);
    await prefs.remove(_sessionHistoryKey);
  }

  // Private helper methods for JSON conversion
  static Map<String, dynamic> _gameStateToJson(GameState state) {
    return {
      'currentSession': state.currentSession.toJson(),
      'availableClues': state.availableClues.map((c) => c.toJson()).toList(),
      'revealedClues': state.revealedClues.map((c) => c.toJson()).toList(),
      'isLoading': state.isLoading,
      'error': state.error,
      'cachedData': state.cachedData,
    };
  }

  static GameState _gameStateFromJson(Map<String, dynamic> json) {
    return GameState(
      currentSession: GameSession.fromJson(json['currentSession'] as Map<String, dynamic>),
      availableClues: (json['availableClues'] as List)
          .map((c) => Clue.fromJson(c as Map<String, dynamic>))
          .toList(),
      revealedClues: (json['revealedClues'] as List)
          .map((c) => Clue.fromJson(c as Map<String, dynamic>))
          .toList(),
      isLoading: json['isLoading'] as bool,
      error: json['error'] as String?,
      cachedData: json['cachedData'] as Map<String, dynamic>,
    );
  }
}
