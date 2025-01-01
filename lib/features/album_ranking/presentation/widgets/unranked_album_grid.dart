import 'package:flutter/material.dart';
import 'album_grid_item.dart';

class UnrankedAlbumGrid extends StatelessWidget {
  final List<String> unrankedAlbums;
  final Function(String) onAlbumTap;

  const UnrankedAlbumGrid({
    super.key,
    required this.unrankedAlbums,
    required this.onAlbumTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Available Albums',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: unrankedAlbums.length,
              itemBuilder: (context, index) {
                return AlbumGridItem(
                  albumName: unrankedAlbums[index],
                  onTap: () => onAlbumTap(unrankedAlbums[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
