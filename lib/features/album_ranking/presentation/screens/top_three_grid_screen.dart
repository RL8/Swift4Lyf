import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../domain/models/album.dart';
import '../../domain/models/game_state.dart';
import '../../domain/models/clue_manager.dart';
import '../../domain/models/score_manager.dart';
import 'welcome_screen.dart';
import 'results_screen.dart';
import 'dart:async';

class TopThreeGridScreen extends StatefulWidget {
  const TopThreeGridScreen({super.key});

  @override
  State<TopThreeGridScreen> createState() => _TopThreeGridScreenState();
}

class _TopThreeGridScreenState extends State<TopThreeGridScreen> with SingleTickerProviderStateMixin {
  late List<Album?> topThreeAlbums;
  late List<Album> unrankedAlbums;
  Album? draggedAlbum;
  late GameState gameState;
  Timer? gameTimer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _initializeGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _initializeGame() {
    topThreeAlbums = List.filled(3, null);
    unrankedAlbums = List.from(defaultAlbums)
      ..sort((a, b) => a.releaseSequence.compareTo(b.releaseSequence));
    
    final targetAlbums = ClueManager.getRandomAlbumIds(3);
    print('DEBUG: Initial target albums: $targetAlbums');
    
    gameState = GameState(
      targetAlbumIds: targetAlbums,
      currentClue: '',
      roundClues: {},
    );
  }

  void _startGame() {
    final firstClue = ClueManager.getClueForAlbum(
      gameState.currentTargetAlbumId,
      gameState.currentClueIndex,
    );
    
    setState(() {
      gameState = gameState.copyWith(
        status: GameStatus.playing,
        currentClue: firstClue.text,
        roundClues: {0: [firstClue.text]},
      );
    });
    _startTimer();
  }

  void _startTimer() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (gameState.timeRemaining.inSeconds > 0) {
          gameState = gameState.copyWith(
            timeRemaining: gameState.timeRemaining - const Duration(seconds: 1),
          );
        } else {
          _endGame();
        }
      });
    });
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Widget _buildGameHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _exitGame,
            icon: const Icon(Icons.close),
          ),
          Text(
            _formatTime(gameState.timeRemaining),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (gameState.isPlaying && gameState.isHintAvailable)
            IconButton(
              onPressed: _showHint,
              icon: const Icon(Icons.lightbulb_outline),
            )
          else
            const SizedBox(width: 48), // Placeholder for layout balance
        ],
      ),
    );
  }

  Widget _buildClueSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            gameState.currentClue,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildDropZone() {
    final currentPosition = 2 - gameState.currentRound;
    final droppedAlbum = topThreeAlbums[currentPosition];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DragTarget<Album>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (droppedAlbum != null) ...[
                  droppedAlbum.buildImage(
                    width: 100,
                    height: 100,
                  ),
                ] else ...[
                  Icon(
                    Icons.add_circle_outline,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Drop Album Here',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        onWillAccept: (album) => true,
        onAccept: (album) {
          setState(() {
            topThreeAlbums[2 - gameState.currentRound] = album;
          });
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    if (!gameState.isPlaying) return const SizedBox.shrink();
    
    final position = 2 - gameState.currentRound;
    final hasAlbum = topThreeAlbums[position] != null;

    return AnimatedOpacity(
      opacity: hasAlbum ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          onPressed: hasAlbum ? _handleSubmit : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 48,
              vertical: 16,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text(
            'Submit Answer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 32) / 3;
          final itemHeight = itemWidth;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: itemHeight,
            ),
            itemCount: unrankedAlbums.length,
            itemBuilder: (context, index) {
              if (index >= unrankedAlbums.length) return const SizedBox();
              final album = unrankedAlbums[index];
              final isUsed = topThreeAlbums.contains(album);
              return _buildAlbumTile(album, isDragging: isUsed);
            },
          );
        },
      ),
    );
  }

  Widget _buildAlbumTile(Album album, {bool isDragging = false}) {
    return Draggable<Album>(
      data: album,
      feedback: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: album.buildImage(
          width: 100,
          height: 100,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
          child: album.buildImage(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDragging
                ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: album.buildImage(),
      ),
    );
  }

  void _handleDragStart(Album album) {
    setState(() {
      draggedAlbum = album;
    });
    HapticFeedback.vibrate();
  }

  void _handleDragEnd(_) {
    setState(() {
      draggedAlbum = null;
    });
  }

  void _showHint() {
    if (!gameState.isPlaying || !gameState.isHintAvailable) return;

    final nextClue = ClueManager.getClueForAlbum(
      gameState.currentTargetAlbumId,
      gameState.currentClueIndex + 1,
    );

    setState(() {
      final currentRoundClues = List<String>.from(
        gameState.roundClues[gameState.currentRound] ?? []
      )..add(nextClue.text);

      gameState = gameState.copyWith(
        currentClue: nextClue.text,
        currentClueIndex: gameState.currentClueIndex + 1,
        isHintAvailable: false,
        roundClues: {
          ...gameState.roundClues,
          gameState.currentRound: currentRoundClues,
        },
      );
    });
    HapticFeedback.lightImpact();
  }

  void _endGame() {
    gameTimer?.cancel();
    _showResultsScreen();
  }

  void _handleSubmit() async {
    final currentPosition = 2 - gameState.currentRound;
    final selectedAlbum = topThreeAlbums[currentPosition];
    
    if (selectedAlbum == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an album first'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final isCorrect = _normalizeAlbumId(selectedAlbum.id) == 
                     _normalizeAlbumId(gameState.currentTargetAlbumId);

    setState(() {
      final newCompletedRounds = List<int>.from(gameState.completedRounds)
        ..add(gameState.currentRound);
      
      final nextRound = gameState.currentRound + 1;
      final isGameOver = nextRound >= 3;
      
      final nextClue = !isGameOver ? ClueManager.getClueForAlbum(
        gameState.targetAlbumIds[nextRound],
        0,
      ) : null;

      gameState = gameState.copyWith(
        completedRounds: newCompletedRounds,
        currentRound: nextRound,
        currentClue: nextClue?.text ?? '',
        currentClueIndex: 0,
        isHintAvailable: true,
        guessedAlbums: {
          ...gameState.guessedAlbums,
          currentPosition: selectedAlbum,
        },
        correctGuesses: {
          ...gameState.correctGuesses,
          currentPosition: isCorrect,
        },
        roundClues: isGameOver ? gameState.roundClues : {
          ...gameState.roundClues,
          nextRound: [nextClue!.text],
        },
        status: isGameOver ? GameStatus.completed : GameStatus.playing,
      );
    });

    if (gameState.isGameOver) {
      _showResultsScreen();
    }
  }

  void _showResultsScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          gameState: gameState,
          onPlayAgain: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const TopThreeGridScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  void _exitGame() {
    gameTimer?.cancel();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
      (route) => false, // Remove all routes from stack
    );
  }

  void _updateGameState(GameState newState) {
    setState(() {
      gameState = newState;
    });
    _animationController.forward(from: 0);
  }

  String _normalizeAlbumId(String id) {
    // Convert IDs to lowercase and remove special characters
    final normalized = id.toLowerCase()
      .replaceAll('_tv', '')  // Remove TV suffix
      .replaceAll('_taylors_version', '')  // Remove Taylor's Version suffix
      .replaceAll('_', '');  // Remove underscores
    
    // Handle special cases
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            return Column(
              children: [
                SizedBox(
                  height: availableHeight * 0.08,
                  child: _buildGameHeader(),
                ),
                
                if (gameState.status == GameStatus.notStarted)
                  Expanded(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _startGame,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text(
                          'Start Game',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: availableHeight * 0.92,
                    child: Column(
                      children: [
                        // Clue Section (10% of height)
                        SizedBox(
                          height: availableHeight * 0.1,
                          child: _buildClueSection(),
                        ),
                        
                        // Drop Zone (20% of height - reduced from 30%)
                        SizedBox(
                          height: availableHeight * 0.2,
                          child: _buildDropZone(),
                        ),
                        
                        // Submit Button (5% of height)
                        SizedBox(
                          height: availableHeight * 0.05,
                          child: _buildSubmitButton(),
                        ),
                        
                        // Album Grid (57% of height - increased from 42%)
                        SizedBox(
                          height: availableHeight * 0.57,
                          child: _buildAlbumGrid(),
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
