import 'package:flutter/material.dart';
import 'album_grid_item.dart';

class RankedAlbumGrid extends StatelessWidget {
  final List<String> rankedAlbums;
  final Function(String) onAlbumTap;

  const RankedAlbumGrid({
    super.key,
    required this.rankedAlbums,
    required this.onAlbumTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Your Top 3 Albums',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                if (index < rankedAlbums.length) {
                  return AlbumGridItem(
                    albumName: rankedAlbums[index],
                    onTap: () => onAlbumTap(rankedAlbums[index]),
                    isRanked: true,
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
