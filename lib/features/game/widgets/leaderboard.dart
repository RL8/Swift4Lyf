import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/score_provider.dart';

class Leaderboard extends ConsumerWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scores = ref.watch(scoreProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Top Scores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (scores.isEmpty)
              const Center(
                child: Text('No scores yet'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  final score = scores[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Score: ${score['score']}'),
                    subtitle: Text(
                      'Player ${score['userId'].toString().substring(0, 6)}...',
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
