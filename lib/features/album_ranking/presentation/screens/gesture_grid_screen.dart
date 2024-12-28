import 'package:flutter/material.dart';
import '../../../../domain/models/album.dart';

class GestureGridScreen extends StatefulWidget {
  const GestureGridScreen({super.key});

  static const String version = 'v28 Dec 06:50';

  @override
  State<GestureGridScreen> createState() => _GestureGridScreenState();
}

class _GestureGridScreenState extends State<GestureGridScreen> {
  late List<Album> unrankedAlbums;
  late List<Album> rankedAlbums;
  bool hasUnsavedChanges = false;
  Album? draggedAlbum;
  bool isDraggingToUnrank = false;

  @override
  void initState() {
    super.initState();
    _resetRankings();
  }

  void _resetRankings() {
    setState(() {
      // Sort by release sequence
      unrankedAlbums = List.from(defaultAlbums)
        ..sort((a, b) => a.releaseSequence.compareTo(b.releaseSequence));
      rankedAlbums = [];
      hasUnsavedChanges = false;
    });
  }

  void _saveRankings() {
    setState(() {
      hasUnsavedChanges = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rankings saved!')),
    );
  }

  void _updateRanks() {
    for (int i = 0; i < rankedAlbums.length; i++) {
      rankedAlbums[i].rank = i + 1;
    }
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
      // Find correct position by release sequence
      final insertIndex = unrankedAlbums.indexWhere(
        (a) => a.releaseSequence > album.releaseSequence,
      );
      if (insertIndex == -1) {
        unrankedAlbums.add(album);
      } else {
        unrankedAlbums.insert(insertIndex, album);
      }
      album.rank = null;
      _updateRanks();
      hasUnsavedChanges = true;
    });
  }

  Widget _buildRankedAlbum(Album album, int index) {
    return Draggable<Album>(
      data: album,
      feedback: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: _buildAlbumTile(album, true, isDragging: true),
        ),
      ),
      childWhenDragging: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        height: 72, // Match ListTile height
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onDragStarted: () {
        setState(() {
          draggedAlbum = album;
        });
      },
      onDragEnd: (details) {
        setState(() {
          if (isDraggingToUnrank) {
            _handleUnrankAlbum(album);
          }
          draggedAlbum = null;
          isDraggingToUnrank = false;
        });
      },
      child: _buildAlbumTile(album, true),
    );
  }

  Widget _buildUnrankedAlbum(Album album) {
    return Draggable<Album>(
      data: album,
      axis: Axis.vertical,
      feedback: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 160,
          child: _buildGridTile(album, isDragging: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildGridTile(album),
      ),
      child: _buildGridTile(album),
    );
  }

  Widget _buildAlbumTile(Album album, bool isRanked, {bool isDragging = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: album.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDragging ? album.color : Colors.transparent,
          width: 2,
        ),
        boxShadow: isDragging ? [
          BoxShadow(
            color: album.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isRanked) Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: album.color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${album.rank}',
                  style: TextStyle(
                    color: album.color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (isRanked) const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                album.imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        title: Text(album.name),
        subtitle: Text('${album.releaseYear}'),
        trailing: Icon(
          isRanked ? Icons.drag_indicator : Icons.drag_handle,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildGridTile(Album album, {bool isDragging = false}) {
    final tile = Container(
      decoration: BoxDecoration(
        color: album.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDragging ? album.color : Colors.transparent,
          width: 2,
        ),
        boxShadow: isDragging ? [
          BoxShadow(
            color: album.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                album.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${album.releaseYear}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (isDragging) {
      return Transform.scale(
        scale: 1.05,
        child: tile,
      );
    }

    return tile;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final unrankedHeight = 280.0; // Height for unranked section

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            const Text('Swift4Lyf'),
            const Spacer(),
            Text(
              GestureGridScreen.version,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
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
          // Ranked Section
          SizedBox(
            height: screenHeight - unrankedHeight - kToolbarHeight - MediaQuery.of(context).padding.top,
            child: DragTarget<Album>(
              onWillAcceptWithDetails: (details) {
                final album = details.data;
                return album != null && !rankedAlbums.contains(album);
              },
              onAcceptWithDetails: (details) {
                if (details.data != null) {
                  _handleRankAlbum(details.data, null);
                }
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: candidateData.isNotEmpty
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : null,
                  child: rankedAlbums.isEmpty
                      ? const Center(
                          child: Text(
                            'Drag albums here to rank them!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ReorderableListView.builder(
                          itemCount: rankedAlbums.length,
                          itemBuilder: (context, index) {
                            return KeyedSubtree(
                              key: ValueKey(rankedAlbums[index].id),
                              child: _buildRankedAlbum(rankedAlbums[index], index),
                            );
                          },
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final album = rankedAlbums.removeAt(oldIndex);
                              rankedAlbums.insert(newIndex, album);
                              _updateRanks();
                              hasUnsavedChanges = true;
                            });
                          },
                        ),
                );
              },
            ),
          ),

          // Drop zone for unranking
          DragTarget<Album>(
            onWillAcceptWithDetails: (details) {
              final album = details.data;
              final isValid = album != null && rankedAlbums.contains(album);
              if (isValid) {
                setState(() {
                  isDraggingToUnrank = true;
                });
              }
              return isValid;
            },
            onAcceptWithDetails: (details) {
              if (details.data != null) {
                _handleUnrankAlbum(details.data);
              }
            },
            onLeave: (album) {
              setState(() {
                isDraggingToUnrank = false;
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      if (candidateData.isNotEmpty || draggedAlbum != null)
                        Theme.of(context).colorScheme.error.withOpacity(0.2)
                      else
                        Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),

          // Unranked Section
          Container(
            height: unrankedHeight,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'UNRANKED (${unrankedAlbums.length})',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: unrankedAlbums.length,
                    itemBuilder: (context, index) => _buildUnrankedAlbum(unrankedAlbums[index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
