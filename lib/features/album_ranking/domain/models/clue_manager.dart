class Clue {
  final String text;
  final String albumId;
  final int points;

  const Clue({
    required this.text,
    required this.albumId,
    this.points = 100,
  });
}

class ClueManager {
  static final Map<String, List<Clue>> _albumClues = {
    'ts1': [
      Clue(
        text: "This album features songs about high school romance",
        albumId: 'ts1',
      ),
      Clue(
        text: "Released in 2006, it's her debut studio album",
        albumId: 'ts1',
      ),
    ],
    'fearless': [
      Clue(
        text: "This album won Album of the Year at the 52nd Grammy Awards",
        albumId: 'fearless',
      ),
      Clue(
        text: "Features the song 'Love Story'",
        albumId: 'fearless',
      ),
    ],
    'speaknow': [
      Clue(
        text: "Every song on this album was written solely by Taylor",
        albumId: 'speaknow',
      ),
      Clue(
        text: "Features the song 'Mean', which won two Grammy Awards",
        albumId: 'speaknow',
      ),
    ],
    'red': [
      Clue(
        text: "Features a collaboration with Ed Sheeran",
        albumId: 'red',
      ),
      Clue(
        text: "Includes a song about a scarf that was never returned",
        albumId: 'red',
      ),
    ],
    '1989': [
      Clue(
        text: "Named after the artist's birth year",
        albumId: '1989',
      ),
      Clue(
        text: "Features 'Shake It Off' and 'Blank Space'",
        albumId: '1989',
      ),
    ],
    'reputation': [
      Clue(
        text: "The album's marketing featured snake imagery",
        albumId: 'reputation',
      ),
      Clue(
        text: "Includes 'Look What You Made Me Do'",
        albumId: 'reputation',
      ),
    ],
    'lover': [
      Clue(
        text: "Features pastel colors and a romantic theme",
        albumId: 'lover',
      ),
      Clue(
        text: "Includes a collaboration with the Dixie Chicks",
        albumId: 'lover',
      ),
    ],
    'folklore': [
      Clue(
        text: "A surprise album released during the pandemic",
        albumId: 'folklore',
      ),
      Clue(
        text: "Features a fictional love triangle in its storytelling",
        albumId: 'folklore',
      ),
    ],
    'evermore': [
      Clue(
        text: "The sister album to folklore",
        albumId: 'evermore',
      ),
      Clue(
        text: "Features 'willow' as its lead single",
        albumId: 'evermore',
      ),
    ],
    'midnights': [
      Clue(
        text: "Described as 'the stories of 13 sleepless nights'",
        albumId: 'midnights',
      ),
      Clue(
        text: "Features 'Anti-Hero' as its lead single",
        albumId: 'midnights',
      ),
    ],
  };

  static Clue getClueForAlbum(String albumId, int clueIndex) {
    final clues = _albumClues[albumId] ?? [];
    if (clues.isEmpty) {
      return Clue(
        text: "No clue available for this album",
        albumId: albumId,
        points: 0,
      );
    }
    return clues[clueIndex % clues.length];
  }

  static List<String> getRandomAlbumIds(int count) {
    final allIds = _albumClues.keys.toList()..shuffle();
    return allIds.take(count).toList();
  }
}
