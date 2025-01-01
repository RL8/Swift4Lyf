import 'package:flutter/material.dart';
import '../../domain/models/game_state.dart';
import '../../../../domain/models/album.dart';
import 'welcome_screen.dart';

class ResultsScreen extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onPlayAgain;

  const ResultsScreen({
    super.key,
    required this.gameState,
    required this.onPlayAgain,
  });

  String _normalizeAlbumId(String id) {
    final normalized = id.toLowerCase()
      .replaceAll('_tv', '')
      .replaceAll('_taylors_version', '')
      .replaceAll('_', '');
    
    switch (normalized) {
      case 'taylorswift':
        return 'ts1';
      case 'midnights3am':
        return 'midnights';
      default:
        return normalized;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Results'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: gameState.targetAlbumIds.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final reversedIndex = gameState.targetAlbumIds.length - 1 - index;
                      final targetId = gameState.targetAlbumIds[reversedIndex];
                      final targetAlbum = defaultAlbums.firstWhere(
                        (a) => _normalizeAlbumId(a.id) == _normalizeAlbumId(targetId),
                      );
                      final guessedAlbum = gameState.guessedAlbums[reversedIndex];
                      final isCorrect = gameState.correctGuesses[reversedIndex] ?? false;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '#${3 - reversedIndex}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (guessedAlbum != null)
                                guessedAlbum.buildImage(
                                  width: 60,
                                  height: 60,
                                ),
                              const SizedBox(width: 12),
                              Icon(
                                isCorrect ? Icons.check_circle : Icons.cancel,
                                color: isCorrect ? Colors.green : Colors.red,
                                size: 24,
                              ),
                              if (!isCorrect) ...[
                                const SizedBox(width: 12),
                                targetAlbum.buildImage(
                                  width: 60,
                                  height: 60,
                                ),
                              ],
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.info_outline),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Clues for #${3 - reversedIndex}'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ...(gameState.roundClues[reversedIndex] ?? []).asMap().entries.map(
                                            (entry) => Padding(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: Text('${entry.key + 1}. ${entry.value}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Back to Home'),
                      ),
                      FilledButton(
                        onPressed: onPlayAgain,
                        child: const Text('Play Again'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
