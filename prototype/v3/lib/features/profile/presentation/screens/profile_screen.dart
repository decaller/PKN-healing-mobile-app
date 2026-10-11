import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/settings.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../core/widgets/pkn_adaptive.dart';
import '../../../feed/presentation/controllers/feed_controller.dart';
import '../../../feed/presentation/widgets/idea_card_widget.dart';
import '../../../lessons/data/mock_lessons.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.watch(storageServiceProvider);
    final feed = ref.watch(feedControllerProvider);
    final saved = feed.allIdeas.where((idea) => idea.isBookmarked).toList();
    final theme = Theme.of(context);
    final mode = ref.watch(themeModeProvider);
    return PknScaffold(
      appBar: PknAppBar(title: const Text('Profil & pengaturan')),
      body: Align(alignment: Alignment.topCenter, child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 800), child: ListView(
        padding: const EdgeInsets.all(20), children: [
          Text('Perjalanan belajar Anda', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text('Peran: ${storage.getUserRole() ?? 'Belum dipilih'}'),
          Text('Fokus: ${storage.getUserFocus() ?? 'Semua materi'}'),
          const SizedBox(height: 16),
          FButton(onPress: () => context.go(RoutePaths.onboarding), prefix: const Icon(Icons.tune), child: const Text('Pilih peran & fokus belajar')),
          const SizedBox(height: 24),
          Text('Tampilan', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Mengikuti gaya perangkat. Pilihan warna disimpan di browser ini.', style: theme.textTheme.bodySmall),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final choice in [(ThemeMode.system, 'Sistem'), (ThemeMode.light, 'Terang'), (ThemeMode.dark, 'Gelap')])
              ChoiceChip(label: Text(choice.$2), selected: mode == choice.$1, onSelected: (_) => setAppTheme(ref, choice.$1)),
          ]),
          const Divider(height: 40),
          Text('${storage.getCompletedLessonIds().length} dari ${MockLessonsRepository.lessons.length} modul selesai', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          FButton(onPress: () => context.go(RoutePaths.lessons), child: const Text('Buka modul & latihan')),
          const SizedBox(height: 28),
          Text('Materi tersimpan · ${saved.length}', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          if (saved.isEmpty) ...[
            const Text('Belum ada materi tersimpan. Tekan ikon simpan di beranda untuk membuat koleksi Anda.'),
            const SizedBox(height: 16), FButton(onPress: () => context.go(RoutePaths.feed), child: const Text('Jelajahi materi')),
          ],
          for (final idea in saved) IdeaCardWidget(key: ValueKey(idea.id), card: idea, onBookmarkToggle: () => ref.read(feedControllerProvider.notifier).toggleBookmark(idea.id)),
          const SizedBox(height: 24),
          Text('Prototype pembelajaran lokal. Pilihan, simpanan, dan penyelesaian modul disimpan di browser ini. Tidak ada akun, sinkronisasi, chatbot, atau layanan konsultasi.', style: theme.textTheme.bodySmall),
        ],
      ))),
    );
  }
}
