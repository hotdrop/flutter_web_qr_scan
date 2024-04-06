import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pwa_qr_scan_test/ui/qr/mobile_scanner/ms_qr_read_provider.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_dialog.dart';

class MobileScannerQrWidget extends ConsumerWidget {
  const MobileScannerQrWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        MobileScanner(
          controller: ref.watch(mobileScannerControllerProvider),
          // v5.0.0だとonDetectがなくなるのでinitStateでstreamをlistenしてbarcodesデータを取得する
          onDetect: (capture) async {
            ref.read(mobileScannerControllerProvider).stop();
            final barcode = capture.barcodes.first;
            if (barcode.rawValue != null) {
              await QrReadDialog.show(context, barcode.rawValue!);
            }
            ref.read(mobileScannerControllerProvider).start();
          },
        ),
      ],
    );
  }
}
