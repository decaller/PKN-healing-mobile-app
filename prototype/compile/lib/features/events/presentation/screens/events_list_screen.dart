import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/event_model.dart';
import '../../services/event_service.dart';
import 'event_detail_screen.dart';

final eventServiceProvider = Provider<EventService>((ref) => EventService());
final eventsFutureProvider = FutureProvider<List<EventItem>>((ref) {
  return ref.watch(eventServiceProvider).fetchEvents();
});

class EventsListScreen extends ConsumerStatefulWidget {
  final VoidCallback? onBack;

  const EventsListScreen({super.key, this.onBack});

  @override
  ConsumerState<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends ConsumerState<EventsListScreen> {
  String _selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final eventsAsync = ref.watch(eventsFutureProvider);

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: widget.onBack != null
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: colors.textPrimary),
                onPressed: widget.onBack,
              )
            : null,
        title: Text(
          'Agenda & Majelis Akbar',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: eventsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: colors.meadowCanopy),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Gagal memuat agenda: $err',
            style: TextStyle(color: colors.error),
          ),
        ),
        data: (allEvents) {
          final categories = [
            'Semua',
            ...allEvents.map((e) => e.category).toSet(),
          ];
          final filtered = _selectedCategory == 'Semua'
              ? allEvents
              : allEvents.where((e) => e.category == _selectedCategory).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            children: [
              // Category Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    final isSel = cat == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSel,
                        selectedColor: colors.meadowCanopy,
                        labelStyle: TextStyle(
                          color: isSel ? colors.onMeadowCanopy : colors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        backgroundColor: colors.tactileBorder.withOpacity(0.15),
                        onSelected: (_) => setState(() => _selectedCategory = cat),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Event Cards
              ...filtered.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.tactileBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(event: item),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: colors.celestialSky.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item.category,
                                    style: TextStyle(
                                      color: colors.celestialSky,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                if (item.dateLabel != null)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      iconoir.Calendar(
                                        color: colors.textSecondary,
                                        width: 14,
                                        height: 14,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item.dateLabel!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                                height: 1.3,
                              ),
                            ),
                            if (item.summary != null) ...[
                              const SizedBox(height: 6),
                              Text(
                                item.summary!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                if (item.location != null) ...[
                                  iconoir.Pin(
                                    color: colors.textSecondary,
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item.location!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                                Text(
                                  'Lihat Detail →',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: colors.meadowCanopy,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }
}
