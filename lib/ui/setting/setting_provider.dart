import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingProvider = NotifierProvider<SettingNotifier, AppSetting>(SettingNotifier.new);

class SettingNotifier extends Notifier<AppSetting> {
  @override
  AppSetting build() {
    return const AppSetting();
  }

  void refresh({
    required String appVersion,
  }) {
    state = state.copyWith(
      appVersion: appVersion,
    );
  }
}

class AppSetting {
  const AppSetting({
    this.appVersion = '',
  });

  final String appVersion;

  AppSetting copyWith({String? appVersion}) {
    return AppSetting(
      appVersion: appVersion ?? this.appVersion,
    );
  }
}
