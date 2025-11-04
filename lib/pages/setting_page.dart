import 'package:flutter/material.dart';
import 'package:mitra_cempaka/main.dart';
import 'package:mitra_cempaka/pages/change_password_page.dart';
import 'package:mitra_cempaka/pages/login_page.dart';
import 'package:mitra_cempaka/services/storage/auth_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _username = '-';

  Future<void> getUsername() async {
    final username = await AuthPreferences.getUsername();
    setState(() => _username = username);
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Icon(Icons.account_circle, size: 140),
                  SizedBox(height: 20),
                  Text(
                    _username,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () {
                AppNavigator.key.currentState?.push(
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.only(left: 16, right: 8),
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.2,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.settings, size: 25),
                  SizedBox(width: 16),
                  Expanded(child: Text("Ganti Password")),
                  Icon(Icons.chevron_right_rounded, size: 40),
                ],
              ),
            ),
            SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () {
                AuthPreferences.setLoggedOut();
                AppNavigator.key.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.only(left: 16, right: 8),
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.2,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.logout, size: 25),
                  SizedBox(width: 16),
                  Expanded(child: Text("Logout")),
                  Icon(Icons.chevron_right_rounded, size: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
