class ApiConstants {
  ApiConstants._();

  // ── Change this to your machine's local IP when testing on a physical device.
  // ── For Android emulator use 10.0.2.2, for iOS simulator use 127.0.0.1
  static const String baseUrl = 'http://localhost:5000/api/app';

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String login   = '$baseUrl/auth/login';
  static const String profile = '$baseUrl/profile';

  // ── Classes & Subjects ────────────────────────────────────────────────────
  static const String myClasses = '$baseUrl/my-classes';
  static String subjectsForClass(String classId) =>
      '$baseUrl/my-classes/$classId/subjects';

  // ── Students for a session ────────────────────────────────────────────────
  static String studentsForSession(String classId, String subject) =>
      '$baseUrl/sessions/$classId/$subject/students';

  // ── Attendance ────────────────────────────────────────────────────────────
  static const String submitAttendance  = '$baseUrl/attendance/submit';
  static const String attendanceHistory = '$baseUrl/attendance/history';
  static String sessionDetail(String sessionId) =>
      '$baseUrl/attendance/$sessionId';
}
