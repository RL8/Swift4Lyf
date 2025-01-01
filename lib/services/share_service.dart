import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareScore(int score) async {
    await Share.share(
      'I just scored $score points in the Taylor Swift Album Guessing Game! Can you beat my score?',
      subject: 'Check out my score!',
    );
  }

  static Future<void> shareGame(String gameId) async {
    await Share.share(
      'Join my Taylor Swift Album Guessing Game! Game ID: $gameId',
      subject: 'Join my game!',
    );
  }

  static Future<void> shareCustomGame(Map<String, dynamic> gameConfig) async {
    final gameId = gameConfig['id'];
    final difficulty = gameConfig['difficulty'];
    
    await Share.share(
      'I created a custom Taylor Swift Album Guessing Game!\n'
      'Difficulty: $difficulty\n'
      'Game ID: $gameId\n'
      'Join now and test your Taylor Swift knowledge!',
      subject: 'Join my custom game!',
    );
  }
}
