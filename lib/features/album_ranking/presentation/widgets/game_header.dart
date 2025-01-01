import 'package:flutter/material.dart';
import '../../domain/models/game_state.dart';

class GameHeader extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onExit;
  final VoidCallback onStart;

  const GameHeader({
    super.key,
    required this.gameState,
    required this.onExit,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Timer
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _formatDuration(gameState.timeRemaining),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              // Score
              Text(
                'Score: ${gameState.score}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Exit Button
              IconButton(
                onPressed: onExit,
                icon: const Icon(Icons.close),
                tooltip: 'Exit Game',
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Round Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final isCompleted = gameState.completedRounds.contains(index);
              final isCurrent = gameState.currentRound == index;
              return Container(
                width: 24,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Theme.of(context).colorScheme.primary
                      : isCurrent
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          if (gameState.status == GameStatus.notStarted)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Start Game'),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
