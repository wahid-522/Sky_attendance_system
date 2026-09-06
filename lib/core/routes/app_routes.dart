import 'package:flutter/material.dart';
import 'package:sky_attendance/presentation/views/attendance/attendance_confirmation_view.dart';
import 'package:sky_attendance/presentation/views/attendance/attendance_history_view.dart';
import 'package:sky_attendance/presentation/views/attendance/attendance_view.dart';
import 'package:sky_attendance/presentation/views/attendance/submitted_attendance_view.dart';
import 'package:sky_attendance/presentation/views/auth/login_view.dart';
import 'package:sky_attendance/presentation/views/home/home_view.dart';
import 'package:sky_attendance/presentation/views/profile/profile_view.dart';
import 'package:sky_attendance/presentation/views/subjects/subjects_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/';
  static const String home = '/home';
  static const String subjects = '/subjects';
  static const String attendance = '/attendance';
  static const String attendanceConfirmation = '/attendance-confirmation';
  static const String submittedAttendance = '/submitted-attendance';
  static const String attendanceHistory = '/attendance-history';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginView(),
        home: (_) => const HomeView(),
        subjects: (_) => const SubjectsView(),
        attendance: (_) => const AttendanceView(),
        attendanceConfirmation: (_) => const AttendanceConfirmationView(),
        submittedAttendance: (_) => const SubmittedAttendanceView(),
        attendanceHistory: (_) => const AttendanceHistoryView(),
        profile: (_) => const ProfileView(),
      };
}
