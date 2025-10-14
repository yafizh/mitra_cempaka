import 'package:flutter/material.dart';
import 'package:mitra_cempaka/pages/cashier_page.dart';
import 'package:mitra_cempaka/pages/history_page.dart';
import 'package:mitra_cempaka/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _pages = [
    {"page": CashierPage(), "label": "Kasir", "icon": Icons.point_of_sale},
    {
      "page": HistoryPage(),
      "label": "Riwayat Penjualan",
      "icon": Icons.receipt_long,
    },
    {"page": SettingPage(), "label": "Profil", "icon": Icons.person},
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _pages.map((page) => page["page"]).elementAt(_currentIndex),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: theme.primaryColor.withValues(alpha: 0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: _pages
            .map(
              (page) => NavigationDestination(
                icon: Icon(page["icon"]),
                label: page['label'],
              ),
            )
            .toList(),
      ),
    );
  }
}
