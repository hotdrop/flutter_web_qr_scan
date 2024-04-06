import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrReadFutureProvider = FutureProvider.autoDispose.family<bool, String>((ref, qrData) async {
  // 本当はここで読み込んだQR文字列をもとに何か処理をする
  await Future<void>.delayed(const Duration(seconds: 2));
  return true;
});
