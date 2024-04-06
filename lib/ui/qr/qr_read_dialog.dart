import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_provider.dart';

class QrReadDialog {
  static Future<bool> show(BuildContext context, String qrData) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _DialogContents(qrData),
              ],
            ),
          ),
        ) ??
        false;
  }
}

class _DialogContents extends ConsumerWidget {
  const _DialogContents(this.qrData);

  final String qrData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(qrReadFutureProvider(qrData)).when(
          data: (result) => _ViewOnSuccess(qrData),
          loading: () => _ViewOnLoading(qrData),
          error: (e, s) => _ViewOnError(qrData, errorMessage: '$e'),
        );
  }
}

class _ViewOnLoading extends StatelessWidget {
  const _ViewOnLoading(this.qrData);

  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: 64, height: 64, child: CircularProgressIndicator()),
        const SizedBox(height: 24),
        Text('QR文字列: $qrData'),
        const SizedBox(height: 8),
        const Text('非同期処理をおこなっています。\nしばらくお待ちください'),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ViewOnError extends StatelessWidget {
  const _ViewOnError(this.qrData, {required this.errorMessage});

  final String qrData;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.close_rounded, color: Colors.red, size: 64),
        const SizedBox(height: 24),
        Text('QR文字列: $qrData'),
        const SizedBox(height: 8),
        Text('エラー: $errorMessage', style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 24),
        const _CloseButton(),
      ],
    );
  }
}

class _ViewOnSuccess extends StatelessWidget {
  const _ViewOnSuccess(this.qrData);

  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 64),
        const SizedBox(height: 16),
        Text('QR文字列: $qrData'),
        const SizedBox(height: 8),
        const Text('非同期処理が完了しました。'),
        const SizedBox(height: 24),
        const _CloseButton(),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text('閉じる'),
      ),
    );
  }
}
