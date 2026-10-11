import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../core/widgets/pkn_adaptive.dart';
import '../../../lessons/data/mock_lessons.dart';
import '../../data/models/idea_card.dart';
import '../controllers/feed_controller.dart';
import '../widgets/idea_card_widget.dart';

/// The mockup's discovery sections use the real local library and lesson player.
class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});
  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final _search = TextEditingController();
  final _recommendations = GlobalKey();
  String _category = 'All';
  int _serial = 0;
  final _pages = PageController(viewportFraction: .9);

  @override
  void dispose() {
    _search.dispose();
    _pages.dispose();
    super.dispose();
  }

  void _browse(String category) {
    setState(() => _category = category);
    ref.read(feedControllerProvider.notifier).selectCategory(category);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = _recommendations.currentContext;
      if (target != null) Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 350));
    });
  }

  void _lesson(int index) => context.push(RoutePaths.lessonDetails(MockLessonsRepository.lessons[index].lessonId));

  void _read(IdeaCard idea) => showPknSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => SafeArea(child: SizedBox(
      height: MediaQuery.sizeOf(context).height * .85,
      child: Column(children: [
        Row(children: [const SizedBox(width: 16), const Expanded(child: Text('Khazanah PKN')), PknIconButton(tooltip: 'Tutup materi', icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Consumer(builder: (context, ref, _) {
          final current = ref.watch(feedControllerProvider).allIdeas.firstWhere((item) => item.id == idea.id);
          return IdeaCardWidget(card: current, onBookmarkToggle: () => ref.read(feedControllerProvider.notifier).toggleBookmark(idea.id));
        }))),
      ]),
    )),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final state = ref.watch(feedControllerProvider);
    final storage = ref.watch(storageServiceProvider);
    final lessons = MockLessonsRepository.lessons;
    final completed = storage.getCompletedLessonIds();
    final results = state.allIdeas.where((idea) =>
      (_category == 'All' || idea.category == _category) &&
      ('${idea.title} ${idea.coreThesis} ${idea.tags.join(' ')}').toLowerCase().contains(_search.text.toLowerCase())).toList();
    final wide = MediaQuery.sizeOf(context).width >= 700;
    return PknScaffold(body: SafeArea(child: SingleChildScrollView(child: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1040), child: Padding(
        padding: EdgeInsets.symmetric(horizontal: wide ? 32 : 20, vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Assalamu’alaykum", style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant)),
              const SizedBox(height: 6),
              Text('Ruang bertumbuh', style: theme.textTheme.headlineSmall),
            ])),
            PknIconButton(tooltip: 'Materi tersimpan dan profil', icon: Icon(Icons.bookmark_outline, color: colors.primary), onPressed: () => context.go(RoutePaths.profile)),
            PknIconButton(tooltip: 'Buka profil', icon: CircleAvatar(backgroundColor: colors.secondaryContainer, child: Icon(Icons.person_outline, color: colors.onSecondaryContainer)), onPressed: () => context.go(RoutePaths.profile)),
          ]),
          const SizedBox(height: 24),
          PknTextField(controller: _search, onChanged: (value) {
            ref.read(feedControllerProvider.notifier).updateSearch(value);
            setState(() {});
          }, decoration: InputDecoration(hintText: 'Cari pengasuhan, adab, fitrah…', prefixIcon: const Icon(Icons.search), suffixIcon: _search.text.isEmpty ? null : PknIconButton(tooltip: 'Hapus pencarian', icon: const Icon(Icons.close), onPressed: () {
            _search.clear();
            ref.read(feedControllerProvider.notifier).updateSearch('');
            setState(() {});
          }))),
          const SizedBox(height: 12),
          FButton(onPress: () => _lesson(0), prefix: const Icon(Icons.favorite_outline), child: const Text('Butuh jeda? Pelajari bahasa hati')),
          _heading('Highlights', action: 'Semua materi', onTap: () => _browse('All')),
          _rail(height: 222, children: [
            for (var i = 0; i < state.allIdeas.length.clamp(0, 3); i++)
              _tile(title: state.allIdeas[i].title, subtitle: '${state.allIdeas[i].category} · ${state.allIdeas[i].readTimeMinutes} menit baca', icon: [Icons.wb_sunny_outlined, Icons.forest_outlined, Icons.auto_stories_outlined][i], onTap: () => _read(state.allIdeas[i]), color: i == 0 ? colors.primaryContainer : colors.surfaceContainerHigh, eyebrow: 'KHAZANAH PKN'),
          ]),
          _heading('Aktivitas Anda'),
          _rail(height: 194, children: [
            _tile(title: 'Belajar, sedikit demi sedikit', subtitle: '${completed.length} dari ${lessons.length} modul selesai', icon: Icons.school_outlined, onTap: () => context.go(RoutePaths.lessons), progress: completed.length / lessons.length),
            _tile(title: 'Simpan untuk dibaca lagi', subtitle: '${state.allIdeas.where((idea) => idea.isBookmarked).length} materi dalam koleksi', icon: Icons.bookmark_outline, onTap: () => context.go(RoutePaths.profile)),
            _tile(title: 'Sesuaikan perjalanan', subtitle: 'Pilih peran dan fokus belajar Anda', icon: Icons.explore_outlined, onTap: () => context.go(RoutePaths.onboarding)),
          ]),
          _heading('Fitur Utama'),
          LayoutBuilder(builder: (context, constraints) {
            final left = _feature('Teman belajar keluarga', 'Bukan chatbot. Materi dan latihan singkat untuk menghadapi situasi sehari-hari.', Icons.spa_outlined, () => _lesson(0), large: true);
            final right = Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: _feature('Khazanah PKN', 'Baca, cari, dan simpan', Icons.menu_book_outlined, () => _browse('All'))),
              const SizedBox(width: 12),
              Expanded(child: _feature('Perjalanan adab', 'Modul dengan latihan refleksi', Icons.route_outlined, () => context.go(RoutePaths.lessons))),
            ]);
            return Column(children: [
              left,
              const SizedBox(height: 12),
              if (constraints.maxWidth >= 700)
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: right), const SizedBox(width: 12), Expanded(child: _feature('Koleksi pribadi', 'Materi tersimpan di browser ini', Icons.bookmark_outline, () => context.go(RoutePaths.profile)))])
              else
                right,
            ]);
          }),
          _heading('Cerita & Latihan Interaktif', action: 'Semua modul', onTap: () => context.go(RoutePaths.lessons)),
          SizedBox(height: 250 * MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 2.0), child: PageView.builder(
            controller: _pages, itemCount: lessons.length, onPageChanged: (index) => setState(() => _serial = index),
            itemBuilder: (context, index) => Padding(padding: const EdgeInsets.only(right: 12), child: _tile(
              title: lessons[index].title, subtitle: '${lessons[index].estimatedMinutes} menit · ${lessons[index].cards.length} langkah interaktif',
              eyebrow: completed.contains(lessons[index].lessonId) ? 'SELESAI • BACA ULANG' : 'MODUL ${index + 1}',
              icon: Icons.auto_stories_outlined, onTap: () => _lesson(index), color: colors.secondaryContainer, fullWidth: true,
            )),
          )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [for (var i = 0; i < lessons.length; i++)
            SizedBox(width: 48, height: 48, child: IconButton(tooltip: 'Tampilkan modul ${i + 1}', onPressed: () => _pages.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.easeOut), icon: Icon(Icons.circle, size: _serial == i ? 12 : 7, color: _serial == i ? colors.primary : colors.outlineVariant))),
          ]),
          _heading('Instrumen Praktis'),
          LayoutBuilder(builder: (context, constraints) => Wrap(spacing: 12, runSpacing: 12, children: [
            for (final tool in [
              ('Bahasa Hati', Icons.favorite_border, () => _lesson(0)),
              ('Fase Anak', Icons.child_care_outlined, () => _browse('Fase Tumbuh Kembang')),
              ('Fitrah & Bakat', Icons.eco_outlined, () => _browse('Fitrah & Bakat')),
              ('Khazanah Dalil', Icons.menu_book_outlined, () => _browse('Khazanah Dalil')),
              ('Materi Simpan', Icons.bookmark_outline, () => context.go(RoutePaths.profile)),
              ('Fokus Belajar', Icons.tune_outlined, () => context.go(RoutePaths.onboarding)),
            ]) SizedBox(width: (constraints.maxWidth - 24) / 3, child: _tool(tool.$1, tool.$2, tool.$3)),
          ])),
          SizedBox(key: _recommendations),
          _heading(_search.text.isEmpty ? 'Rekomendasi untuk Anda' : 'Hasil pencarian'),
          SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
            for (final category in ['All', ...state.allIdeas.map((idea) => idea.category).toSet()]) Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(category == 'All' ? 'Semua' : category), selected: _category == category, onSelected: (_) => _browse(category))),
          ])),
          const SizedBox(height: 16),
          if (results.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Text('Tidak ada materi yang cocok. Coba kata lain atau pilih Semua.', style: theme.textTheme.bodyLarge)),
          for (final idea in results) Padding(padding: const EdgeInsets.only(bottom: 12), child: Material(
            color: colors.surfaceContainerLow, borderRadius: BorderRadius.circular(16),
            child: InkWell(borderRadius: BorderRadius.circular(16), onTap: () => _read(idea), child: Padding(
              padding: const EdgeInsets.all(16), child: Row(children: [
                Container(width: 54, height: 64, decoration: BoxDecoration(color: colors.secondaryContainer, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.article_outlined, color: colors.onSecondaryContainer)),
                const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(idea.category, style: theme.textTheme.labelSmall?.copyWith(color: colors.primary)), const SizedBox(height: 4), Text(idea.title, style: theme.textTheme.titleSmall), const SizedBox(height: 4), Text('${idea.readTimeMinutes} menit baca', style: theme.textTheme.bodySmall)])),
                PknIconButton(tooltip: idea.isBookmarked ? 'Hapus dari simpanan' : 'Simpan materi', icon: Icon(idea.isBookmarked ? Icons.bookmark : Icons.bookmark_border), onPressed: () => ref.read(feedControllerProvider.notifier).toggleBookmark(idea.id)),
              ]),
            )),
          )),
          const SizedBox(height: 16),
          Text('Belajar sesuai ritme Anda. Materi contoh tersedia di perangkat ini; tidak ada layanan konsultasi atau reservasi.', style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
          const SizedBox(height: 24),
        ]),
      )),
    ))));
  }

  Widget _heading(String title, {String? action, VoidCallback? onTap}) => Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 14), child: Row(children: [
      Expanded(child: Semantics(header: true, child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)))),
      if (action != null) TextButton(style: TextButton.styleFrom(minimumSize: const Size(48, 48)), onPressed: onTap, child: Text(action)),
    ]),
  );

  Widget _rail({required double height, required List<Widget> children}) => SizedBox(height: height * MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 2.0), child: ListView.separated(
    scrollDirection: Axis.horizontal, itemCount: children.length, separatorBuilder: (_, _) => const SizedBox(width: 12), itemBuilder: (_, index) => children[index],
  ));

  Widget _tile({required String title, required String subtitle, required IconData icon, required VoidCallback onTap, Color? color, String? eyebrow, double? progress, bool fullWidth = false}) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final background = color ?? colors.surfaceContainerHigh;
    final foreground = background == colors.primaryContainer ? colors.onPrimaryContainer : background == colors.secondaryContainer ? colors.onSecondaryContainer : colors.onSurface;
    return SizedBox(width: fullWidth ? null : 270, child: Material(color: background, borderRadius: BorderRadius.circular(20), clipBehavior: Clip.antiAlias, child: InkWell(onTap: onTap, child: Padding(
      padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, size: 30, color: foreground), const Spacer(), Icon(Icons.arrow_forward, size: 20, color: foreground)]),
        const Spacer(),
        if (eyebrow != null) Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(eyebrow, style: theme.textTheme.labelSmall?.copyWith(color: foreground))),
        Text(title, maxLines: 3, overflow: TextOverflow.ellipsis, style: theme.textTheme.titleMedium?.copyWith(color: foreground, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8), Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall?.copyWith(color: foreground)),
        if (progress != null) Padding(padding: const EdgeInsets.only(top: 12), child: LinearProgressIndicator(value: progress, minHeight: 5, borderRadius: BorderRadius.circular(8))),
      ]),
    ))));
  }

  Widget _feature(String title, String subtitle, IconData icon, VoidCallback onTap, {bool large = false}) {
    final colors = Theme.of(context).colorScheme;
    return Material(color: large ? colors.primaryContainer : colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(20), child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(20), child: Padding(
      padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: large ? 48 : 28, color: large ? colors.onPrimaryContainer : colors.primary),
        SizedBox(height: large ? 24 : 10), Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: large ? colors.onPrimaryContainer : colors.onSurface, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8), Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: large ? colors.onPrimaryContainer : colors.onSurfaceVariant)),
        if (large) Padding(padding: const EdgeInsets.only(top: 24), child: FButton(onPress: onTap, child: const Text('Mulai belajar'))),
      ]),
    )));
  }

  Widget _tool(String title, IconData icon, VoidCallback onTap) => Material(
    color: Theme.of(context).colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(16), child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18), child: Column(children: [Icon(icon, color: Theme.of(context).colorScheme.primary), const SizedBox(height: 10), Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelMedium)]),
    )),
  );
}
