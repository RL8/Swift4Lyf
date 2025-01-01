import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/auth_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(authProvider.notifier).signOut();
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user == null ? _buildSignIn(context, ref) : _buildProfile(context),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              ref.read(authProvider.notifier).signInDemo();
            },
            child: const Text('Try Demo'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _showPhoneSignIn(context, ref),
            child: const Text('Sign in with Phone'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: AuthService().getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = snapshot.data ?? {};
        
        return ListView(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(profile['name'] ?? 'Guest Player'),
              subtitle: const Text('Tap to edit name'),
              onTap: () => _editName(context),
            ),
            const Divider(),
            ListTile(
              title: Text('High Score: ${profile['highScore'] ?? 0}'),
              leading: const Icon(Icons.stars),
            ),
            ListTile(
              title: Text('Games Played: ${profile['gamesPlayed'] ?? 0}'),
              leading: const Icon(Icons.games),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPhoneSignIn(BuildContext context, WidgetRef ref) async {
    String? phoneNumber;
    String? verificationId;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign in with Phone'),
        content: TextField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: '+1234567890',
          ),
          onChanged: (value) => phoneNumber = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (phoneNumber != null) {
                ref.read(authProvider.notifier).verifyPhone(
                  phoneNumber: phoneNumber!,
                  onCodeSent: (vid) {
                    verificationId = vid;
                    Navigator.pop(context);
                    _showVerificationDialog(context, ref, vid);
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error)),
                    );
                  },
                );
              }
            },
            child: const Text('Send Code'),
          ),
        ],
      ),
    );
  }

  Future<void> _showVerificationDialog(
    BuildContext context,
    WidgetRef ref,
    String verificationId,
  ) async {
    String? code;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Verification Code'),
        content: TextField(
          decoration: const InputDecoration(
            labelText: 'Code',
          ),
          onChanged: (value) => code = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (code != null) {
                final success = await ref
                    .read(authProvider.notifier)
                    .verifyCode(verificationId, code!);
                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid code')),
                  );
                }
              }
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }

  Future<void> _editName(BuildContext context) async {
    String? name;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
          onChanged: (value) => name = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (name != null) {
                await AuthService().updateProfile({'name': name});
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
