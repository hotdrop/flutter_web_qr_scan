import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_dialog.dart';

class MobileScannerQrWidget extends StatefulWidget {
  const MobileScannerQrWidget({super.key});

  @override
  State<MobileScannerQrWidget> createState() => _MobileScannerQrWidgetState();
}

// 5.0.0-beta.2で検証してみた名残
// class _MobileScannerQrWidgetState extends State<MobileScannerQrWidget> with WidgetsBindingObserver {
class _MobileScannerQrWidgetState extends State<MobileScannerQrWidget> {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
    // useNewCameraSelector: true,
  );

  @override
  void initState() {
    super.initState();
    // 5.0.0-beta.2で検証してみた名残
    // WidgetsBinding.instance.addObserver(this);
    // _listenController();
    unawaited(controller.start());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          errorBuilder: (context, error, child) {
            return Text('エラーです: $error', style: const TextStyle(color: Colors.red));
          },
          fit: BoxFit.contain,
          onDetect: (capture) async {
            controller.stop();
            final barcode = capture.barcodes.first;
            if (barcode.rawValue != null) {
              await QrReadDialog.show(context, barcode.rawValue!);
            }
            controller.start();
          },
        ),
      ],
    );
  }

  // 5.0.0-beta.2で検証してみた名残
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  //   switch (state) {
  //     case AppLifecycleState.detached:
  //     case AppLifecycleState.hidden:
  //     case AppLifecycleState.paused:
  //       return;
  //     case AppLifecycleState.resumed:
  //       _listenController();
  //       unawaited(controller.start());
  //     case AppLifecycleState.inactive:
  //       unawaited(controller.stop());
  //   }
  // }

  // 5.0.0-beta.2で検証してみた名残
  // void _listenController() {
  //   controller.barcodes.listen((event) async {
  //     controller.stop();
  //     final barcode = event.barcodes.first;
  //     if (barcode.rawValue != null) {
  //       await QrReadDialog.show(context, barcode.rawValue!);
  //     }
  //     controller.start();
  //   });
  // }

  // 5.0.0-beta.2で検証してみた名残
  // @override
  // Future<void> dispose() async {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  //   await controller.dispose();
  // }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
