import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/preferences_viewmodel.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SwitchListTile(
                title: const Text('Dark Mode'),
                value: ref.watch(preferencesViewModelProvider).isDarkMode,
                onChanged: (value) {
                  ref.read(preferencesViewModelProvider.notifier).toggleTheme(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}