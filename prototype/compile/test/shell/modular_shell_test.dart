import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:pkn_prototype_compile/app/shell.dart';
import 'package:pkn_prototype_compile/app/theme.dart';
import 'package:pkn_prototype_compile/core/theme/earth_tree_forui.dart';

// Mock Http to gracefully return dummy transparent image for any NetworkImage in tests
class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _FakeHttpClient();
  }
}

class _FakeHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;
  @override
  Duration? connectionTimeout;
  @override
  Duration idleTimeout = const Duration(seconds: 15);
  @override
  int? maxConnectionsPerHost;
  @override
  String? userAgent;

  @override
  void addCredentials(Uri url, String realm, HttpClientCredentials credentials) {}
  @override
  void addProxyCredentials(String host, int port, String realm, HttpClientCredentials credentials) {}
  @override
  set authenticate(Future<bool> Function(Uri url, String scheme, String? realm)? f) {}
  @override
  set authenticateProxy(Future<bool> Function(String host, int port, String scheme, String? realm)? f) {}
  @override
  set badCertificateCallback(bool Function(X509Certificate cert, String host, int port)? callback) {}
  @override
  set findProxy(String Function(Uri url)? f) {}
  @override
  void close({bool force = false}) {}

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpRequest();
  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async => _FakeHttpRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _FakeHttpResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpResponse extends Stream<List<int>> implements HttpClientResponse {
  // 1x1 transparent PNG bytes
  static final List<int> _kTransparentPng = <int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
    0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
    0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
    0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
    0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
    0x60, 0x82,
  ];

  @override
  int get statusCode => 200;
  @override
  int get contentLength => _kTransparentPng.length;
  @override
  HttpClientResponseCompressionState get compressionState => HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_kTransparentPng]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

Widget _buildTestApp() {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.create(Brightness.light),
      builder: (context, child) => FTheme(
        data: earthTreeForuiLight,
        child: child!,
      ),
      home: const AppShell(),
    ),
  );
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  group('Milestone 1 AppShell & Navigation Tests', () {
    testWidgets('Renders all 5 Milestone 1 navigation tabs', (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      // Verify 5 canonical Milestone 1 tabs exist in dock
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Agenda'), findsOneWidget);
      expect(find.text('Pustaka'), findsOneWidget);
      expect(find.text('Mitra'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('Tapping on dock tabs transitions views cleanly', (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      // Tap on Agenda tab
      await tester.tap(find.text('Agenda'));
      await tester.pumpAndSettle();
      expect(find.text('Agenda & Majelis Akbar'), findsOneWidget);

      // Tap on Pustaka tab
      await tester.tap(find.text('Pustaka'));
      await tester.pumpAndSettle();
      expect(find.text('Pustaka & Karya Nabawiyah'), findsOneWidget);

      // Tap on Mitra tab
      await tester.tap(find.text('Mitra'));
      await tester.pumpAndSettle();
      expect(find.text('Tokoh & Kemitraan Lembaga'), findsOneWidget);

      // Tap on Profil tab
      await tester.tap(find.text('Profil'));
      await tester.pumpAndSettle();
      expect(find.text('Profil & Pengaturan'), findsOneWidget);

      // Return to Beranda tab
      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();
      expect(find.text('Ahlan, Abu Zaid'), findsOneWidget);
    });

    testWidgets('Beranda displays 1/3 Nature hero and integrated quote', (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      // Verify Hero greeting
      expect(find.text('Ahlan, Abu Zaid'), findsOneWidget);
      expect(find.text('AZ'), findsWidgets);

      // Verify user requested removal of Tamyiz badge and Alternatif button
      expect(find.text('Fase Tamyiz (7-10 Th)'), findsNothing);
      expect(find.text('Alternatif'), findsNothing);

      // Verify Integrated Quote
      expect(find.text('Renungan Qalbu Hari Ini'), findsOneWidget);
      expect(find.textContaining('Koneksi Sebelum Koreksi'), findsOneWidget);

      // Verify P3K Genting Card
      expect(find.text('P3K Krisis Genting'), findsOneWidget);
      expect(find.text('< 10 Detik'), findsOneWidget);

      // Verify 2 Stacked Agendas (Atas-Bawah)
      expect(find.text('Agenda Daurah Terdekat'), findsOneWidget);
      expect(find.textContaining('Menemani Balita Tanpa Bentakan'), findsOneWidget);
      expect(find.textContaining('Membangun Kedisiplinan Shalat'), findsOneWidget);

      // Verify Pustaka Carousel
      expect(find.text('Pustaka & Karya Pilihan'), findsOneWidget);

      // Verify 6 Utility Grid Tiles
      expect(find.text('Agenda Daurah'), findsOneWidget);
      expect(find.text('Pustaka Buku'), findsOneWidget);
      expect(find.text('Tokoh Pakar'), findsOneWidget);
      expect(find.text('Lembaga Mitra'), findsOneWidget);
      expect(find.text('Kemitraan'), findsOneWidget);
      expect(find.text('P3K Jiwa'), findsOneWidget);
    });

    testWidgets('Tapping on hero quote opens Mode Renungan with digital clock and quotes', (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      // Tap on the integrated quote in hero
      await tester.tap(find.text('Renungan Qalbu Hari Ini'));
      await tester.pumpAndSettle();

      // Verify Mode Renungan is displayed
      expect(find.text('Mode Renungan Qalbu'), findsOneWidget);
      expect(find.text('Ketenangan sebelum bertindak'), findsOneWidget);
      expect(find.textContaining('Prinsip Emas Manhaj PKN'), findsOneWidget);

      // Verify close button dismisses Mode Renungan
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      expect(find.text('Ahlan, Abu Zaid'), findsOneWidget);
    });

    testWidgets('Tapping P3K Krisis Genting opens Dual-Crisis SOP with Maqashid Syariah', (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      // Tap P3K Krisis Genting
      await tester.tap(find.text('P3K Krisis Genting'));
      await tester.pumpAndSettle();

      // Verify P3K modal is shown
      expect(find.text('SOP Tindakan Cepat < 10 Detik'), findsOneWidget);
      expect(find.text('1. Anak Tantrum'), findsOneWidget);
      expect(find.text('2. Ortu Burnout'), findsOneWidget);

      // Verify Maqashid Syariah Hifzhun Nafs priority
      expect(find.textContaining('Maqashid Syariah #1: Hifzhun Nafs'), findsOneWidget);
      expect(find.textContaining('Amankan Bahaya Fisik'), findsOneWidget);

      // Switch to Ortu Burnout tab
      await tester.tap(find.text('2. Ortu Burnout'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Ubah Posisi Fisik (Sunnah Nabawiyah)'), findsOneWidget);
      expect(find.textContaining('Ta\'awwudz'), findsOneWidget);
    });
  });
}
