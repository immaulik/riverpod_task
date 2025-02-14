import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/preferences_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

final preferencesViewModelProvider =
    StateNotifierProvider<PreferencesViewModel, Preferences>((ref) {
  return PreferencesViewModel();
});


class PreferencesViewModel extends StateNotifier<Preferences> {
  PreferencesViewModel()
      : super(Preferences(isDarkMode: false, sortOrder: 'date')) {
    _loadPreferences();
  }

  final Box _prefsBox = Hive.box('preferences');

  void _loadPreferences() {
    final isDarkMode = _prefsBox.get('isDarkMode', defaultValue: false);
    final sortOrder = _prefsBox.get('sortOrder', defaultValue: 'date');
    state = Preferences(isDarkMode: isDarkMode, sortOrder: sortOrder);
  }

  void toggleTheme(bool isDarkMode) {
    state = Preferences(
      isDarkMode: isDarkMode,
      sortOrder: state.sortOrder,
    );
    _prefsBox.put('isDarkMode', isDarkMode);
  }
}
