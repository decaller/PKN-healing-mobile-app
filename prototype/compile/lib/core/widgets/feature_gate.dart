import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../config/feature_flags.dart';
import '../theme/theme_extensions.dart';

/// Widget pelindung komponen (Feature Gate).
/// Menampilkan [child] hanya jika [isEnabled] mengembalikan `true`.
/// Jika `false`, menampilkan [fallback] (default: kosong / SizedBox.shrink).
class FeatureGate extends ConsumerWidget {
  final bool Function(FeatureFlagsConfig flags) isEnabled;
  final Widget child;
  final Widget? fallback;

  const FeatureGate({
    super.key,
    required this.isEnabled,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flags = ref.watch(featureFlagsProvider);
    if (isEnabled(flags)) {
      return child;
    }
    return fallback ?? const SizedBox.shrink();
  }
}

/// Tampilan placeholder anggun ketika layar rute dinonaktifkan via Feature Flags
class FeatureDisabledScreen extends ConsumerWidget {
  final String featureName;
  final String description;
  final String? flagKeyToEnable;

  const FeatureDisabledScreen({
    super.key,
    required this.featureName,
    this.description =
        'Modul fitur ini saat ini sedang dinonaktifkan dalam konfigurasi aplikasi.',
    this.flagKeyToEnable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(
          'Modul Dinonaktifkan',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: colors.tactileBorder.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: iconoir.EyeClosed(
                    color: colors.textSecondary,
                    width: 36,
                    height: 36,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                featureName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              if (flagKeyToEnable != null) ...[
                FButton(
                  child: const Text('Aktifkan Modul Ini'),
                  onPress: () async {
                    await ref
                        .read(featureFlagsProvider.notifier)
                        .setFlag(flagKeyToEnable!, true);
                  },
                ),
                const SizedBox(height: 12),
              ],
              FButton(
                style: FButtonStyle.secondary,
                child: const Text('Buka Pengaturan Modul'),
                onPress: () {
                  context.push('/developer/flags');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
