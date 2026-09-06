import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController =
      TextEditingController(text: 'instructor@skyacademy.edu');
  final TextEditingController passwordController =
      TextEditingController(text: '12345678');

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _statusMessage;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  String? get statusMessage => _statusMessage;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void login({
    required VoidCallback onSuccess,
    required void Function(String message) onError,
  }) {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      onError('Please enter both email/username and password');
      return;
    }

    _isLoading = true;
    _statusMessage = null;
    notifyListeners();

    // Simulated local authentication
    Future.delayed(const Duration(milliseconds: 500), () {
      _isLoading = false;
      notifyListeners();
      onSuccess();
    });
  }

  void forgotPassword({required void Function(String message) onAction}) {
    onAction('Password reset link sent to registered email.');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
