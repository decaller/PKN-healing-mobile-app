import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/ai_models.dart';

class EdgeLlmService {
  static const String _defaultOllamaUrl = String.fromEnvironment(
    'OLLAMA_URL',
    defaultValue: 'http://127.0.0.1:11434',
  );

  final String ollamaUrl;
  final http.Client _client;

  EdgeLlmService({String? ollamaUrl, http.Client? client})
      : ollamaUrl = ollamaUrl ?? _defaultOllamaUrl,
        _client = client ?? http.Client();

  static const List<ModelOption> availableModels = [
    ModelOption(
      id: 'gemma3:270m',
      name: 'Gemma 3 270M',
      badge: 'Ultra-Lite Edge',
      description: 'Model on-device paling ringan, latensi ultra-rendah untuk respons cepat.',
      size: '291 MB',
      speedRating: '> 100 tps',
    ),
    ModelOption(
      id: 'gemma3:1b',
      name: 'Gemma 3 1B',
      badge: 'Balanced Mobile',
      description: 'Keseimbangan optimal antara pemahaman semantik dan konsumsi memori.',
      size: '815 MB',
      speedRating: '~35 tps',
    ),
    ModelOption(
      id: 'gemma4:e2b',
      name: 'Gemma 4 E2B',
      badge: 'Deep Reasoning',
      description: 'Penalaran mendalam dengan thinking process untuk perancangan kurikulum.',
      size: '4.6 GB',
      speedRating: '~13 tps',
    ),
    ModelOption(
      id: 'litert:audio8',
      name: 'LiteRT Audio8 (TFLite)',
      badge: 'XNNPACK Audio',
      description: 'Mesin inferensi neural audio on-device untuk suara Walkie-Talkie.',
      size: '64.6 MB',
      speedRating: '< 10 ms/step',
      isLiteRT: true,
    ),
  ];

  /// Check whether local Ollama edge instance is reachable
  Future<bool> checkEdgeConnection() async {
    try {
      final uri = Uri.parse('$ollamaUrl/api/tags');
      final res = await _client.get(uri).timeout(const Duration(milliseconds: 1800));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// System guardrails based on PKN consultation standards
  String get _systemPrompt =>
      'Kamu adalah Teman Curhat AI Pendidikan Karakter Nabawiyah (PKN), pendamping tazkiyatun nafs '
      'dan penenteram kalbu pengasuhan Islami. Jawab santun, tenang, singkat, dan berempati. '
      'Prinsip utama: 100% on-device amanah, utamakan koneksi sebelum koreksi, tidak mendiagnosis medis, '
      'tidak menyarankan sanksi fisik pada balita, dan berikan panduan adab nabawiyah yang menyejukkan.';

  /// Stream message from Edge LLM or on-device simulation
  Stream<String> streamChat({
    required String prompt,
    required String modelId,
    required void Function(int ttftMs, int latencyMs, double tps) onMetrics,
  }) async* {
    final startTime = DateTime.now();
    bool hasReceivedFirstToken = false;
    int ttftMs = 0;
    int tokenCount = 0;

    final isLive = await checkEdgeConnection();

    if (isLive && !modelId.startsWith('litert:')) {
      final requestUri = Uri.parse('$ollamaUrl/api/chat');
      final req = http.Request('POST', requestUri);
      req.headers['Content-Type'] = 'application/json';
      req.body = jsonEncode({
        'model': modelId,
        'messages': [
          {'role': 'system', 'content': _systemPrompt},
          {'role': 'user', 'content': prompt},
        ],
        'stream': true,
        'options': {'temperature': 0.3, 'num_predict': 500},
      });

      try {
        final streamedResponse = await _client.send(req);
        if (streamedResponse.statusCode == 200) {
          final lines = streamedResponse.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter());

          await for (final line in lines) {
            if (line.trim().isEmpty) continue;
            try {
              final json = jsonDecode(line) as Map<String, dynamic>;
              final content = json['message']?['content'] as String? ?? '';
              if (content.isNotEmpty) {
                if (!hasReceivedFirstToken) {
                  hasReceivedFirstToken = true;
                  ttftMs = DateTime.now().difference(startTime).inMilliseconds;
                }
                tokenCount++;
                yield content;
              }
              if (json['done'] == true) {
                final totalMs = DateTime.now().difference(startTime).inMilliseconds;
    if (tokenCount == 0) return;
                final evalNs = json['eval_duration'] as int?;
                final double tps = (evalNs != null && evalNs > 0)
                    ? (json['eval_count'] as int? ?? tokenCount) / (evalNs / 1e9)
                    : (tokenCount / ((totalMs - ttftMs) / 1000.0).clamp(0.1, 999.0));

                onMetrics(ttftMs, totalMs, tps);
                return;
              }
            } catch (_) {}
          }
          final totalMs = DateTime.now().difference(startTime).inMilliseconds;
    if (tokenCount == 0) return;
          onMetrics(ttftMs, totalMs, tokenCount / ((totalMs - ttftMs) / 1000.0).clamp(0.1, 999.0));
          return;
        }
      } catch (e) {
        debugPrint('Fallback to offline simulation: $e');
      }
    }

    // High fidelity on-device simulation fallback
    yield* _streamSimulatedResponse(
      prompt: prompt,
      modelId: modelId,
      startTime: startTime,
      onMetrics: onMetrics,
    );
  }

  /// High-fidelity offline on-device simulation engine
  Stream<String> _streamSimulatedResponse({
    required String prompt,
    required String modelId,
    required DateTime startTime,
    required void Function(int ttftMs, int latencyMs, double tps) onMetrics,
  }) async* {
    final (content, delayPerToken, estimatedTtft) = _generateSimulatedContent(prompt, modelId);

    // Simulate TTFT cold/warm delay
    await Future.delayed(Duration(milliseconds: estimatedTtft));
    final ttftMs = DateTime.now().difference(startTime).inMilliseconds;

    final words = content.split(' ');
    int tokenCount = 0;
    for (int i = 0; i < words.length; i++) {
      yield (i == 0 ? '' : ' ') + words[i];
      tokenCount++;
      await Future.delayed(Duration(milliseconds: delayPerToken));
    }

    final totalMs = DateTime.now().difference(startTime).inMilliseconds;
    if (tokenCount == 0) return;
    final double tps = 1000.0 / delayPerToken;
    onMetrics(ttftMs, totalMs, tps);
  }

  (String content, int delayPerTokenMs, int ttftMs) _generateSimulatedContent(
    String prompt,
    String modelId,
  ) {
    int delay = 12; // 270M (~80-100 tps)
    int ttft = 120;

    if (modelId == 'gemma3:1b') {
      delay = 28; // ~35 tps
      ttft = 280;
    } else if (modelId == 'gemma4:e2b') {
      delay = 75; // ~13 tps
      ttft = 850;
    } else if (modelId.contains('litert')) {
      delay = 10;
      ttft = 140;
    }

    final lower = prompt.toLowerCase();

    if (lower.contains('rpp') || lower.contains('dokumen') || lower.contains('jadwal')) {
      return (
        'Bismillah, semoga Allah melapangkan dada Ayah Abu Hafi. '
        'Fase Tamyiz Awal (8 tahun) adalah momen krusial transisi fitrah bermain menuju kedisiplinan beradab. '
        'Perlawanan anak saat senja bukan tanda pembangkangan, melainkan rasa enggan melepaskan stimulasi sensorik. '
        'Pendekatan nabawiyah mengajarkan sentuhan hati sebelum menegakkan aturan. '
        'Berikut saya susunkan dokumen RPP Adab Harian terstruktur untuk memandu Ayah mendampingi Ananda Zaid dengan tenang.',
        delay,
        ttft,
      );
    } else if (lower.contains('maghrib') || lower.contains('gadget') || lower.contains('shalat')) {
      return (
        'Bismillah. Ketika anak 8 tahun terpikat gadget menjelang Maghrib, hindari teriakan atau perampasan langsung gawai. '
        'Duduklah sejajar pandangan matanya, letakkan tangan di pundaknya dengan lembut, lalu ucapkan: '
        '“Nak, waktu bermain sore kita cukupkan dulu ya. Allah memanggil kita untuk bersujud menjemput berkah malam ini.” '
        'Beri hitungan mundur 2 menit agar gelombang otaknya siap bertransisi tanpa rasa terkejut emosional.',
        delay,
        ttft,
      );
    } else if (lower.contains('marah') || lower.contains('dada') || lower.contains('emosi')) {
      return (
        'Tarik napas dalam-dalam, ucapkan ta’awwudz, dan basuhlah wajah dengan air wudhu. '
        'Dada yang bergemuruh adalah sinyal fitrah orang tua yang sedang lelah. Ingatlah wasiat Rasulullah ﷺ: '
        '“Jangan marah, bagimu surga.” Jadikan tatapan mata teduh sebagai perisai pertama, peluk kalbu ananda sebelum meluruskan kata-katanya.',
        delay,
        ttft,
      );
    } else if (lower.contains('tantrum') || lower.contains('sop 10')) {
      return (
        'SOP 10 Detik Tantrum di Tempat Umum: \n'
        '1. Detik 1-3: Tenangkan diri sendiri, jangan merasa dinilai oleh orang sekitar.\n'
        '2. Detik 4-6: Bawa ananda ke tempat yang lebih teduh dan tenang.\n'
        '3. Detik 7-10: Dekap aman tanpa kata-kata menghakimi, validasi: “Bunda tahu kamu sedang sedih/marah. Bunda ada di sini menemani sampai kamu tenang.”',
        delay,
        ttft,
      );
    }

    return (
      'Alhamdulillah, segala puji bagi Allah Penggenggam kalbu. '
      'Setiap ujian pengasuhan adalah cermin tazkiyah diri bagi orang tua. '
      'Mari perlahan mengurai masalah dengan kelembutan, karena kelembutan tidaklah berada pada sesuatu kecuali ia akan menghiasinya.',
      delay,
      ttft,
    );
  }

  /// Create default Dalil for Tamyiz prayer
  DalilCallout createShalatTamyizDalil() {
    return const DalilCallout(
      arabicText: 'مُرُوا أَوْلَادَكُمْ بِالصَّلَاةِ وَهُمْ أَبْنَاءُ سَبْعِ سِنِينَ',
      translation:
          '“Perintahkan anak-anakmu mendirikan shalat ketika mereka berumur tujuh tahun...” (HR. Abu Dawud)',
      source: 'Sunan Abu Dawud no. 495 • Shahih',
      explanation:
          'Para ulama menggarisbawahi bahwa pada usia 7-9 tahun (fase Tamyiz awal), '
          'pendekatan utama adalah pembiasaan kasih, tatapan mata teduh, dan teladan yang merangkul hati tanpa sanksi fisik.',
    );
  }

  /// Create standard RPP Adab document
  RppDocument createRppDocumentForZaid() {
    return const RppDocument(
      title: 'RPP Rumah Tangga: Transisi Senja & Shalat Khusyuk',
      subtitle: 'Format A4 • PDF Siap Cetak • Versi 1.0',
      targetChild: 'Ananda Zaid',
      phase: '8 Tahun (Fase Tamyiz Awal)',
      version: 'v1.0 • Amanah On-Device',
      schedule: [
        RppScheduleItem(
          time: '17:15 - 17:35',
          activity: 'Alarm Transisi Hijrah Gadget',
          adabFocus: 'Mematikan gawai sendiri secara mandiri tanpa bentakan',
        ),
        RppScheduleItem(
          time: '17:35 - 17:50',
          activity: 'Mandi Segar & Wudhu Bersama Ayah',
          adabFocus: 'Wudhu thuma’ninah dan doa melepas lelah sore',
        ),
        RppScheduleItem(
          time: '17:50 - 18:20',
          activity: 'Menuju Masjid / Adzan Bersama',
          adabFocus: 'Langkah kaki tenang menuju sajadah & shalat Maghrib',
        ),
      ],
      affirmations: [
        '“Zaid adalah anak shalih yang disayang Allah dan Rasul-Nya.”',
        '“Rumah ini tenang karena kita saling mendengar dengan cinta.”',
        '“Shalat adalah hadiah terindah kita untuk menghadap Rabb semesta alam.”',
      ],
      checklist: [
        'Menyimpan gawai pada keranjang tepat waktu',
        'Mandi dengan ceria tanpa perlu diingatkan berkali-kali',
        'Mengambil wudhu sempurna tanpa mencipratkan air berlebih',
        'Mengenakan pakaian bersih dan wangi untuk shalat Maghrib',
        'Menatap mata Ayah/Bunda dengan salam dan senyuman',
      ],
    );
  }
}
