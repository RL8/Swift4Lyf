import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/game/custom_game.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/custom_game_provider.dart';
import '../../../services/share_service.dart';

class CreateGameScreen extends ConsumerStatefulWidget {
  const CreateGameScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends ConsumerState<CreateGameScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _difficulty = 'easy';
  int _timeLimit = 60;
  List<String> _selectedAlbums = [];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please sign in to create a game'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Game'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Game Title',
                hintText: 'Enter a title for your game',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _difficulty,
              decoration: const InputDecoration(
                labelText: 'Difficulty',
              ),
              items: ['easy', 'medium', 'hard']
                  .map((d) => DropdownMenuItem(
                        value: d,
                        child: Text(d.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _difficulty = value!),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text('Time Limit: $_timeLimit seconds'),
                ),
                Slider(
                  value: _timeLimit.toDouble(),
                  min: 30,
                  max: 180,
                  divisions: 5,
                  label: _timeLimit.toString(),
                  onChanged: (value) =>
                      setState(() => _timeLimit = value.round()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Select Albums:'),
            _buildAlbumSelection(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _createGame(user.uid),
              child: const Text('Create Game'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumSelection() {
    // Simplified album selection for now
    return Wrap(
      spacing: 8,
      children: defaultAlbums.map((albumId) {
        final isSelected = _selectedAlbums.contains(albumId);
        return FilterChip(
          label: Text(albumId),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedAlbums.add(albumId);
              } else {
                _selectedAlbums.remove(albumId);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Future<void> _createGame(String userId) async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAlbums.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one album')),
      );
      return;
    }

    _formKey.currentState!.save();

    final game = CustomGame.create(
      creatorId: userId,
      title: _title,
      difficulty: _difficulty,
      albumIds: _selectedAlbums,
      timeLimit: _timeLimit,
    );

    final success = await ref.read(customGameProvider.notifier).createGame(game);

    if (success) {
      await ShareService.shareCustomGame({
        'id': game.id,
        'difficulty': game.difficulty,
      });
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create game')),
        );
      }
    }
  }
}

// Temporary album list for demo
const defaultAlbums = [
  'taylor_swift',
  'fearless',
  'speak_now',
  'red',
  '1989',
  'reputation',
  'lover',
  'folklore',
  'evermore',
  'midnights',
];
