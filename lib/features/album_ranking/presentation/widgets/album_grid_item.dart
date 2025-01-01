import 'package:flutter/material.dart';

class AlbumGridItem extends StatelessWidget {
  final String albumName;
  final VoidCallback onTap;
  final bool isRanked;

  const AlbumGridItem({
    super.key,
    required this.albumName,
    required this.onTap,
    this.isRanked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isRanked ? 8 : 4,
      color: isRanked 
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            albumName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isRanked ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
