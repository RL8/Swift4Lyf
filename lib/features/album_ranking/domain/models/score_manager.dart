class ScoreManager {
  static const int basePoints = 100;
  static const int timeBonus = 50;
  static const int streakBonus = 25;
  
  static int calculateScore({
    required bool isCorrect,
    required Duration timeRemaining,
    required int streak,
  }) {
    if (!isCorrect) return 0;
    
    int score = basePoints;
    
    // Time bonus: More points for faster answers
    if (timeRemaining.inSeconds > 90) {
      score += timeBonus;
    } else if (timeRemaining.inSeconds > 60) {
      score += (timeBonus * 0.75).round();
    } else if (timeRemaining.inSeconds > 30) {
      score += (timeBonus * 0.5).round();
    }
    
    // Streak bonus
    score += streak * streakBonus;
    
    return score;
  }
  
  static String getScoreMessage(int score) {
    if (score >= basePoints + timeBonus + (streakBonus * 2)) {
      return 'Perfect! 🌟';
    } else if (score >= basePoints + timeBonus) {
      return 'Great job! ⭐';
    } else if (score >= basePoints) {
      return 'Correct! 👍';
    } else {
      return 'Try again! 💪';
    }
  }
}
