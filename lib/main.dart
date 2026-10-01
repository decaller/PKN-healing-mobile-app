// ==============================================================================
// CONCEPTING & ARCHITECTURAL BLUEPRINT PHASE
// ------------------------------------------------------------------------------
// Note: This codebase is currently in the architectural concepting and scaffolding
// phase. It provides the foundational boilerplate, dependency injection graph,
// routing contracts, and state machine skeletons for rapid AI-assisted vibecoding.
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize persistent key-value local storage
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MicrolearningApp(),
    ),
  );
}
