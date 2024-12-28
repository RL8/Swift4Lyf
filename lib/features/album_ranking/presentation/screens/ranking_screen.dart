// Swift4Lyf Album Ranking Screen
// Version: 1.1.0 - Enhanced drag & drop, drawer behavior
// Last Updated: 2024-12-28

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool isUnrankedVisible = true;

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

  Widget _buildRankedAlbum(Album album, int index) {
    return ReorderableDragStartListener(
      key: ValueKey(album.id),
      index: index,
      child: LongPressDraggable<Album>(
        data: album,
        delay: const Duration(milliseconds: 150),
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
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  child: Text('${album.rank}', style: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(width: 8),
                _buildAlbumArt(album),
              ],
            ),
            title: Text(album.name, style: TextStyle(color: Colors.grey)),
            subtitle: Text('${album.releaseYear}', style: TextStyle(color: Colors.grey)),
          ),
        ),
        child: Card(
          elevation: 1,
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
        onDragStarted: () {
          HapticFeedback.mediumImpact();
        },
        onDragEnd: (details) {
          // Check if the drag ended in the unranked section
          final unrankedSectionTop = MediaQuery.of(context).size.height * 0.75;
          if (details.offset.dy > unrankedSectionTop) {
            _handleUnrankAlbum(album);
            HapticFeedback.mediumImpact();
          }
        },
      ),
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
      body: Stack(
        children: [
          // Ranked Albums Section (Full Screen)
          Positioned.fill(
            child: DragTarget<Album>(
              onAccept: (album) => _handleRankAlbum(album, null),
              onWillAccept: (album) => album != null && !rankedAlbums.contains(album),
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: candidateData.isNotEmpty
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                  child: rankedAlbums.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                color: Colors.grey,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Drag albums here to rank them!',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : ReorderableListView.builder(
                          itemCount: rankedAlbums.length,
                          itemBuilder: (context, index) {
                            return _buildRankedAlbum(rankedAlbums[index], index);
                          },
                          onReorder: _handleReorder,
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 8.0,
                            right: 8.0,
                            bottom: isUnrankedVisible ? 200.0 : 8.0,
                          ),
                        ),
                );
              },
            ),
          ),
          // Unranked Albums Drawer
          Positioned(
            left: 0,
            right: 0,
            bottom: isUnrankedVisible ? 0 : -(MediaQuery.of(context).size.height * 0.25),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drawer Handle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isUnrankedVisible = !isUnrankedVisible;
                      });
                    },
                    child: Container(
                      height: 24,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Unranked Albums
                  Expanded(
                    child: DragTarget<Album>(
                      onAccept: _handleUnrankAlbum,
                      onWillAccept: (album) => album != null && !unrankedAlbums.contains(album),
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          color: candidateData.isNotEmpty
                              ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
                              : Colors.transparent,
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.white, Colors.white, Colors.white, Colors.white.withOpacity(0)],
                                stops: [0.0, 0.8, 0.9, 1.0],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.dstIn,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...unrankedAlbums.map((album) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: _buildUnrankedAlbum(album),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
