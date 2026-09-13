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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.confirmationHeaderTitle,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24.0, 34.0, 24.0, 28.0),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: AppColors.cardBorder, width: 1.0),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 20.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Success Badge
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: AppColors.confirmationBadgeNavy,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 30.0,
                        color: AppColors.confirmationBadgeIcon,
                      ),
                    ),
                    const SizedBox(height: 22.0),

                    // Heading
                    const Text(
                      '${AppStrings.attendanceLine1}\n${AppStrings.attendanceLine2}\n${AppStrings.attendanceLine3}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF091E3A),
                        letterSpacing: -0.2,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    // Subtitle
                    const Text(
                      AppStrings.submissionTimestampText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF475569),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22.0),

                    // Subject Session Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: AppColors.confirmationSessionBg,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: AppColors.confirmationSessionBorder,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.school_outlined,
                                size: 15.0,
                                color: Color(0xFF475569),
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                AppStrings.subjectSessionLabel,
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            confirmation.subjectName,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F2847),
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
                    const SizedBox(height: 14.0),

                    // Stats Row: Present & Absent
                    Row(
                      children: [
                        // Present Box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            decoration: BoxDecoration(
                              color: AppColors.statPresentBg,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${confirmation.presentCount}',
                                  style: const TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.statPresentText,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                const Text(
                                  AppStrings.presentStatLabel,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.statPresentText,
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
                              color: AppColors.statAbsentBg,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${confirmation.absentCount}',
                                  style: const TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.statAbsentText,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                const Text(
                                  AppStrings.absentStatLabel,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.statAbsentText,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22.0),

                    // Return to Subject List Button
                    SizedBox(
                      width: double.infinity,
                      height: 44.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.subjects,
                            (route) => route.settings.name == AppRoutes.home,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonNavy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
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
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
