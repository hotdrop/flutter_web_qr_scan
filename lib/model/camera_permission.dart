import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraPermissionProvider = FutureProvider<bool>((ref) async {
  final status = await Permission.camera.status;
  if (status.isGranted) {
    return true;
  }

  final permissionStatus = await Permission.camera.request();
  switch (permissionStatus) {
    case PermissionStatus.granted:
      return true;
    default:
      return false;
  }
});
