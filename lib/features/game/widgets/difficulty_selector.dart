import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/features/game/state/game_providers.dart';
import 'package:swift4lyf/domain/models/game/difficulty.dart';

class DifficultySelector extends ConsumerWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Select Difficulty',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: DifficultyLevel.values.map((difficulty) {
            return ElevatedButton(
              onPressed: () {
                ref.read(gameStateProvider.notifier).initializeSession(difficulty);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: Text(
                difficulty.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
