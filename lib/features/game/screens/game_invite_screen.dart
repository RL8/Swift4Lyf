import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/custom_game_provider.dart';
import '../../../domain/models/game/custom_game.dart';

class GameInviteScreen extends ConsumerWidget {
  final String gameId;

  const GameInviteScreen({
    Key? key,
    required this.gameId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(activeGameProvider(gameId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Invitation'),
      ),
      body: gameAsync.when(
        data: (game) => _buildGameDetails(context, ref, game),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Widget _buildGameDetails(
    BuildContext context,
    WidgetRef ref,
    CustomGame? game,
  ) {
    if (game == null) {
      return const Center(
        child: Text('Game not found'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Difficulty: ${game.difficulty.toUpperCase()}'),
                  Text('Time Limit: ${game.timeLimit} seconds'),
                  Text('Albums: ${game.albumIds.length}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (game.isActive) ...[
            ElevatedButton(
              onPressed: () => _joinGame(context, ref, game),
              child: const Text('Join Game'),
            ),
          ] else
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'This game is no longer active',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          const SizedBox(height: 16),
          if (game.playerScores.isNotEmpty) ...[
            const Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: game.playerScores.length,
                itemBuilder: (context, index) {
                  final entry = game.playerScores.entries.elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Player ${entry.key}'),
                    trailing: Text('${entry.value} points'),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _joinGame(
    BuildContext context,
    WidgetRef ref,
    CustomGame game,
  ) async {
    // TODO: Replace with actual user ID from auth
    const userId = 'demo_user';
    
    final success = await ref
        .read(customGameProvider.notifier)
        .joinGame(game.id, userId);

    if (success) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/game',
          arguments: game,
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to join game')),
        );
      }
    }
  }
}
