import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  final imageUrls = {
    'taylor_swift.png': 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcR8kNHO9k0pPqjx6MqrAtKqM2kHMnOXXrHVy0u-mySi_yiFXg',
    'fearless_tv.png': 'https://upload.wikimedia.org/wikipedia/en/5/5b/Fearless_%28Taylor%27s_Version%29_%282021_album_cover%29_by_Taylor_Swift.png',
    'speak_now_tv.png': 'https://upload.wikimedia.org/wikipedia/en/5/5b/Taylor_Swift_-_Speak_Now_%28Taylor%27s_Version%29.png',
    'red_tv.png': 'https://upload.wikimedia.org/wikipedia/en/4/47/Taylor_Swift_-_Red_%28Taylor%27s_Version%29.png',
    '1989_tv.png': 'https://upload.wikimedia.org/wikipedia/en/d/d5/Taylor_Swift_-_1989_%28Taylor%27s_Version%29.png',
    'reputation.png': 'https://upload.wikimedia.org/wikipedia/en/f/f2/Taylor_Swift_-_Reputation.png',
    'lover.png': 'https://upload.wikimedia.org/wikipedia/en/c/cd/Taylor_Swift_-_Lover.png',
    'folklore.png': 'https://upload.wikimedia.org/wikipedia/en/f/f8/Taylor_Swift_-_Folklore.png',
    'evermore.png': 'https://upload.wikimedia.org/wikipedia/en/0/0a/Taylor_Swift_-_Evermore.png',
    'midnights.png': 'https://upload.wikimedia.org/wikipedia/en/9/9f/Midnights_-_Taylor_Swift.png',
    'ttpd.png': 'https://upload.wikimedia.org/wikipedia/en/6/6e/Taylor_Swift_%E2%80%93_The_Tortured_Poets_Department_%28album_cover%29.png',
  };

  final assetsDir = Directory('../assets/images');
  if (!await assetsDir.exists()) {
    await assetsDir.create(recursive: true);
  }

  for (final entry in imageUrls.entries) {
    final filename = entry.key;
    final url = entry.value;
    
    print('Downloading $filename...');
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final file = File('${assetsDir.path}/$filename');
      await file.writeAsBytes(response.bodyBytes);
      print('Successfully downloaded $filename');
    } else {
      print('Failed to download $filename: ${response.statusCode}');
    }
  }
}
