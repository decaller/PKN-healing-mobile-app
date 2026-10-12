import 'dart:convert';

import 'package:http/http.dart' as http;

const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8081');

// Treat backend text as text, never as executable HTML or embedded web content.
String? plainText(dynamic value) {
  if (value is! String) return null;
  final text = value.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  return text.isEmpty ? null : text;
}

Uri? externalUri(String? value) {
  final uri = Uri.tryParse(value ?? '');
  return uri != null && (uri.scheme == 'https' || uri.scheme == 'http') && uri.host.isNotEmpty ? uri : null;
}

class Event {
  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = plainText(json['title']) ?? 'Event',
        summary = plainText(json['summary']),
        imageUrl = plainText(json['imageUrl']),
        sourceUrl = plainText(json['sourceUrl']),
        registrationUrl = plainText(json['registrationUrl']),
        mapUrl = plainText(json['mapUrl']),
        dateLabel = plainText(json['dateLabel']),
        timeLabel = plainText(json['timeLabel']),
        location = plainText(json['location']),
        category = plainText(json['category']),
        speakers = strings(json['speakers']),
        facilities = strings(json['facilities']),
        prices = strings(json['prices']),
        content = strings(json['content']);

  final String id, title;
  final String? summary, imageUrl, sourceUrl, registrationUrl, mapUrl, dateLabel, timeLabel, location, category;
  final List<String> speakers, facilities, prices, content;

  static List<String> strings(dynamic value) => value is List ? value.map(plainText).whereType<String>().toList() : [];
}

class SyncStatus {
  SyncStatus.fromJson(Map<String, dynamic> json)
      : lastSuccessAt = DateTime.tryParse(json['lastSuccessAt']?.toString() ?? ''),
        nextSyncAt = DateTime.tryParse(json['nextSyncAt']?.toString() ?? ''),
        lastError = plainText(json['lastError']);
  final DateTime? lastSuccessAt, nextSyncAt;
  final String? lastError;
}

class EventFeed {
  EventFeed(this.events, this.sync);
  final List<Event> events;
  final SyncStatus sync;
}

class EventApi {
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> _get(String path) async {
    final base = apiBaseUrl.replaceFirst(RegExp(r'/+$'), '');
    final response = await _client.get(Uri.parse('$base$path')).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) throw Exception('Server tidak dapat memuat data (${response.statusCode}).');
    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic>) throw const FormatException('Respons server tidak valid.');
    return json;
  }

  Future<EventFeed> feed() async {
    final json = await _get('/events');
    if (json['events'] is! List || json['sync'] is! Map<String, dynamic>) {
      throw const FormatException('Respons agenda tidak valid.');
    }
    return EventFeed((json['events'] as List).map((item) => Event.fromJson(item as Map<String, dynamic>)).toList(), SyncStatus.fromJson(json['sync']));
  }

  Future<Event> detail(String id) async {
    final json = await _get('/events/${Uri.encodeComponent(id)}');
    if (json['event'] is! Map<String, dynamic>) throw const FormatException('Respons detail tidak valid.');
    return Event.fromJson(json['event']);
  }

  void close() => _client.close();
}
