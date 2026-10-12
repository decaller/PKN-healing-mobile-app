import 'package:flutter_test/flutter_test.dart';
import 'package:event_v1/event_api.dart';

void main() {
  test('Missing source fields remain absent', () {
    final event = Event.fromJson({'id': 'source-1', 'title': 'Source title'});
    expect(event.dateLabel, isNull);
    expect(event.registrationUrl, isNull);
    expect(event.speakers, isEmpty);
    expect(event.prices, isEmpty);
  });

  test('Source markup is rendered as plain text', () {
    expect(plainText('<strong>Source title</strong>'), 'Source title');
    expect(plainText('  '), isNull);
  });

  test('External actions allow only absolute HTTP links', () {
    expect(externalUri('javascript:alert(1)'), isNull);
    expect(externalUri('/event'), isNull);
    expect(externalUri('https://karakternabawiyah.com/event')?.host, 'karakternabawiyah.com');
  });
}
