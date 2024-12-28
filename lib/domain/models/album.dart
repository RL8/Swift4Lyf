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
}

// Taylor Swift's albums with era colors and release sequence
final defaultAlbums = [
  Album(
    id: 'taylor_swift',
    name: 'Taylor Swift (Debut)',
    releaseYear: 2006,
    releaseSequence: 1,
    imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcR8kNHO9k0pPqjx6MqrAtKqM2kHMnOXXrHVy0u-mySi_yiFXg',
    color: const Color(0xFF008080), // Teal
  ),
  Album(
    id: 'fearless_tv',
    name: 'Fearless (TV)',
    releaseYear: 2008,
    releaseSequence: 2,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/5/5b/Fearless_%28Taylor%27s_Version%29_%282021_album_cover%29_by_Taylor_Swift.png',
    color: const Color(0xFFFFD700), // Gold
  ),
  Album(
    id: 'speak_now_tv',
    name: 'Speak Now (TV)',
    releaseYear: 2010,
    releaseSequence: 3,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/5/5b/Taylor_Swift_-_Speak_Now_%28Taylor%27s_Version%29.png',
    color: const Color(0xFF4B0082), // Purple
  ),
  Album(
    id: 'red_tv',
    name: 'Red (TV)',
    releaseYear: 2012,
    releaseSequence: 4,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/4/47/Taylor_Swift_-_Red_%28Taylor%27s_Version%29.png',
    color: const Color(0xFFFF0000), // Red
  ),
  Album(
    id: '1989_tv',
    name: '1989 (TV)',
    releaseYear: 2014,
    releaseSequence: 5,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/d/d5/Taylor_Swift_-_1989_%28Taylor%27s_Version%29.png',
    color: const Color(0xFFADD8E6), // Light Blue
  ),
  Album(
    id: 'reputation',
    name: 'Reputation',
    releaseYear: 2017,
    releaseSequence: 6,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/f/f2/Taylor_Swift_-_Reputation.png',
    color: const Color(0xFF000000), // Black
  ),
  Album(
    id: 'lover',
    name: 'Lover',
    releaseYear: 2019,
    releaseSequence: 7,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/c/cd/Taylor_Swift_-_Lover.png',
    color: const Color(0xFFFFD1DC), // Pink
  ),
  Album(
    id: 'folklore',
    name: 'Folklore',
    releaseYear: 2020,
    releaseSequence: 8,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/f/f8/Taylor_Swift_-_Folklore.png',
    color: const Color(0xFFA9A9A9), // Gray
  ),
  Album(
    id: 'evermore',
    name: 'Evermore',
    releaseYear: 2020,
    releaseSequence: 9,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/0/0a/Taylor_Swift_-_Evermore.png',
    color: const Color(0xFFCC5500), // Orange/Brown
  ),
  Album(
    id: 'midnights',
    name: 'Midnights',
    releaseYear: 2022,
    releaseSequence: 10,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/9/9f/Midnights_-_Taylor_Swift.png',
    color: const Color(0xFF000080), // Navy Blue
  ),
  Album(
    id: 'ttpd',
    name: 'TTPD',
    releaseYear: 2024,
    releaseSequence: 11,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/6/6e/Taylor_Swift_%E2%80%93_The_Tortured_Poets_Department_%28album_cover%29.png',
    color: const Color(0xFFB4A584), // Beige/Gold
  ),
];
