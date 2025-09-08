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
  final _pages = [CashierPage(), HistoryPage(), SettingPage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: theme.primaryColor.withValues(alpha: 0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.point_of_sale,
              color: _currentIndex == 0 ? theme.primaryColor : Colors.grey[500],
            ),
            label: 'Cashier',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.receipt_long,
              color: _currentIndex == 1 ? theme.primaryColor : Colors.grey[500],
            ),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 2 ? theme.primaryColor : Colors.grey[500],
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
