import 'dart:async';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_dialog.dart';

class AbsQrReadWidget extends StatefulWidget {
  const AbsQrReadWidget({super.key});

  @override
  State<AbsQrReadWidget> createState() => _AbsQrReadWidgetState();
}

class _AbsQrReadWidgetState extends State<AbsQrReadWidget> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void initState() {
    super.initState();
    unawaited(_controller.start());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AiBarcodeScanner(
          controller: _controller,
          onScan: (String value) async {
            _controller.stop();
            await QrReadDialog.show(context, value);
            _controller.start();
          },
          onDispose: () {
            _controller.dispose();
          },
          canPop: false,
          showSuccess: false,
          showError: false,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
