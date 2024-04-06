import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pwa_qr_scan_test/ui/setting/setting_provider.dart';

///
/// ここでアプリの初期化に必要な処理を行う
///
final appInitFutureProvider = FutureProvider((ref) async {
  final packageInfo = await PackageInfo.fromPlatform();

  ref.read(settingProvider.notifier).refresh(
        appVersion: packageInfo.version,
      );
});
