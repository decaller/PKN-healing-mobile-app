import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(preferences)], child: const MicrolearningApp()));
}
