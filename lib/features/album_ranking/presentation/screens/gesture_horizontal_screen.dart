// Swift4Lyf Album Ranking Screen
// Version: 1.1.0 - Enhanced drag & drop, drawer behavior
// Last Updated: 2024-12-28

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../domain/models/album.dart';

class GestureHorizontalScreen extends StatefulWidget {
  const GestureHorizontalScreen({super.key});

  static const String version = 'v28 Dec 09:10';

  @override
  State<GestureHorizontalScreen> createState() => _GestureHorizontalScreenState();
}

class _GestureHorizontalScreenState extends State<GestureHorizontalScreen> with SingleTickerProviderStateMixin {
  late List<Album> unrankedAlbums;
  late List<Album> rankedAlbums;
  bool hasUnsavedChanges = false;
  Album? draggedAlbum;
  bool isDraggingToUnrank = false;
  bool isUnrankedExpanded = true;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _resetRankings();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.value = 1.0; // Start expanded
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      if (rankedAlbums.contains(album)) {
        rankedAlbums.remove(album);
        _updateRanks();
        
        // Find correct position by release sequence
        if (!unrankedAlbums.contains(album)) {
          final insertIndex = unrankedAlbums.indexWhere(
            (a) => a.releaseSequence > album.releaseSequence,
          );
          if (insertIndex == -1) {
            unrankedAlbums.add(album);
          } else {
            unrankedAlbums.insert(insertIndex, album);
          }
        }
        
        hasUnsavedChanges = true;
      }
    });
  }

  void _toggleUnrankedSection() {
    setState(() {
      isUnrankedExpanded = !isUnrankedExpanded;
      if (isUnrankedExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
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
          HapticFeedback.vibrate();
        },
        onDragEnd: (details) {
          // Check if the drag ended in the unranked section (bottom 25% of screen)
          final screenHeight = MediaQuery.of(context).size.height;
          final unrankedSectionTop = screenHeight * 0.75;
          if (details.offset.dy > unrankedSectionTop) {
            _handleUnrankAlbum(album);
            HapticFeedback.vibrate();
          }
        },
      ),
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
          width: 120,
          child: _buildAlbumTile(album, false, isDragging: true, isHorizontal: true),
        ),
      ),
      childWhenDragging: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: SizedBox(
        width: 120,
        child: _buildAlbumTile(album, false, isHorizontal: true),
      ),
    );
  }

  Widget _buildAlbumTile(Album album, bool isRanked, {
    bool isDragging = false,
    bool isHorizontal = false,
  }) {
    final tile = Container(
      width: isHorizontal ? 120 : null,
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: isHorizontal ? 8 : 16,
      ),
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
      child: isHorizontal
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                  child: Image.network(
                    album.imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: album.color.withOpacity(0.1),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${album.releaseYear}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {}, // Makes it look interactive
                borderRadius: BorderRadius.circular(8),
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
                ),
              ),
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

  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final album = rankedAlbums.removeAt(oldIndex);
      rankedAlbums.insert(newIndex, album);
      _updateRanks();
      hasUnsavedChanges = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final unrankedHeight = screenHeight * 0.25;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            const Text('Swift4Lyf'),
            const Spacer(),
            Text(
              GestureHorizontalScreen.version,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
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
                          padding: EdgeInsets.only(
                            top: 8.0,
                            left: 8.0,
                            right: 8.0,
                            bottom: isUnrankedExpanded ? unrankedHeight : 80.0, // Space for collapsed indicator
                          ),
                        ),
                );
              },
            ),
          ),
          // Unranked Counter (always visible)
          Positioned(
            left: 16,
            right: 16,
            bottom: isUnrankedExpanded ? unrankedHeight + 16 : 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isUnrankedExpanded = !isUnrankedExpanded;
                });
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.album,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${unrankedAlbums.length} Unranked',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: isUnrankedExpanded ? 0.5 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Unranked Albums Drawer
          Positioned(
            left: 0,
            right: 0,
            bottom: isUnrankedExpanded ? 0 : -unrankedHeight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: unrankedHeight,
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
                        isUnrankedExpanded = !isUnrankedExpanded;
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
