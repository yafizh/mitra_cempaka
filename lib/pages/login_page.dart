import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordObscure = true;

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
            SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    onTap: () {},
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onTap: () {},
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordObscure = !isPasswordObscure;
                          });
                        },
                        icon: Icon(
                          isPasswordObscure
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: isPasswordObscure,
                  ),
                  SizedBox(height: 30),
                  FilledButton(
                    onPressed: () {},
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
