import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final mobileScannerControllerProvider = NotifierProvider.autoDispose<_MobileScannerControllerNotifier, MobileScannerController>(_MobileScannerControllerNotifier.new);

class _MobileScannerControllerNotifier extends AutoDisposeNotifier<MobileScannerController> {
  @override
  MobileScannerController build() {
    ref.onDispose(() {
      state.dispose();
    });

    final controller = MobileScannerController(
      torchEnabled: true,
    );

    controller.start();
    return controller;
  }

  void stop() {
    state.stop();
  }

  void start() {
    state.start();
  }
}
