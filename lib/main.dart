import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwa_qr_scan_test/firebase_options.dart';
import 'package:pwa_qr_scan_test/model/app_init_provider.dart';
import 'package:pwa_qr_scan_test/res/app_theme.dart';
import 'package:pwa_qr_scan_test/ui/base_menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja', '')],
      title: AppTheme.appName,
      theme: AppTheme.light,
      home: ref.watch(appInitFutureProvider).when(
            data: (_) => const BaseMenu(),
            error: (error, s) => _ViewOnError('$error'),
            loading: () => const _ViewOnLoading(),
          ),
    );
  }
}

class _ViewOnLoading extends StatelessWidget {
  const _ViewOnLoading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTheme.appName),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ViewOnError extends StatelessWidget {
  const _ViewOnError(this.errorMessage);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTheme.appName),
      ),
      body: Center(
        child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
