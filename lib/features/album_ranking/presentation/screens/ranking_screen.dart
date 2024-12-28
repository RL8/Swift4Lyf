import 'package:flutter/material.dart';
import '../../../../domain/models/album.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  late List<Album> unrankedAlbums;
  late List<Album> rankedAlbums;
  bool hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _resetRankings();
  }

  void _resetRankings() {
    setState(() {
      unrankedAlbums = List.from(defaultAlbums);
      rankedAlbums = [];
      hasUnsavedChanges = false;
    });
  }

  void _saveRankings() {
    // TODO: Implement Firebase save
    setState(() {
      hasUnsavedChanges = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rankings saved!')),
    );
  }

  void _handleRankAlbum(Album album, int? insertIndex) {
    setState(() {
      unrankedAlbums.remove(album);
      if (insertIndex != null) {
        rankedAlbums.insert(insertIndex, album);
      } else {
        rankedAlbums.add(album);
      }
      _updateRanks();
      hasUnsavedChanges = true;
    });
  }

  void _handleUnrankAlbum(Album album) {
    setState(() {
      rankedAlbums.remove(album);
      unrankedAlbums.add(album);
      album.rank = null;
      _updateRanks();
      hasUnsavedChanges = true;
    });
  }

  void _updateRanks() {
    for (int i = 0; i < rankedAlbums.length; i++) {
      rankedAlbums[i].rank = i + 1;
    }
  }

  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final Album album = rankedAlbums.removeAt(oldIndex);
      rankedAlbums.insert(newIndex, album);
      _updateRanks();
      hasUnsavedChanges = true;
    });
  }

  Widget _buildAlbumArt(Album album) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        album.imageUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 56,
            height: 56,
            color: Colors.grey.shade200,
            child: Icon(Icons.album, color: Colors.grey.shade400),
          );
        },
      ),
    );
  }

  Widget _buildUnrankedAlbum(Album album) {
    return Draggable<Album>(
      data: album,
      feedback: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ListTile(
            leading: _buildAlbumArt(album),
            title: Text(album.name),
            subtitle: Text('${album.releaseYear}'),
            tileColor: album.color.withOpacity(0.1),
          ),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.grey.withOpacity(0.2),
        child: ListTile(
          leading: _buildAlbumArt(album),
          title: Text(album.name, style: const TextStyle(color: Colors.grey)),
          subtitle: Text('${album.releaseYear}', style: const TextStyle(color: Colors.grey)),
        ),
      ),
      child: Card(
        child: ListTile(
          leading: _buildAlbumArt(album),
          title: Text(album.name),
          subtitle: Text('${album.releaseYear}'),
          trailing: const Icon(Icons.drag_handle),
          tileColor: album.color.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildRankedAlbum(Album album) {
    return Draggable<Album>(
      data: album,
      feedback: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: album.color,
                  child: Text(
                    '${album.rank}',
                    style: TextStyle(
                      color: album.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildAlbumArt(album),
              ],
            ),
            title: Text(album.name),
            subtitle: Text('${album.releaseYear}'),
            tileColor: album.color.withOpacity(0.1),
          ),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.grey.withOpacity(0.2),
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text('${album.rank}'),
              ),
              const SizedBox(width: 8),
              _buildAlbumArt(album),
            ],
          ),
          title: Text(album.name, style: const TextStyle(color: Colors.grey)),
          subtitle: Text('${album.releaseYear}', style: const TextStyle(color: Colors.grey)),
        ),
      ),
      child: Card(
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: album.color,
                child: Text(
                  '${album.rank}',
                  style: TextStyle(
                    color: album.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildAlbumArt(album),
            ],
          ),
          title: Text(album.name),
          subtitle: Text('${album.releaseYear}'),
          trailing: const Icon(Icons.drag_handle),
          tileColor: album.color.withOpacity(0.1),
        ),
      ),
      onDragCompleted: () => _handleUnrankAlbum(album),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Album Rankings'),
        actions: [
          // Reset button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (hasUnsavedChanges) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Reset Rankings?'),
                    content: const Text('This will clear all your current rankings. Unsaved changes will be lost.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _resetRankings();
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                );
              } else {
                _resetRankings();
              }
            },
          ),
          // Save button
          IconButton(
            icon: Icon(
              Icons.save,
              color: hasUnsavedChanges ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: hasUnsavedChanges ? _saveRankings : null,
          ),
        ],
      ),
      body: Column(
        children: [
          // Ranked Albums Section
          Expanded(
            flex: 2,
            child: DragTarget<Album>(
              onAccept: (album) => _handleRankAlbum(album, null),
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: candidateData.isNotEmpty
                      ? Colors.red.withOpacity(0.1)
                      : Colors.transparent,
                  child: rankedAlbums.isEmpty
                      ? Center(
                          child: Text(
                            'Drag albums here to rank them!',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        )
                      : ReorderableListView.builder(
                          itemCount: rankedAlbums.length,
                          itemBuilder: (context, index) {
                            return KeyedSubtree(
                              key: ValueKey(rankedAlbums[index].id),
                              child: _buildRankedAlbum(rankedAlbums[index]),
                            );
                          },
                          onReorder: _handleReorder,
                          padding: const EdgeInsets.all(8.0),
                        ),
                );
              },
            ),
          ),
          const Divider(height: 2, thickness: 2),
          // Unranked Albums Section
          Expanded(
            child: DragTarget<Album>(
              onAccept: _handleUnrankAlbum,
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: candidateData.isNotEmpty
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.transparent,
                  child: unrankedAlbums.isEmpty
                      ? Center(
                          child: Text(
                            'All albums ranked!',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: unrankedAlbums.length,
                          itemBuilder: (context, index) {
                            return _buildUnrankedAlbum(unrankedAlbums[index]);
                          },
                          padding: const EdgeInsets.all(8.0),
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
