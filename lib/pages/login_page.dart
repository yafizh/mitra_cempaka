import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mitra_cempaka/main.dart';
import 'package:mitra_cempaka/pages/home_page.dart';
import 'package:mitra_cempaka/services/api/mitra_cempaka_api.dart';
import 'package:mitra_cempaka/services/storage/auth_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formGlobalKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';

  bool _isPasswordObscure = true;
  bool _isLoading = false;

  String _error = '';

  void _login() async {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState!.save();

      setState(() {
        _isLoading = true;
        _error = "";
      });

      var response = await MitraCempakaApi.login(_username, _password);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        AuthPreferences.setLoggedIn(
          responseBody['user']['username'],
          responseBody['access_token'],
        );

        AppNavigator.key.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        return;
      }

      if (response.statusCode == 401) {
        setState(() {
          _isLoading = false;
          _error = jsonDecode(response.body)['message'];
        });
        return;
      }

      if (response.statusCode == 500) {
        setState(() {
          _isLoading = false;
          _error = "Server Error";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Apotek",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
              ),
            ),
            SizedBox(height: 16),
            Image.asset('images/logo.png'),
            SizedBox(height: 16),
            Text(
              "Mitra Cempaka",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            Text(
              _error.isEmpty ? '' : _error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20),
            Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  TextFormField(
                    onTap: () {},
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username required";
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onTap: () {},
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _isPasswordObscure = !_isPasswordObscure,
                        ),
                        icon: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: _isPasswordObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password required";
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _login,
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: theme.colorScheme.primary.withValues(
                        alpha: _isLoading ? 0.6 : 1,
                      ),
                      splashFactory: _isLoading ? NoSplash.splashFactory : null,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text("Login"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
