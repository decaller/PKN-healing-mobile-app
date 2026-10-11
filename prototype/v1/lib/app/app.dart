import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../core/theme/earth_tree_forui.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class MicrolearningApp extends ConsumerStatefulWidget {
  const MicrolearningApp({super.key});
  @override
  ConsumerState<MicrolearningApp> createState() => _MicrolearningAppState();
}

class _MicrolearningAppState extends ConsumerState<MicrolearningApp> {
  String _style = 'auto';
  ThemeMode _themeMode = ThemeMode.dark;
  @override
  void initState() {
    super.initState();
    final query = Uri.base.queryParameters;
    if (['auto', 'material', 'cupertino'].contains(query['style'])) _style = query['style']!;
    _themeMode = switch (query['theme']) {
      'light' => ThemeMode.light, 'system' => ThemeMode.system, _ => ThemeMode.dark,
    };
  }
  @override
  Widget build(BuildContext context) {
    final platform = switch (_style) {
      'material' => TargetPlatform.android, 'cupertino' => TargetPlatform.iOS, _ => null,
    };
    return MaterialApp.router(
      title: 'PKN Executive Microlearning', debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      theme: AppTheme.create(Brightness.light, platform: platform),
      darkTheme: AppTheme.create(Brightness.dark, platform: platform),
      themeMode: _themeMode, routerConfig: ref.watch(appRouterProvider),
      builder: (context, child) {
        final preview = DevicePreview.appBuilder(context, Builder(builder: (previewContext) {
          final previewTheme = Theme.of(previewContext);
          return FTheme(data: previewTheme.brightness == Brightness.dark ? earthTreeDark : earthTreeLight,
            child: Theme(data: previewTheme.copyWith(platform: platform ?? previewTheme.platform), child: child!));
        }));
        return Theme(data: Theme.of(context),
          child: Column(children: [
            if (kIsWeb) Material(color: Theme.of(context).colorScheme.surface,
              child: SafeArea(bottom: false, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(children: [
                  const Text('Preview'), const SizedBox(width: 12),
                  Semantics(label: 'Interface style preview', child: DropdownButton<String>(
                    value: _style, onChanged: (value) => setState(() => _style = value!),
                    items: const [DropdownMenuItem(value: 'auto', child: Text('Automatic')),
                      DropdownMenuItem(value: 'material', child: Text('Material')),
                      DropdownMenuItem(value: 'cupertino', child: Text('Cupertino'))])),
                  const Spacer(),
                  Semantics(label: 'Color theme preview', child: DropdownButton<ThemeMode>(
                    value: _themeMode, onChanged: (value) => setState(() => _themeMode = value!),
                    items: const [DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                      DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                      DropdownMenuItem(value: ThemeMode.system, child: Text('System'))])),
                ])))),
            Expanded(child: preview),
          ]));
      },
    );
  }
}
