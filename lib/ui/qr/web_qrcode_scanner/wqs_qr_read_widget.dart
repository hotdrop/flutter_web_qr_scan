import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_dialog.dart';

class WqaQrReadScannerWidget extends StatefulWidget {
  const WqaQrReadScannerWidget({super.key});

  @override
  State<WqaQrReadScannerWidget> createState() => _WqaQrReadScannerWidgetState();
}

class _WqaQrReadScannerWidgetState extends State<WqaQrReadScannerWidget> {
  final CameraController _controller = CameraController(autoPlay: false);

  @override
  void initState() {
    super.initState();
    _controller.startVideoStream();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterWebQrcodeScanner(
          controller: _controller,
          cameraDirection: CameraDirection.back,
          onGetResult: (result) async {
            _controller.stopVideoStream();
            await QrReadDialog.show(context, result);
            _controller.startVideoStream();
          },
          height: MediaQuery.of(context).size.height * 0.9,
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
