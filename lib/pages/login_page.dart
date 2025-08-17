import 'package:flutter/material.dart';
import 'package:mitra_cempaka/pages/home_page.dart';
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

  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "MITRA CEMPAKA",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
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
                  SizedBox(height: 30),
                  FilledButton(
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()) {
                        _formGlobalKey.currentState!.save();
                        if (_username == 'admin' && _password == 'admin') {
                          setState(() {
                            _error = "";
                          });
                          AuthPreferences.setLoggedIn(true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          setState(() {
                            _error = "Incorrect username or password";
                          });
                        }
                      }
                    },
                    child: Text("Login"),
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
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
