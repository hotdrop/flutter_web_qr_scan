import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pwa_qr_scan_test/model/camera_permission.dart';

class QrReadPage extends ConsumerWidget {
  const QrReadPage._(this.qrScanWidget);

  static void start(BuildContext context, {required Widget qrScanWidget}) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => QrReadPage._(qrScanWidget)),
    );
  }

  final Widget qrScanWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRコード読み取り'),
      ),
      backgroundColor: Colors.black87,
      body: ref.watch(cameraPermissionProvider).when(
            data: (isPermission) => (isPermission) ? qrScanWidget : const _ViewPermissionSetting(),
            error: (e, s) => _ViewOnLoading(errorMessage: '$e'),
            loading: () => const _ViewOnLoading(),
          ),
    );
  }
}

class _ViewOnLoading extends StatelessWidget {
  const _ViewOnLoading({this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: errorMessage == null
          ? const CircularProgressIndicator()
          : Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
    );
  }
}

class _ViewPermissionSetting extends StatelessWidget {
  const _ViewPermissionSetting();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('カメラ権限がありません。アプリの設定画面を開き、カメラ権限を許可してください。\n\n許可したらお手数ですがアプリを再起動してください。'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => openAppSettings(),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Text('設定アプリを開く'),
            ),
          ),
        ],
      ),
    );
  }
}
