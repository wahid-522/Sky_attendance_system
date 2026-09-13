import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/presentation/viewmodels/attendance_confirmation_viewmodel.dart';

class AttendanceConfirmationView extends StatefulWidget {
  const AttendanceConfirmationView({super.key});

  @override
  State<AttendanceConfirmationView> createState() =>
      _AttendanceConfirmationViewState();
}

class _AttendanceConfirmationViewState
    extends State<AttendanceConfirmationView> {
  late final AttendanceConfirmationViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AttendanceConfirmationViewModel();
  }

  @override
  Widget build(BuildContext context) {
    final confirmation = _viewModel.confirmation;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(26.0, 36.0, 26.0, 30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x080F172A),
                      blurRadius: 12.0,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color(0x140284C7),
                      blurRadius: 28.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Text(
                        AppStrings.confirmationHeaderTitle,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primarySkyBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Glowing Checkmark Badge
                    Container(
                      width: 68.0,
                      height: 68.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0284C7), Color(0xFF38BDF8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x350284C7),
                            blurRadius: 20.0,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 36.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 18.0),

                    // Heading
                    const Text(
                      '${AppStrings.attendanceLine1}\n${AppStrings.attendanceLine2}\n${AppStrings.attendanceLine3}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.3,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Subtitle
                    const Text(
                      AppStrings.submissionTimestampText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22.0),

                    // Subject Session Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.school_rounded,
                                size: 16.0,
                                color: AppColors.primarySkyBlue,
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                AppStrings.subjectSessionLabel,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primarySkyBlue,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            confirmation.subjectName,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            confirmation.sessionDate,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Stats Row: Present & Absent
                    Row(
                      children: [
                        // Present Box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2FE),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: const Color(0xFFBAE6FD),
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${confirmation.presentCount}',
                                  style: const TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primarySkyBlue,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                const Text(
                                  AppStrings.presentStatLabel,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primarySkyBlue,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12.0),

                        // Absent Box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: const Color(0xFFFECDD3),
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${confirmation.absentCount}',
                                  style: const TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFDC2626),
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                const Text(
                                  AppStrings.absentStatLabel,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFDC2626),
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),

                    // Return to Subject List Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.subjects,
                            (route) => route.settings.name == AppRoutes.home,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primarySkyBlue,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: const Color(0x300284C7),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back_rounded, size: 16.0),
                            SizedBox(width: 8.0),
                            Flexible(
                              child: Text(
                                AppStrings.returnToSubjectList,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    // View History Secondary Action
                    SizedBox(
                      width: double.infinity,
                      height: 44.0,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.attendanceHistory,
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF475569),
                          side: const BorderSide(
                            color: Color(0xFFCBD5E1),
                            width: 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history_rounded, size: 16.0),
                            SizedBox(width: 8.0),
                            Flexible(
                              child: Text(
                                'View Attendance History',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
