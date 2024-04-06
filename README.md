# pwa_qr_scan_test
WebでQRコードのスキャンが可能かを検証するリポジトリです。
Firebase Hostingで動作確認しているため、試す場合は`flutterfire configure`コマンドで`firebase_options.dart`を作ってください。

## 環境
検証した環境
```
> flutter --version
Flutter 3.19.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision ba39319843 (4 weeks ago) • 2024-03-07 15:22:21 -0600
Engine • revision 2e4ba9c6fb
Tools • Dart 3.3.1 • DevTools 2.31.1
```

## mobile_scanner
一番安定していて良さそうなライブラリでした。scanWindowに対応してくれていたら素晴らしかったのですがv5.0.0でmacOSが対応したのでWebにも近いうちに来てくれると期待。  
検証ではver4.0.1を使用しています。（本当はv5.0.0を使いたかったのですがまだdev版なのでやめました）  
ver4.0.1の場合、スマホ端末でバックグラウンド復帰すると画面が止まってしまう問題があります。どうやらライフサイクルとFlutterのverが関係しているようだがまだ解決には至っていません。  
https://github.com/juliansteenbakker/mobile_scanner/issues/976  

なお、v5.0.0-dev2ではWebで使用すると以下のエラーになってカメラが起動しない問題があります。  
`MobileScannerException: code genericError, message: TypeError: null: type 'Null' is not a subtype of type 'String'`  
デバッグしたところ`MediaTrackConstraintsDelegate`メソッドでMediaTrackSettingsをreturnする際に`settings.facingMode`がnullになっているようです。  
v5.0.0の安定版は期待したいところです。
