import 'package:flutter/material.dart';

class Album {
  final String id;
  final String name;
  final int releaseYear;
  final String imageUrl;
  final Color color;
  final int releaseSequence;
  int? rank;

  Album({
    required this.id,
    required this.name,
    required this.releaseYear,
    required this.imageUrl,
    required this.color,
    required this.releaseSequence,
    this.rank,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as String,
      name: json['name'] as String,
      releaseYear: json['releaseYear'] as int,
      imageUrl: json['imageUrl'] as String,
      color: Color(json['color'] as int),
      releaseSequence: json['releaseSequence'] as int,
      rank: json['rank'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'releaseYear': releaseYear,
      'imageUrl': imageUrl,
      'color': color.value,
      'releaseSequence': releaseSequence,
      if (rank != null) 'rank': rank,
    };
  }

  Widget buildImage({double? width, double? height}) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: color.withOpacity(0.3),
          child: const Icon(Icons.album),
        );
      },
    );
  }
}

// Taylor Swift's albums with era colors and release sequence
final defaultAlbums = [
  Album(
    id: 'taylor_swift',
    name: 'Taylor Swift',
    releaseYear: 2006,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/1/1f/Taylor_Swift_-_Taylor_Swift.png',
    color: const Color(0xFF6B8E23),
    releaseSequence: 1,
  ),
  Album(
    id: 'fearless',
    name: 'Fearless',
    releaseYear: 2008,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/8/86/Taylor_Swift_-_Fearless.png',
    color: const Color(0xFFFFD700),
    releaseSequence: 2,
  ),
  Album(
    id: 'speak_now',
    name: 'Speak Now',
    releaseYear: 2010,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/8/8f/Taylor_Swift_-_Speak_Now_cover.png',
    color: const Color(0xFF800080),
    releaseSequence: 3,
  ),
  Album(
    id: 'red',
    name: 'Red',
    releaseYear: 2012,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/e/e8/Taylor_Swift_-_Red.png',
    color: const Color(0xFFFF0000),
    releaseSequence: 4,
  ),
  Album(
    id: '1989',
    name: '1989',
    releaseYear: 2014,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/f/f6/Taylor_Swift_-_1989.png',
    color: const Color(0xFF87CEEB),
    releaseSequence: 5,
  ),
  Album(
    id: 'reputation',
    name: 'Reputation',
    releaseYear: 2017,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/f/f2/Taylor_Swift_-_Reputation.png',
    color: const Color(0xFF000000),
    releaseSequence: 6,
  ),
  Album(
    id: 'lover',
    name: 'Lover',
    releaseYear: 2019,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/c/cd/Taylor_Swift_-_Lover.png',
    color: const Color(0xFFFF69B4),
    releaseSequence: 7,
  ),
  Album(
    id: 'folklore',
    name: 'Folklore',
    releaseYear: 2020,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/f/f8/Taylor_Swift_-_Folklore.png',
    color: const Color(0xFF808080),
    releaseSequence: 8,
  ),
  Album(
    id: 'evermore',
    name: 'Evermore',
    releaseYear: 2020,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/0/0a/Taylor_Swift_-_Evermore.png',
    color: const Color(0xFF8B4513),
    releaseSequence: 9,
  ),
  Album(
    id: 'midnights',
    name: 'Midnights',
    releaseYear: 2022,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/9/9f/Midnights_-_Taylor_Swift.png',
    color: const Color(0xFF191970),
    releaseSequence: 10,
  ),
];
