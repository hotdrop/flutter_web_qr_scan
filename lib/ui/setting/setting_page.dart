import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwa_qr_scan_test/res/app_theme.dart';
import 'package:pwa_qr_scan_test/ui/setting/setting_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTheme.appName),
      ),
      body: const Column(
        children: [
          _ViewAppVersion(),
          _ViewLicense(),
          Divider(),
        ],
      ),
    );
  }
}

class _ViewAppVersion extends ConsumerWidget {
  const _ViewAppVersion();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('アプリバージョン'),
      trailing: Text(ref.read(settingProvider).appVersion, style: const TextStyle(fontSize: 20)),
    );
  }
}

class _ViewLicense extends ConsumerWidget {
  const _ViewLicense();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: const Text('ライセンス'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        showLicensePage(
          context: context,
          applicationName: AppTheme.appName,
          applicationVersion: ref.read(settingProvider).appVersion,
          applicationIcon: const Icon(Icons.info),
        );
      },
    );
  }
}
