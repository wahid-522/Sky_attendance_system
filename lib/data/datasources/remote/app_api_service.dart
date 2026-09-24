import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_constants.dart';

class AppApiService {
  AppApiService._();
  static final AppApiService instance = AppApiService._();

  // ── Token management ──────────────────────────────────────────────────────
  static const _tokenKey = 'sky_instructor_token';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // ── Shared headers ────────────────────────────────────────────────────────
  Future<Map<String, String>> _headers() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ── Helper: parse response or throw ──────────────────────────────────────
  dynamic _parse(http.Response res) {
    final body = jsonDecode(res.body);
    if (res.statusCode >= 200 && res.statusCode < 300) return body;
    final msg = body['message'] ?? 'Something went wrong (${res.statusCode})';
    throw ApiException(msg, res.statusCode);
  }

  // ── Auth ──────────────────────────────────────────────────────────────────
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getProfile() async {
    final res = await http.get(
      Uri.parse(ApiConstants.profile),
      headers: await _headers(),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  // ── Classes ───────────────────────────────────────────────────────────────
  Future<List<dynamic>> getMyClasses() async {
    final res = await http.get(
      Uri.parse(ApiConstants.myClasses),
      headers: await _headers(),
    );
    return _parse(res) as List<dynamic>;
  }

  // ── Subjects for a class ──────────────────────────────────────────────────
  Future<Map<String, dynamic>> getSubjectsForClass(String classId) async {
    final res = await http.get(
      Uri.parse(ApiConstants.subjectsForClass(Uri.encodeComponent(classId))),
      headers: await _headers(),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  // ── Students for a session ────────────────────────────────────────────────
  Future<Map<String, dynamic>> getStudentsForSession(
    String classId,
    String subject,
  ) async {
    final res = await http.get(
      Uri.parse(
        ApiConstants.studentsForSession(
          Uri.encodeComponent(classId),
          Uri.encodeComponent(subject),
        ),
      ),
      headers: await _headers(),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  // ── Submit attendance ─────────────────────────────────────────────────────
  Future<Map<String, dynamic>> submitAttendance({
    required String className,
    required String subject,
    required String date,
    required List<Map<String, String>> records,
  }) async {
    final res = await http.post(
      Uri.parse(ApiConstants.submitAttendance),
      headers: await _headers(),
      body: jsonEncode({
        'class':   className,
        'subject': subject,
        'date':    date,
        'records': records,
      }),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  // ── Attendance history ────────────────────────────────────────────────────
  Future<List<dynamic>> getAttendanceHistory() async {
    final res = await http.get(
      Uri.parse(ApiConstants.attendanceHistory),
      headers: await _headers(),
    );
    return _parse(res) as List<dynamic>;
  }

  // ── Session detail ────────────────────────────────────────────────────────
  Future<Map<String, dynamic>> getSessionDetail(String sessionId) async {
    final res = await http.get(
      Uri.parse(ApiConstants.sessionDetail(sessionId)),
      headers: await _headers(),
    );
    return _parse(res) as Map<String, dynamic>;
  }
}

// ── Custom exception ──────────────────────────────────────────────────────────
class ApiException implements Exception {
  final String message;
  final int statusCode;
  const ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}
