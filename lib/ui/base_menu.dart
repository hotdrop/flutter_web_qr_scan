import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwa_qr_scan_test/ui/home/home_page.dart';
import 'package:pwa_qr_scan_test/ui/setting/setting_page.dart';

class BaseMenu extends ConsumerWidget {
  const BaseMenu({super.key});

  static void start(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => const BaseMenu()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobileSize = constraints.maxWidth < 640;
        if (isMobileSize) {
          return const _ViewScreenSizeMobile();
        } else {
          return const _ViewScreenSizeWeb();
        }
      },
    );
  }
}

class _ViewScreenSizeWeb extends StatelessWidget {
  const _ViewScreenSizeWeb();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          _ViewNavigationRailForWeb(),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _ViewMenuSelectPage()),
        ],
      ),
    );
  }
}

class _ViewNavigationRailForWeb extends ConsumerWidget {
  const _ViewNavigationRailForWeb();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIdx = ref.watch(selectMenuProvider);

    return NavigationRail(
      destinations: _destinations
          .map((e) => NavigationRailDestination(
                icon: e.icon,
                label: Text(e.title),
              ))
          .toList(),
      selectedIndex: currentIdx,
      onDestinationSelected: (index) => ref.read(selectMenuProvider.notifier).state = index,
      labelType: NavigationRailLabelType.all,
    );
  }
}

class _ViewScreenSizeMobile extends StatelessWidget {
  const _ViewScreenSizeMobile();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _ViewMenuSelectPage(),
      bottomNavigationBar: _ViewBottomNavigationBarForMobile(),
    );
  }
}

class _ViewBottomNavigationBarForMobile extends ConsumerWidget {
  const _ViewBottomNavigationBarForMobile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIdx = ref.watch(selectMenuProvider);

    return BottomNavigationBar(
      currentIndex: currentIdx,
      elevation: 4,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: _destinations
          .map((e) => BottomNavigationBarItem(
                label: e.title,
                icon: e.icon,
              ))
          .toList(),
      onTap: (index) => ref.read(selectMenuProvider.notifier).state = index,
    );
  }
}

class _ViewMenuSelectPage extends ConsumerWidget {
  const _ViewMenuSelectPage();

  static const int _homeIndex = 0;
  static const int _settingsIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIdx = ref.watch(selectMenuProvider);

    return switch (currentIdx) {
      _homeIndex => const HomePage(),
      _settingsIndex => const SettingsPage(),
      _ => throw Exception('不正なindexです。index=$currentIdx'),
    };
  }
}

const List<Destination> _destinations = [
  Destination('ホーム', Icon(Icons.home)),
  Destination('設定', Icon(Icons.settings)),
];

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final Widget icon;
}

final selectMenuProvider = StateProvider<int>((_) => 0);
