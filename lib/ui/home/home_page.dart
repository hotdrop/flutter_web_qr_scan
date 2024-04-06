import 'package:flutter/material.dart';
import 'package:pwa_qr_scan_test/res/app_theme.dart';
import 'package:pwa_qr_scan_test/ui/qr/mobile_scanner/ms_qr_read_page.dart';
import 'package:pwa_qr_scan_test/ui/qr/qr_read_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTheme.appName),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text('PWAでどの程度QRコードスキャナーを実現できるか検証します。基本的には以下の仕様で実装しています。'),
            Divider(),
            Text('1. カメラを起動する'),
            Text('2. QRコードを読み取る'),
            Text('3. 読み取ったらカメラを停止してダイログ表示する'),
            Text('4. ダイログを閉じたら再び読み取り可能にする'),
            Divider(),
            Text('連続読み取りはサンプルコードがたくさんありますがそんなのは参考にならなくて、業務で使う場合は1回1回読み取った後に何かをおこなって完了したら再び読み取るというオペレーションが多いと思うのでこうしました。'),
            Spacer(),
            Center(child: _MobileScannerTestButton()),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MobileScannerTestButton extends StatelessWidget {
  const _MobileScannerTestButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.qr_code, size: 32),
      onPressed: () {
        QrReadPage.start(context, qrScanWidget: const MobileScannerQrWidget());
      },
      label: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text('Mobile Scannerライブラリ', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
