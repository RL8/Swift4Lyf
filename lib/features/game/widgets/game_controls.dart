import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/features/game/state/game_providers.dart';
import 'package:swift4lyf/domain/models/game/game_session.dart';

class GameControls extends ConsumerWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStatus = ref.watch(gameStatusProvider);
    final hasAvailableClues = ref.watch(
      gameStateProvider.select((state) => state.availableClues.isNotEmpty),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (gameStatus == GameStatus.notStarted)
          ElevatedButton(
            onPressed: () {
              ref.read(gameStateProvider.notifier).startRound();
            },
            child: const Text('Start Round'),
          ),
        if (gameStatus == GameStatus.inProgress) ...[
          ElevatedButton(
            onPressed: hasAvailableClues
                ? () {
                    ref.read(gameStateProvider.notifier).revealNextClue();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child: const Text('Reveal Clue'),
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            onPressed: () {
              // Skip current round
              ref.read(gameStateProvider.notifier).endRound('');
            },
            child: const Text('Skip'),
          ),
        ],
        if (gameStatus == GameStatus.paused)
          ElevatedButton(
            onPressed: () {
              ref.read(gameStateProvider.notifier).startRound();
            },
            child: const Text('Resume'),
          ),
      ],
    );
  }
}
