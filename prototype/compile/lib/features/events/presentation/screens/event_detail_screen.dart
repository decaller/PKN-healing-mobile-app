import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/earth_tree_colors.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  final EventItem event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Agenda',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colors.celestialSky.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              event.category,
              style: TextStyle(
                color: colors.celestialSky,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            event.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),

          // Info Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.tactileBorder.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Column(
              children: [
                if (event.dateLabel != null)
                  _buildInfoRow(
                    colors,
                    iconoir.Calendar(color: colors.meadowCanopy, width: 18, height: 18),
                    'Waktu Pelaksanaan',
                    '${event.dateLabel}${event.timeLabel != null ? ' • ${event.timeLabel}' : ''}',
                  ),
                if (event.location != null) ...[
                  const Divider(height: 20),
                  _buildInfoRow(
                    colors,
                    iconoir.Pin(color: colors.meadowCanopy, width: 18, height: 18),
                    'Lokasi / Media',
                    event.location!,
                  ),
                ],
                if (event.prices.isNotEmpty) ...[
                  const Divider(height: 20),
                  _buildInfoRow(
                    colors,
                    Icon(Icons.payments_outlined, color: colors.meadowCanopy, size: 18),
                    'Biaya / Infaq',
                    event.prices.join(', '),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Pemateri
          if (event.speakers.isNotEmpty) ...[
            Text(
              'Narasumber & Pembicara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: event.speakers.map((spk) {
                return Chip(
                  avatar: CircleAvatar(
                    backgroundColor: colors.meadowCanopy.withOpacity(0.2),
                    child: Text(
                      spk[0],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colors.meadowCanopy,
                      ),
                    ),
                  ),
                  label: Text(
                    spk,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: colors.tactileBorder.withOpacity(0.12),
                  side: BorderSide(color: colors.tactileBorder),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Materi / Deskripsi
          if (event.content.isNotEmpty) ...[
            Text(
              'Rangkuman Materi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            ...event.content.map((c) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('•  ', style: TextStyle(color: colors.meadowCanopy, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        c,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
          ],

          // Tombol Registrasi
          FButton(
            child: const Text('Daftar / Ikuti Agenda'),
            onPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pendaftaran agenda berhasil dicatat!'),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    EarthTreeColors colors,
    Widget icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: icon,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
