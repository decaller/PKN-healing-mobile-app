import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/event_model.dart';

class EventService {
  final http.Client _client;
  final String baseUrl;

  EventService({http.Client? client, this.baseUrl = 'http://localhost:8081'})
      : _client = client ?? http.Client();

  /// Mengambil daftar event, dengan graceful fallback ke mock data jika offline/unreachable
  Future<List<EventItem>> fetchEvents() async {
    try {
      final res = await _client
          .get(Uri.parse('$baseUrl/events'))
          .timeout(const Duration(milliseconds: 1500));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data is Map && data['events'] is List) {
          return (data['events'] as List)
              .map((e) => EventItem.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (_) {
      // Graceful offline fallback
    }
    return _mockEvents;
  }

  static const List<EventItem> _mockEvents = [
    EventItem(
      id: 'evt_1',
      title: 'Majelis Akbar Parenting Nabawiyah: Menemani Balita Tanpa Bentakan',
      summary:
          'Kajian intensif bersama Ustadz Adriano Rusfi & Tim Ahli tentang seni thuma\'ninah menyikapi masa keemasan fitrah anak usia 0-7 tahun.',
      dateLabel: 'Sabtu, 24 Oktober 2026',
      timeLabel: '08:30 - 11:45 WIB',
      location: 'Masjid Agung Al-Azhar & Siaran Khusus',
      category: 'Majelis Akbar',
      speakers: ['Ustadz Adriano Rusfi, S.Psi', 'dr. Fitriani Sp.A'],
      facilities: ['Buku Panduan Adab A4', 'Sertifikat Kehadiran', 'Rekaman Kajian'],
      prices: ['Gratis / Infaq Sukarela'],
      content: [
        'Materi 1: Otak limbik balita dan cara meredam amarah orang tua saat lelah.',
        'Materi 2: Kaidah syar\'i larangan pukulan fisik pada fase thufulah awal.',
        'Sesi Tanya Jawab Interaktif & Praktik Komunikasi Lembut.',
      ],
    ),
    EventItem(
      id: 'evt_2',
      title: 'Workshop Tamyiz: Membangun Kedisiplinan Shalat Usia 7-10 Tahun',
      summary:
          'Strategi transisi hijrah gawai, penataan ritme senja, dan sentuhan hati membangun kerinduan sujud pada ananda.',
      dateLabel: 'Ahad, 8 November 2026',
      timeLabel: '09:00 - 12:00 WIB',
      location: 'Aula Pusat Khazanah Nabawiyah, Jakarta',
      category: 'Workshop Khusus',
      speakers: ['Ustadz Harry Santosa (Kutub Khazanah)', 'Kak Erlan'],
      facilities: ['RPP Adab Template A4', 'Konsultasi Privat 15 Menit'],
      prices: ['Infaq Operasional Rp 50.000'],
      content: [
        'Tinjauan Hadits Sunan Abu Dawud 495 tentang batas usia 7 tahun.',
        'Simulasi percakapan transisi Maghrib 2 menit sebelum azan.',
      ],
    ),
    EventItem(
      id: 'evt_3',
      title: 'Webinar Pasutri: Harmoni Relasi Suami Istri dalam Mengasuh Anak',
      summary:
          'Menyatukan visi pendidikan fitrah antara Ayah dan Bunda agar anak tidak bingung menghadapi dualisme aturan rumah tangga.',
      dateLabel: 'Sabtu, 21 November 2026',
      timeLabel: '19:30 - 21:00 WIB',
      location: 'Live Zoom Thuma\'ninah',
      category: 'Keluarga & Pasutri',
      speakers: ['Ustadz Bendri Jaisyurrahman'],
      facilities: ['Lembar Evaluasi Relasi Qalbiyah', 'Checklist Visi Rumah'],
      prices: ['Gratis'],
      content: [
        'Pilar Mizan: Mengapa keharmonisan orang tua adalah nutrisi jiwa anak.',
        'Seni berdiskusi evaluasi anak tanpa saling menyalahkan di hadapan anak.',
      ],
    ),
  ];
}
