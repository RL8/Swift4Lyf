import 'package:flutter/material.dart';
import 'package:swift4lyf/features/album_ranking/presentation/screens/gesture_horizontal_screen.dart';
import 'package:swift4lyf/features/game/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String version = 'v28 Dec 11:12';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Swift4Lyf'),
            const Spacer(),
            Text(
              version,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Album Ranking Card
            Card(
              margin: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GestureHorizontalScreen()),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sort_rounded,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Album Ranking',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Drag and drop to create your perfect Taylor Swift album ranking',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Game Card
            Card(
              margin: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.games_rounded,
                        size: 48,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Album Guessing Game',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Test your Swiftie knowledge with our album guessing game',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
