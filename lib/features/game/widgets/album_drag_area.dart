import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift4lyf/domain/models/album.dart';
import 'package:swift4lyf/features/game/state/game_providers.dart';
import 'package:swift4lyf/features/game/utils/asset_loader.dart';

class AlbumDragArea extends ConsumerWidget {
  const AlbumDragArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums = ref.watch(gameStateProvider.select(
      (state) => state.currentSession.selectedAlbums,
    ));

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _DraggableAlbumsGrid(albums: albums),
              ),
              const SizedBox(width: 16),
              const _DropTarget(),
            ],
          ),
        );
      },
    );
  }
}

class _DraggableAlbumsGrid extends StatelessWidget {
  final List<Album> albums;

  const _DraggableAlbumsGrid({required this.albums});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return _DraggableAlbum(album: albums[index]);
      },
    );
  }
}

class _DraggableAlbum extends ConsumerWidget {
  final Album album;

  const _DraggableAlbum({required this.album});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Draggable<String>(
      data: album.id,
      feedback: _buildAlbumCard(context, size: 100),
      childWhenDragging: _buildAlbumCard(context, opacity: 0.5),
      child: _buildAlbumCard(context),
    );
  }

  Widget _buildAlbumCard(BuildContext context, {double? size, double opacity = 1.0}) {
    return FutureBuilder<ImageProvider>(
      future: AssetLoader.loadAlbumImage(album),
      builder: (context, snapshot) {
        return Card(
          elevation: 4,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: snapshot.hasData
                  ? DecorationImage(
                      image: snapshot.data!,
                      fit: BoxFit.cover,
                      opacity: opacity,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _DropTarget extends ConsumerWidget {
  const _DropTarget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: candidateData.isNotEmpty
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('Drop Album Here'),
          ),
        );
      },
      onWillAccept: (data) => data != null,
      onAccept: (albumId) {
        // Process the answer through the game controller
        ref.read(gameStateProvider.notifier).processAnswer(albumId, '');
      },
    );
  }
}
