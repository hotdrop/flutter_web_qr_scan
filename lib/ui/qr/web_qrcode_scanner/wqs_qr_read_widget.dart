import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_dialog.dart';

class WqaQrReadWidget extends StatefulWidget {
  const WqaQrReadWidget({super.key});

  @override
  State<WqaQrReadWidget> createState() => _WqaQrReadWidgetState();
}

class _WqaQrReadWidgetState extends State<WqaQrReadWidget> {
  final CameraController _controller = CameraController(autoPlay: false);

  @override
  void initState() {
    super.initState();
    _controller.startVideoStream();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterWebQrcodeScanner(
      controller: _controller,
      cameraDirection: CameraDirection.back,
      onGetResult: (result) async {
        if (result.isEmpty) {
          return;
        }
        _controller.stopVideoStream();
        await QrReadDialog.show(context, result);
        _controller.startVideoStream();
      },
      height: MediaQuery.of(context).size.height * 0.9,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
