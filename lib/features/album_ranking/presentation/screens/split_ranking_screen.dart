import 'package:flutter/material.dart';
import '../../../../domain/models/album.dart';

class SplitRankingScreen extends StatefulWidget {
  const SplitRankingScreen({super.key});

  @override
  State<SplitRankingScreen> createState() => _SplitRankingScreenState();
}

class _SplitRankingScreenState extends State<SplitRankingScreen> {
  late List<Album> unrankedAlbums;
  late List<Album> rankedAlbums;
  bool hasUnsavedChanges = false;
  bool isVerticalLayout = false;

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

  Widget _buildAlbumTile(Album album, {bool isRanked = false, bool isDragging = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: album.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDragging ? album.color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          if (isRanked) Container(
            width: 40,
            height: 80,
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
          Icon(
            isRanked ? Icons.drag_indicator : Icons.add_circle_outline,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildRankedSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RANKED (${rankedAlbums.length})',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              IconButton(
                icon: Icon(
                  isVerticalLayout ? Icons.splitscreen : Icons.view_agenda,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    isVerticalLayout = !isVerticalLayout;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: rankedAlbums.length,
            itemBuilder: (context, index) {
              return Draggable<Album>(
                key: ValueKey(rankedAlbums[index].id),
                data: rankedAlbums[index],
                feedback: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: _buildAlbumTile(rankedAlbums[index], isRanked: true, isDragging: true),
                ),
                childWhenDragging: _buildAlbumTile(
                  rankedAlbums[index],
                  isRanked: true,
                ),
                child: _buildAlbumTile(rankedAlbums[index], isRanked: true),
                onDragCompleted: () => _handleUnrankAlbum(rankedAlbums[index]),
              );
            },
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Album album = rankedAlbums.removeAt(oldIndex);
                rankedAlbums.insert(newIndex, album);
                _updateRanks();
                hasUnsavedChanges = true;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUnrankedSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
          child: Text(
            'UNRANKED (${unrankedAlbums.length})',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          child: DragTarget<Album>(
            onAccept: _handleUnrankAlbum,
            builder: (context, candidateData, rejectedData) {
              return ListView.builder(
                itemCount: unrankedAlbums.length,
                itemBuilder: (context, index) {
                  return Draggable<Album>(
                    data: unrankedAlbums[index],
                    feedback: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _buildAlbumTile(unrankedAlbums[index], isDragging: true),
                    ),
                    childWhenDragging: _buildAlbumTile(unrankedAlbums[index]),
                    child: _buildAlbumTile(unrankedAlbums[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Split Screen Ranking'),
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
      body: isVerticalLayout
          ? Column(
              children: [
                Expanded(child: _buildRankedSection()),
                const Divider(height: 1),
                Expanded(child: _buildUnrankedSection()),
              ],
            )
          : Row(
              children: [
                Expanded(child: _buildRankedSection()),
                Container(width: 1, color: Colors.grey.shade300),
                Expanded(child: _buildUnrankedSection()),
              ],
            ),
    );
  }
}
