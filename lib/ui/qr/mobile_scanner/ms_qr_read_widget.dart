import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_dialog.dart';

class MsQrReadWidget extends StatefulWidget {
  const MsQrReadWidget({super.key});

  @override
  State<MsQrReadWidget> createState() => _MsQrReadWidgetState();
}

// 5.0.0-beta.2で検証してみた名残
// class _MobileScannerQrWidgetState extends State<MobileScannerQrWidget> with WidgetsBindingObserver {
class _MsQrReadWidgetState extends State<MsQrReadWidget> {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
  );

  bool _availableCamera = false;

  @override
  void initState() {
    super.initState();
    // 5.0.0-beta.2で検証してみた名残
    // WidgetsBinding.instance.addObserver(this);
    // _listenController();
    controller.start();
    // アプリ起動後、初回画面起動の場合はカメラ機能が動作する。しかし一度本画面を閉じて再度画面を開くとカメラが起動しない。
    // ライブラリのissueに記載された通りライフサイクルによるバグのようで現在も解消されていない。したがって暫定的に以下の処理を実装する
    // ライブラリのバグが解消されたら必ず削除すること。
    // これでもAndroidだと動かないのでだめ
    Future<void>.delayed(const Duration(milliseconds: 500)).then((_) async {
      await controller.switchCamera();
      // フロントならバックにする
      final state = controller.cameraFacingState.value;
      if (state == CameraFacing.front) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        controller.switchCamera();
      }
      setState(() => _availableCamera = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_availableCamera) {
      return const Center(child: CircularProgressIndicator());
    }

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
        // IconButton(
        //   tooltip: "Switch Camera",
        //   onPressed: () => controller.switchCamera(),
        //   icon: ValueListenableBuilder<CameraFacing>(
        //     valueListenable: controller.cameraFacingState,
        //     builder: (context, state, child) {
        //       switch (state) {
        //         case CameraFacing.front:
        //           return const Icon(Icons.camera_front);
        //         case CameraFacing.back:
        //           return const Icon(Icons.camera_rear);
        //       }
        //     },
        //   ),
        // ),
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
