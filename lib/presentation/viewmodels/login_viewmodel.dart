import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/datasources/remote/app_api_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading      = false;
  bool _obscurePassword = true;

  bool get isLoading       => _isLoading;
  bool get obscurePassword => _obscurePassword;

  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Called by LoginView — matches original API: login({onSuccess, onError})
  Future<void> login({
    required VoidCallback onSuccess,
    required void Function(String message) onError,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repo.login(
        emailController.text.trim(),
        passwordController.text,
      );
      _isLoading = false;
      notifyListeners();
      onSuccess();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      onError(e.toString());
    }
  }

  /// Called by LoginView — matches original API: forgotPassword({onAction})
  void forgotPassword({required void Function(String message) onAction}) {
    onAction('Password reset link sent to your email.');
  }

  /// Check if already logged in (token exists) — call on app start
  Future<bool> checkLoggedIn() => AppApiService.instance
      .getToken()
      .then((t) => t != null && t.isNotEmpty);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
