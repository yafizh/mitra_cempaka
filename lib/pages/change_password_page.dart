import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formGlobalKey = GlobalKey<FormState>();

  String _currentPassword = '';
  String _newPassword = '';
  String _confirmNewPassword = '';

  bool _isPasswordObscure = true;
  bool _isLoading = false;

  String? _errorCurrentPassword = null;
  String? _errorNewPassword = null;
  String? _errorConfirmNewPassword = null;

  void _changePassword() async {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState!.save();

      setState(() {
        _isLoading = true;
        _errorCurrentPassword = null;
        _errorNewPassword = null;
        _errorConfirmNewPassword = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ganti Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formGlobalKey,
          child: Column(
            children: [
              TextFormField(
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
                  labelText: 'Password Sekarang',
                  errorText: _errorCurrentPassword,
                ),
                obscureText: _isPasswordObscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password Sekarang Perlu diisi";
                  }

                  return null;
                },
                onSaved: (value) => _currentPassword = value!,
              ),
              SizedBox(height: 20),
              TextFormField(
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
                  labelText: 'Password Baru',
                  errorText: _errorNewPassword,
                ),
                obscureText: _isPasswordObscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password Baru Perlu diisi";
                  }

                  return null;
                },
                onSaved: (value) => _newPassword = value!,
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
                  labelText: 'Konfirmasi Password Baru',
                  errorText: _errorConfirmNewPassword,
                ),
                obscureText: _isPasswordObscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Konfirmasi Password Baru Perlu diisi";
                  }

                  return null;
                },
                onSaved: (value) => _confirmNewPassword = value!,
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: _changePassword,
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
                    : Text("Ganti Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
