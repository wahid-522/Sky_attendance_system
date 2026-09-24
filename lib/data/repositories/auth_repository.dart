import '../datasources/remote/app_api_service.dart';
import '../models/instructor_model.dart';

class AuthRepository {
  final AppApiService _api = AppApiService.instance;

  /// Login with email + password.
  /// Saves token, returns instructor model.
  Future<InstructorModel> login(String email, String password) async {
    final data = await _api.login(email, password);
    await _api.saveToken(data['token'] as String);
    return InstructorModel.fromJson(data['instructor'] as Map<String, dynamic>);
  }

  /// Get current instructor profile.
  Future<InstructorModel> getProfile() async {
    final data = await _api.getProfile();
    return InstructorModel.fromJson(data);
  }

  /// Check if a token is stored (i.e., user is logged in).
  Future<bool> isLoggedIn() async {
    final token = await _api.getToken();
    return token != null && token.isNotEmpty;
  }

  /// Logout — clear stored token.
  Future<void> logout() async {
    await _api.clearToken();
  }
}
