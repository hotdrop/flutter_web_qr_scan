# pwa_qr_scan_test
WebでQRコードのスキャンが可能かを検証するリポジトリです。
Firebase Hostingで動作確認しているため、試す場合は`flutterfire configure`コマンドで`firebase_options.dart`を作ってください。

# deploy command
```cmd
firebase projects:list

// build
flutter build web --web-renderer html

// deploy
firebase deploy --only hosting:xxx
```

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
https://pub.dev/packages/mobile_scanner

検証ではver4.0.1を使用しています。このバージョンを最新Flutterバージョンで使用した場合、一度画面遷移して再びQR画面を開くとカメラが動作しない問題があります。スマホ端末でどうやらライフサイクルとFlutterのverが関係しているようでまだ解決には至っていません。  
https://github.com/juliansteenbakker/mobile_scanner/issues/976  

### v5.0.0-dev2を試した
ver4.0.1の問題はv5で解消されそうなことがコメントにありますが、問題は引き続き発生しました。  
また、v5.0.0-dev2ではWebでデバッグ実行すると以下のエラーになってカメラが起動しない問題があります。  
`MobileScannerException: code genericError, message: TypeError: null: type 'Null' is not a subtype of type 'String'`  
デバッグしたところ`MediaTrackConstraintsDelegate`メソッドでMediaTrackSettingsをreturnする際に`settings.facingMode`がnullになっているようです。  
デバッグ実行ではなくHostingにデプロイするとエラーにならず動作します。ただ`Uncaught Bad state: No element`というエラーが出ています。  
また、1回実行した後に`controller.start`をするとフリーズします。htmlレンダラーとCanvasKitどちらも試してダメでした。


## flutter_web_qrcode_scanner
https://pub.dev/packages/flutter_web_qrcode_scanner

デバッグ実行では以下のようなエラーが発生しましたが、これは非推奨のAPI`platformViewRegistry`を使っているというものなので一旦無視しました。
`The platformViewRegistry getter is deprecated and will be removed in a future release`  
シンプルで使いやすいです。

