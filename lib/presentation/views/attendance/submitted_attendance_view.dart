import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/presentation/viewmodels/submitted_attendance_viewmodel.dart';
import 'package:sky_attendance/presentation/widgets/attendance_student_card.dart';
import 'package:sky_attendance/presentation/widgets/home_bottom_nav_bar.dart';

class SubmittedAttendanceView extends StatefulWidget {
  const SubmittedAttendanceView({super.key});

  @override
  State<SubmittedAttendanceView> createState() =>
      _SubmittedAttendanceViewState();
}

class _SubmittedAttendanceViewState extends State<SubmittedAttendanceView> {
  late final SubmittedAttendanceViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SubmittedAttendanceViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF334155)),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.attendanceHistory,
              );
            }
          },
        ),
        title: const Text(
          AppStrings.submittedAttendanceHeaderTitle,
          style: TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420.0),
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) {
                return Column(
                  children: [
                    // Inner Top Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.dividerColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Teacher Avatar
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoutes.profile),
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              width: 32.0,
                              height: 32.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFCBD5E1),
                                  width: 1.2,
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF334155),
                                    Color(0xFF1E293B),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const ClipOval(
                                child: Icon(
                                  Icons.person,
                                  size: 22.0,
                                  color: Color(0xFFE2E8F0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),

                          // Academy Name: SKY COACHING ACADEMY
                          const Expanded(
                            child: Text(
                              AppStrings.headerAcademyName,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryNavy,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),

                          // Logout Action
                          IconButton(
                            icon: const Icon(
                              Icons.logout_rounded,
                              size: 20.0,
                              color: AppColors.primaryNavy,
                            ),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.login,
                                (route) => false,
                              );
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable Body
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          16.0,
                          16.0,
                          16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "PREVIOUSLY SUBMITTED" Status Pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.previouslySubmittedBg,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 13.0,
                                    color: AppColors.previouslySubmittedText,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    AppStrings.previouslySubmittedLabel,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.previouslySubmittedText,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),

                            // Screen Title
                            const Text(
                              AppStrings.submittedAttendanceTitle,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0A1C30),
                                letterSpacing: -0.3,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6.0),

                            // Subtitle
                            const Text(
                              AppStrings.submittedSubtitle,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF64748B),
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 18.0),

                            // 2x2 Metric Cards Grid
                            Row(
                              children: [
                                // Total Students Card
                                Expanded(
                                  child: _buildMetricCard(
                                    label: AppStrings.totalStudentsLabel,
                                    value: '${_viewModel.totalStudents}',
                                    backgroundColor: Colors.white,
                                    valueColor: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(width: 12.0),

                                // Present Card
                                Expanded(
                                  child: _buildMetricCard(
                                    label: AppStrings.presentMetricLabel,
                                    value: '${_viewModel.presentCount}',
                                    backgroundColor: AppColors.metricPresentBg,
                                    valueColor: AppColors.metricPresentText,
                                    labelColor: const Color(0xFF1E3A8A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              children: [
                                // Absent Card
                                Expanded(
                                  child: _buildMetricCard(
                                    label: AppStrings.absentMetricLabel,
                                    value: '${_viewModel.absentCount}',
                                    backgroundColor: AppColors.metricAbsentBg,
                                    borderColor: AppColors.metricAbsentBorder,
                                    valueColor: AppColors.metricAbsentText,
                                    labelColor: const Color(0xFFDC2626),
                                  ),
                                ),
                                const SizedBox(width: 12.0),

                                // Attendance Rate Card
                                Expanded(
                                  child: _buildMetricCard(
                                    label: AppStrings.attendanceRateLabel,
                                    value: _viewModel.attendanceRate,
                                    backgroundColor: Colors.white,
                                    valueColor: const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),

                            // Student Cards List
                            ..._viewModel.students.map(
                              (record) => AttendanceStudentCard(record: record),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Navigation Bar
                    HomeBottomNavBar(
                      currentIndex: 2,
                      onTap: (index) =>
                          HomeBottomNavBar.navigateToTab(context, 2, index),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required Color backgroundColor,
    required Color valueColor,
    Color? labelColor,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: borderColor ?? AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: labelColor ?? const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
