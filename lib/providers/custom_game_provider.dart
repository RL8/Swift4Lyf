import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/game/custom_game.dart';
import '../services/custom_game_service.dart';

final customGameServiceProvider = Provider((ref) => CustomGameService());

final userGamesProvider = StreamProvider.family<List<CustomGame>, String>(
  (ref, userId) async* {
    final games = await ref.read(customGameServiceProvider).getUserGames(userId);
    yield games;
  },
);

final activeGameProvider = StreamProvider.family<CustomGame?, String>(
  (ref, gameId) {
    return ref.read(customGameServiceProvider).watchGame(gameId);
  },
);

final customGameProvider =
    StateNotifierProvider<CustomGameNotifier, AsyncValue<CustomGame?>>(
  (ref) => CustomGameNotifier(ref.read(customGameServiceProvider)),
);

class CustomGameNotifier extends StateNotifier<AsyncValue<CustomGame?>> {
  final CustomGameService _service;

  CustomGameNotifier(this._service) : super(const AsyncValue.data(null));

  Future<bool> createGame(CustomGame game) async {
    state = const AsyncValue.loading();
    try {
      final createdGame = await _service.createGame(game);
      state = AsyncValue.data(createdGame);
      return createdGame != null;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> joinGame(String gameId, String userId) async {
    try {
      return await _service.joinGame(gameId, userId);
    } catch (e) {
      return false;
    }
  }

  Future<bool> submitScore(String gameId, String userId, int score) async {
    try {
      return await _service.submitScore(gameId, userId, score);
    } catch (e) {
      return false;
    }
  }
}
