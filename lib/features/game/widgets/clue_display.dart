import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/features/game/state/game_providers.dart';
import 'package:swift4lyf/domain/models/game/clue.dart';

class ClueDisplay extends ConsumerWidget {
  const ClueDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revealedClues = ref.watch(revealedCluesProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Clues',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ...revealedClues.map((clue) => _ClueCard(clue: clue)),
        if (revealedClues.isEmpty)
          const Center(
            child: Text('No clues revealed yet'),
          ),
      ],
    );
  }
}

class _ClueCard extends StatelessWidget {
  final Clue clue;

  const _ClueCard({required this.clue});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getCategoryColor(clue.category),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getCategoryIcon(clue.category),
                  color: _getCategoryColor(clue.category),
                ),
                const SizedBox(width: 8),
                Text(
                  clue.category.name.toUpperCase(),
                  style: TextStyle(
                    color: _getCategoryColor(clue.category),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              clue.text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(ClueCategory category) {
    switch (category) {
      case ClueCategory.lyrics:
        return Colors.purple;
      case ClueCategory.facts:
        return Colors.blue;
      case ClueCategory.trivia:
        return Colors.orange;
      case ClueCategory.production:
        return Colors.green;
      case ClueCategory.awards:
        return Colors.amber;
    }
  }

  IconData _getCategoryIcon(ClueCategory category) {
    switch (category) {
      case ClueCategory.lyrics:
        return Icons.music_note;
      case ClueCategory.facts:
        return Icons.info;
      case ClueCategory.trivia:
        return Icons.lightbulb;
      case ClueCategory.production:
        return Icons.album;
      case ClueCategory.awards:
        return Icons.star;
    }
  }
}
