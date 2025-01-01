import 'package:flutter/material.dart';
import '../../../../domain/models/album.dart';

enum GameStatus {
  notStarted,
  playing,
  paused,
  completed
}

class GameState {
  final GameStatus status;
  final List<String> targetAlbumIds;
  final List<int> completedRounds;
  final int currentRound;
  final String currentClue;
  final int currentClueIndex;
  final bool isHintAvailable;
  final int score;
  final int streak;
  final Duration timeRemaining;
  final Map<int, Album> guessedAlbums;  // Store user's guesses
  final Map<int, bool> correctGuesses;   // Track correct/incorrect
  final Map<int, List<String>> roundClues;  // Store clues shown for each round

  const GameState({
    this.status = GameStatus.notStarted,
    required this.targetAlbumIds,
    this.completedRounds = const [],
    this.currentRound = 0,
    this.currentClue = '',
    this.currentClueIndex = 0,
    this.isHintAvailable = true,
    this.score = 0,
    this.streak = 0,
    this.timeRemaining = const Duration(minutes: 2),
    this.guessedAlbums = const {},
    this.correctGuesses = const {},
    this.roundClues = const {},
  });

  String get currentTargetAlbumId => targetAlbumIds.isNotEmpty ? targetAlbumIds[currentRound] : '';

  bool get isPlaying => status == GameStatus.playing;
  bool get isGameOver => status == GameStatus.completed;

  GameState copyWith({
    GameStatus? status,
    List<String>? targetAlbumIds,
    List<int>? completedRounds,
    int? currentRound,
    String? currentClue,
    int? currentClueIndex,
    bool? isHintAvailable,
    int? score,
    int? streak,
    Duration? timeRemaining,
    Map<int, Album>? guessedAlbums,
    Map<int, bool>? correctGuesses,
    Map<int, List<String>>? roundClues,
  }) {
    return GameState(
      status: status ?? this.status,
      targetAlbumIds: targetAlbumIds ?? this.targetAlbumIds,
      completedRounds: completedRounds ?? this.completedRounds,
      currentRound: currentRound ?? this.currentRound,
      currentClue: currentClue ?? this.currentClue,
      currentClueIndex: currentClueIndex ?? this.currentClueIndex,
      isHintAvailable: isHintAvailable ?? this.isHintAvailable,
      score: score ?? this.score,
      streak: streak ?? this.streak,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      guessedAlbums: guessedAlbums ?? this.guessedAlbums,
      correctGuesses: correctGuesses ?? this.correctGuesses,
      roundClues: roundClues ?? this.roundClues,
    );
  }
}
