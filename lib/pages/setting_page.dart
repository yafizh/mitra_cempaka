import 'package:flutter/material.dart';
import 'package:mitra_cempaka/pages/login_page.dart';
import 'package:mitra_cempaka/services/storage/auth_preferences.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
      ),
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
                  Icon(Icons.account_circle, size: 140,),
                  SizedBox(height: 20),
                  Text(
                    'Nursahid Arya Suyudi',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                //
              },
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.only(left: 16, right: 8),
              ),
              child: Row(
                children: [
                  Icon(Icons.settings, size: 25),
                  SizedBox(width: 16),
                  Expanded(child: Text("Change Password")),
                  Icon(Icons.chevron_right_rounded, size: 40),
                ],
              ),
            ),
            SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                AuthPreferences.setLoggedIn(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.only(left: 16, right: 8),
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
