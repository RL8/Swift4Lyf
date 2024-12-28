import 'package:flutter/material.dart';
import '../../../../domain/models/album.dart';

class GestureRankingScreen extends StatefulWidget {
  const GestureRankingScreen({super.key});

  @override
  State<GestureRankingScreen> createState() => _GestureRankingScreenState();
}

class _GestureRankingScreenState extends State<GestureRankingScreen> {
  late List<Album> unrankedAlbums;
  late List<Album> rankedAlbums;
  bool hasUnsavedChanges = false;
  double dragDelta = 0;
  Album? draggedAlbum;
  int? draggedIndex;
  bool isHorizontalDrag = false;

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

  Widget _buildAlbumTile(Album album, bool isRanked, {int? index}) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        setState(() {
          isHorizontalDrag = true;
          draggedAlbum = album;
          draggedIndex = index;
          dragDelta = 0;
        });
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          dragDelta += details.delta.dx;
        });
      },
      onHorizontalDragEnd: (details) {
        if (dragDelta.abs() > 100) {
          if (isRanked) {
            setState(() {
              rankedAlbums.remove(album);
              unrankedAlbums.add(album);
              album.rank = null;
              _updateRanks();
              hasUnsavedChanges = true;
            });
          } else {
            setState(() {
              unrankedAlbums.remove(album);
              rankedAlbums.add(album);
              _updateRanks();
              hasUnsavedChanges = true;
            });
          }
        }
        setState(() {
          isHorizontalDrag = false;
          draggedAlbum = null;
          draggedIndex = null;
          dragDelta = 0;
        });
      },
      onVerticalDragStart: isRanked ? (details) {
        setState(() {
          draggedAlbum = album;
          draggedIndex = index;
        });
      } : null,
      onVerticalDragUpdate: isRanked ? (details) {
        if (draggedIndex != null) {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final position = box.globalToLocal(details.globalPosition);
          final newIndex = (position.dy ~/ 80).clamp(0, rankedAlbums.length - 1);
          
          if (newIndex != draggedIndex) {
            setState(() {
              final album = rankedAlbums.removeAt(draggedIndex!);
              rankedAlbums.insert(newIndex, album);
              draggedIndex = newIndex;
              _updateRanks();
              hasUnsavedChanges = true;
            });
          }
        }
      } : null,
      onVerticalDragEnd: isRanked ? (details) {
        setState(() {
          draggedAlbum = null;
          draggedIndex = null;
        });
      } : null,
      child: Transform.translate(
        offset: Offset(
          draggedAlbum == album ? dragDelta : 0,
          0,
        ),
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: album.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: draggedAlbum == album ? 
                album.color : 
                Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              if (isRanked) Container(
                width: 40,
                decoration: BoxDecoration(
                  color: album.color,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)),
                ),
                child: Center(
                  child: Text(
                    '${album.rank}',
                    style: TextStyle(
                      color: album.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  album.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      album.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${album.releaseYear}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isHorizontalDrag) Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isRanked ? Icons.drag_indicator : Icons.swap_horiz,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Gesture-Based Ranking'),
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
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(Icons.swap_horiz, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Swipe horizontally\nto move sections',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.drag_indicator, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Drag vertically\nto reorder',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                        child: Text(
                          'RANKED (${rankedAlbums.length})',
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: rankedAlbums.length,
                          itemBuilder: (context, index) => _buildAlbumTile(
                            rankedAlbums[index],
                            true,
                            index: index,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                        child: Text(
                          'UNRANKED (${unrankedAlbums.length})',
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: unrankedAlbums.length,
                          itemBuilder: (context, index) => _buildAlbumTile(
                            unrankedAlbums[index],
                            false,
                          ),
                        ),
                      ),
                    ],
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
