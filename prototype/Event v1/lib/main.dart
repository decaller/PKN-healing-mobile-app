import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:url_launcher/url_launcher.dart';

import 'event_api.dart';

const sand = Color(0xFFFDF9F0);
const stone = Color(0xFFF1EDE5);
const bark = Color(0xFF7E5223);
const canopy = Color(0xFF006D30);
const ink = Color(0xFF1C1C17);
const secondary = Color(0xFF3F4850);
const sky = Color(0xFF006194);

void main() => runApp(const EventApp());

class EventApp extends StatelessWidget {
  const EventApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Agenda Karakter Nabawiyah',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: sand,
      fontFamily: 'Plus Jakarta Sans',
      colorScheme: ColorScheme.fromSeed(seedColor: canopy, surface: sand).copyWith(primary: canopy, secondary: bark, onSurface: ink),
      appBarTheme: const AppBarTheme(backgroundColor: sand, foregroundColor: ink, centerTitle: false),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: secondary, height: 1.6), titleLarge: TextStyle(fontFamily: 'Merriweather', fontWeight: FontWeight.w700, color: ink, height: 1.4)),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(minimumSize: const Size(48, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: secondary)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: sky, width: 2))),
    ),
    home: const AgendaPage(),
  );
}

String timestamp(DateTime? value) {
  if (value == null) return 'Belum tersedia';
  final local = value.toLocal();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(local.day)}/${two(local.month)}/${local.year} ${two(local.hour)}:${two(local.minute)}';
}

Future<void> openLink(BuildContext context, String? value) async {
  final uri = externalUri(value);
  if (uri == null) return;
  try {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) throw Exception('Tidak dapat membuka tautan.');
  } catch (_) {
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tautan tidak dapat dibuka. Silakan coba kembali.')));
  }
}

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});
  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final _api = EventApi();
  final _search = TextEditingController();
  EventFeed? _feed;
  String? _error;
  String? _category;
  bool _loading = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _search.addListener(_onSearchChanged);
    _load();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _load());
  }

  void _onSearchChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      final feed = await _api.feed();
      if (!mounted) return;
      setState(() { _feed = feed; _error = null; if (!feed.events.any((e) => e.category == _category)) _category = null; });
    } catch (_) {
      if (mounted) setState(() => _error = 'Agenda belum dapat dimuat. Pastikan backend aktif dan koneksi tersedia.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() { _timer?.cancel(); _search.removeListener(_onSearchChanged); _search.dispose(); _api.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final events = _feed?.events ?? <Event>[];
    final categories = events.map((e) => e.category).whereType<String>().toSet().toList()..sort();
    final query = _search.text.toLowerCase().trim();
    final filtered = events.where((e) => (_category == null || e.category == _category) && [e.title, e.summary ?? '', e.location ?? '', ...e.speakers].join(' ').toLowerCase().contains(query)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda & Acara', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)), actions: [TextButton(onPressed: _loading ? null : _load, child: const Text('Perbarui'))]),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(padding: const EdgeInsets.fromLTRB(20, 12, 20, 32), children: [
          Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 820), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('RUANG BERTUMBUH BERSAMA', style: TextStyle(color: bark, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 1.5)),
            const SizedBox(height: 12),
            Text('Temukan majelis,\nrawat fitrah keluarga.', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28)),
            const SizedBox(height: 12),
            const Text('Agenda Karakter Nabawiyah, langsung dari informasi yang diterbitkan di situs resmi.'),
            const SizedBox(height: 24),
            TextField(controller: _search, decoration: const InputDecoration(labelText: 'Cari event', hintText: 'Judul, pemateri, atau lokasi')),
            const SizedBox(height: 16),
            SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
              Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: const Text('Semua Event'), selected: _category == null, onSelected: (_) => setState(() => _category = null))),
              ...categories.map((category) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(category), selected: _category == category, onSelected: (_) => setState(() => _category = category)))),
            ])),
            const SizedBox(height: 20),
            Panel(color: stone, child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const ExcludeSemantics(child: iconoir.Calendar(width: 24, height: 24, color: bark)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Satu langkah untuk bertumbuh', style: TextStyle(fontWeight: FontWeight.w700, color: ink)),
                const Text('Jadwal dan pendaftaran mengikuti informasi penyelenggara.'),
                const SizedBox(height: 8),
                Text('Sinkronisasi terakhir: ${timestamp(_feed?.sync.lastSuccessAt)}', style: const TextStyle(fontSize: 12, color: secondary)),
                if (_feed?.sync.nextSyncAt != null) Text('Sinkronisasi berikutnya: ${timestamp(_feed?.sync.nextSyncAt)}', style: const TextStyle(fontSize: 12, color: secondary)),
                if (_feed?.sync.lastError != null) const Text('Sebagian sumber belum berhasil disinkronkan. Informasi yang berhasil diperbarui dan data terakhir tetap ditampilkan.', style: TextStyle(color: bark)),
              ])),
            ])),
            if (_loading) const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: LinearProgressIndicator()),
            if (_error != null) Padding(padding: const EdgeInsets.only(top: 16), child: MessagePanel(message: _error!, retry: _load)),
            const SizedBox(height: 24),
            Text('${filtered.length} event${query.isNotEmpty || _category != null ? ' ditemukan' : ' dari sumber resmi'}', style: const TextStyle(fontWeight: FontWeight.w700, color: ink)),
            const SizedBox(height: 16),
            if (!_loading && _error == null && filtered.isEmpty) Panel(child: Text(events.isEmpty ? 'Belum ada event dari sumber resmi. Agenda akan diperbarui otomatis.' : 'Tidak ada event yang cocok. Coba kata kunci atau kategori lain.')),
            ...filtered.map((event) => Padding(padding: const EdgeInsets.only(bottom: 20), child: EventCard(event: event, onOpen: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => DetailPage(id: event.id)))))),
          ]))),
        ]),
      ),
      bottomNavigationBar: SafeArea(top: false, child: Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: stone))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [ExcludeSemantics(child: iconoir.Calendar(width: 22, height: 22, color: canopy)), SizedBox(width: 8), Text('Agenda', style: TextStyle(color: canopy, fontWeight: FontWeight.w700))]))),
    );
  }
}

class Panel extends StatelessWidget {
  const Panel({super.key, required this.child, this.color = Colors.white});
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24), border: Border.all(color: stone)), child: child);
}

class MessagePanel extends StatelessWidget {
  const MessagePanel({super.key, required this.message, required this.retry});
  final String message;
  final VoidCallback retry;
  @override
  Widget build(BuildContext context) => Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(message), const SizedBox(height: 12), OutlinedButton(onPressed: retry, child: const Text('Coba lagi'))]));
}

class EventImage extends StatelessWidget {
  const EventImage({super.key, required this.event});
  final Event event;
  @override
  Widget build(BuildContext context) => AspectRatio(aspectRatio: 16 / 9, child: ClipRRect(borderRadius: BorderRadius.circular(24), child: Stack(fit: StackFit.expand, children: [
    if (externalUri(event.imageUrl) != null) Image.network('${apiBaseUrl.replaceFirst(RegExp(r'/+$'), '')}/events/${Uri.encodeComponent(event.id)}/image', fit: BoxFit.cover, semanticLabel: 'Poster ${event.title}', errorBuilder: (_, __, ___) => const ColoredBox(color: stone, child: Center(child: Text('Poster tidak tersedia'))), loadingBuilder: (_, child, progress) => progress == null ? child : const ColoredBox(color: stone, child: Center(child: CircularProgressIndicator()))) else const ColoredBox(color: stone, child: Center(child: iconoir.Calendar(width: 48, height: 48, color: bark))),
    const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Color(0xAA000000)]))),
    if (event.dateLabel != null) Positioned(top: 16, left: 16, right: 16, child: Align(alignment: Alignment.topLeft, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: sand, borderRadius: BorderRadius.circular(12)), child: Text(event.dateLabel!, style: const TextStyle(color: ink, fontSize: 12, fontWeight: FontWeight.w700))))),
    if (event.location != null) Positioned(bottom: 16, left: 16, right: 16, child: Text(event.location!, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
  ])));
}

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, required this.onOpen});
  final Event event;
  final VoidCallback onOpen;
  @override
  Widget build(BuildContext context) => Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    EventImage(event: event),
    const SizedBox(height: 16),
    if (event.category != null) Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(event.category!.toUpperCase(), style: const TextStyle(color: canopy, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1))),
    Text(event.title, style: Theme.of(context).textTheme.titleLarge),
    if (event.summary != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(event.summary!, maxLines: 3, overflow: TextOverflow.ellipsis)),
    if (event.speakers.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 12), child: Text(event.speakers.join(' • '), style: const TextStyle(color: bark, fontWeight: FontWeight.w600))),
    if (event.timeLabel != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(event.timeLabel!)),
    const SizedBox(height: 20),
    SizedBox(width: double.infinity, child: FilledButton(onPressed: onOpen, child: const Text('Lihat Detail Event'))),
  ]));
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});
  final String id;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _api = EventApi();
  Event? _event;
  String? _error;
  bool _loading = false;
  Timer? _timer;
  @override
  void initState() { super.initState(); _load(); _timer = Timer.periodic(const Duration(seconds: 30), (_) => _load()); }
  Future<void> _load() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      final event = await _api.detail(widget.id);
      if (mounted) setState(() { _event = event; _error = null; });
    } catch (_) {
      if (mounted) setState(() => _error = 'Detail event belum dapat dimuat atau sudah tidak tersedia.');
    } finally { if (mounted) setState(() => _loading = false); }
  }
  @override
  void dispose() { _timer?.cancel(); _api.close(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final event = _event;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Event', style: TextStyle(fontSize: 18)), actions: [TextButton(onPressed: _loading ? null : _load, child: const Text('Perbarui'))]),
      body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 32), children: [Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 820), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (_loading) const Padding(padding: EdgeInsets.only(bottom: 16), child: LinearProgressIndicator()),
        if (_error != null) Padding(padding: const EdgeInsets.only(bottom: 16), child: MessagePanel(message: _error!, retry: _load)),
        if (event != null) ...[
          EventImage(event: event), const SizedBox(height: 24),
          if (event.category != null) Text(event.category!.toUpperCase(), style: const TextStyle(color: canopy, letterSpacing: 1, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(event.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28)),
          if (event.summary != null) Padding(padding: const EdgeInsets.only(top: 16), child: Text(event.summary!, style: const TextStyle(fontStyle: FontStyle.italic, color: bark, height: 1.6))),
          const SizedBox(height: 24),
          Panel(color: stone, child: const Text('Hadiri dengan niat belajar dan bertumbuh. Pastikan jadwal dan ketentuan terbaru melalui sumber resmi penyelenggara.')),
          const SizedBox(height: 24),
          Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (event.dateLabel != null) InfoLine(label: 'Tanggal', value: event.dateLabel!),
            if (event.timeLabel != null) InfoLine(label: 'Waktu', value: event.timeLabel!),
            if (event.location != null) InfoLine(label: 'Lokasi', value: event.location!),
            if (event.dateLabel == null && event.timeLabel == null && event.location == null) const Text('Jadwal dan lokasi belum tercantum pada sumber.'),
            if (externalUri(event.mapUrl) != null) OutlinedButton(onPressed: () => openLink(context, event.mapUrl), child: const Text('Buka Peta Lokasi')),
          ])),
          if (event.speakers.isNotEmpty) ...[
            const SectionTitle('Pemateri'),
            ...event.speakers.map((speaker) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Panel(child: Row(children: [const ExcludeSemantics(child: iconoir.User(width: 28, height: 28, color: bark)), const SizedBox(width: 16), Expanded(child: Text(speaker, style: const TextStyle(color: ink, fontWeight: FontWeight.w600)))])))),
          ],
          if (event.content.isNotEmpty) ...[
            const SectionTitle('Tentang Event'),
            ...event.content.map((paragraph) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(paragraph))),
          ],
          if (event.facilities.isNotEmpty) ...[const SectionTitle('Fasilitas'), Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: event.facilities.map((item) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text('• $item'))).toList()))],
          if (event.prices.isNotEmpty) ...[const SectionTitle('Informasi Biaya'), Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: event.prices.map((item) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(item))).toList()))],
          const SizedBox(height: 24),
          if (externalUri(event.sourceUrl) != null) SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => openLink(context, event.sourceUrl), child: const Text('Baca di Situs Resmi'))),
          const SizedBox(height: 12),
          const Text('Informasi ditampilkan sesuai sumber. Data yang belum tersedia tidak diisi dengan perkiraan.', style: TextStyle(fontSize: 12, color: secondary)),
        ],
      ])))]),
      bottomNavigationBar: event != null && externalUri(event.registrationUrl) != null ? SafeArea(top: false, child: Container(color: sand, padding: const EdgeInsets.fromLTRB(20, 12, 20, 16), child: Center(heightFactor: 1, child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 820), child: SizedBox(width: double.infinity, child: FilledButton(onPressed: () => openLink(context, event.registrationUrl), child: const Text('Daftar melalui Penyelenggara'))))))) : null,
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(top: 24, bottom: 16), child: Text(text, style: Theme.of(context).textTheme.titleLarge));
}

class InfoLine extends StatelessWidget {
  const InfoLine({super.key, required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label.toUpperCase(), style: const TextStyle(fontSize: 12, color: bark, fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(value, style: const TextStyle(color: ink, fontWeight: FontWeight.w500))]));
}
