import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/main.dart';
import 'package:sky_attendance/presentation/views/attendance/attendance_confirmation_view.dart';
import 'package:sky_attendance/presentation/views/attendance/attendance_history_view.dart';
import 'package:sky_attendance/presentation/views/attendance/attendance_view.dart';
import 'package:sky_attendance/presentation/views/attendance/submitted_attendance_view.dart';
import 'package:sky_attendance/presentation/views/auth/login_view.dart';
import 'package:sky_attendance/presentation/views/home/home_view.dart';
import 'package:sky_attendance/presentation/views/profile/profile_view.dart';
import 'package:sky_attendance/presentation/views/subjects/subjects_view.dart';

void main() {
  testWidgets('App root smoke test (Login screen default)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Teacher Portal Login'), findsOneWidget);
    expect(find.text('Login to Dashboard'), findsOneWidget);
  });

  testWidgets('App root with initialRoute (Attendance History)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MyApp(initialRoute: AppRoutes.attendanceHistory),
    );
    expect(find.text('Attendance History'), findsOneWidget);
    expect(find.text('Advanced Physics 401'), findsOneWidget);
  });

  testWidgets('Login screen renders cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    expect(find.text('SKY COACHING'), findsOneWidget);
    expect(find.text('Teacher Portal Login'), findsOneWidget);
    expect(find.text('Login to Dashboard'), findsOneWidget);
  });

  testWidgets('My Classes screen renders cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeView()));
    expect(find.text('My Classes'), findsOneWidget);
    expect(find.text('Class 10-A'), findsOneWidget);
  });

  testWidgets('Subjects screen renders cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SubjectsView()));
    expect(find.text('Class 10-A - Subjects'), findsOneWidget);
    expect(find.text('Mathematics'), findsOneWidget);
  });

  testWidgets('Attendance screen renders cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AttendanceView()));
    expect(find.text('Class 10-A - Mathematics'), findsOneWidget);
    expect(find.text('Submit Attendance'), findsOneWidget);
  });

  testWidgets('Attendance Confirmation screen renders cleanly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: AttendanceConfirmationView()),
    );
    expect(find.text('Attendance Confirmation'), findsOneWidget);
    expect(find.text('Return to Subject List'), findsOneWidget);
  });

  testWidgets('Attendance History screen renders cleanly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AttendanceHistoryView()));
    expect(find.text('RECENT SUBMISSIONS'), findsOneWidget);
    expect(find.text('Mon, Oct 23'), findsOneWidget);
  });

  testWidgets('Submitted Attendance screen renders cleanly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SubmittedAttendanceView()));
    expect(find.text('Submitted Attendance\n- Aug 30, 2026'), findsOneWidget);
    expect(find.text('PREVIOUSLY SUBMITTED'), findsOneWidget);
  });

  testWidgets('Profile screen renders cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileView()));
    expect(find.text('Teacher Profile'), findsOneWidget);
    expect(find.text('Prof. Sarah Jenkins'), findsOneWidget);
    expect(find.text('Logout from Academy'), findsOneWidget);
  });

  testWidgets('Full inter-screen navigation flow works smoothly', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const MyApp());
    expect(find.text('Login to Dashboard'), findsOneWidget);

    // 1. Login -> Home
    await tester.tap(find.text('Login to Dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('My Classes'), findsOneWidget);

    // 2. Home -> Subjects (Tap Class 10-A)
    await tester.tap(find.text('Class 10-A'));
    await tester.pumpAndSettle();
    expect(find.text('Class 10-A - Subjects'), findsOneWidget);

    // 3. Subjects -> Attendance (Tap Mathematics)
    await tester.tap(find.text('Mathematics'));
    await tester.pumpAndSettle();
    expect(find.text('Class 10-A - Mathematics'), findsOneWidget);

    // 4. Attendance -> Attendance Confirmation (Submit Attendance)
    final submitFinder = find.text('Submit Attendance');
    await tester.ensureVisible(submitFinder);
    await tester.tap(submitFinder);
    await tester.pumpAndSettle();
    expect(find.text('Attendance\nSubmitted\nSuccessfully'), findsOneWidget);

    // 5. Attendance Confirmation -> Subjects (Return to Subject List)
    await tester.tap(find.text('Return to Subject List'));
    await tester.pumpAndSettle();
    expect(find.text('Class 10-A - Subjects'), findsOneWidget);

    // 6. Subjects -> Home (via ACADEMICS back button)
    await tester.tap(find.text('ACADEMICS'));
    await tester.pumpAndSettle();
    expect(find.text('My Classes'), findsOneWidget);

    // 7. Home -> Attendance History (via History bottom tab)
    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();
    expect(find.text('RECENT SUBMISSIONS'), findsOneWidget);

    // 8. History -> Submitted Attendance (Tap first submission row)
    await tester.tap(find.text('Mon, Oct 23'));
    await tester.pumpAndSettle();
    expect(find.text('PREVIOUSLY SUBMITTED'), findsOneWidget);

    // 9. Submitted Attendance -> Profile (via Profile bottom tab)
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Teacher Profile'), findsOneWidget);
    expect(find.text('Prof. Sarah Jenkins'), findsOneWidget);

    // 10. Profile -> Home (via Classes bottom tab)
    await tester.tap(find.text('Classes'));
    await tester.pumpAndSettle();
    expect(find.text('My Classes'), findsOneWidget);

    // 11. Home -> Submitted Attendance (via Sync bottom tab)
    await tester.tap(find.text('Sync'));
    await tester.pumpAndSettle();
    expect(find.text('PREVIOUSLY SUBMITTED'), findsOneWidget);

    // 12. Submitted Attendance -> Home (via Classes bottom tab)
    await tester.tap(find.text('Classes'));
    await tester.pumpAndSettle();
    expect(find.text('My Classes'), findsOneWidget);

    // 13. Home -> Login (via Logout button)
    await tester.tap(find.byIcon(Icons.logout_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Login to Dashboard'), findsOneWidget);
  });
}
