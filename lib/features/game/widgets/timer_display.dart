import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/features/game/state/game_providers.dart';

class TimerDisplay extends ConsumerWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeRemaining = ref.watch(gameStateProvider.select(
      (state) => state.currentSession.timeRemaining,
    ));

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer),
          const SizedBox(width: 8),
          Text(
            '${timeRemaining.inMinutes}:${(timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
