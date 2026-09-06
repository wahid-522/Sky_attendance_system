import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/presentation/viewmodels/attendance_viewmodel.dart';
import 'package:sky_attendance/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:sky_attendance/presentation/widgets/student_attendance_tile.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  late final AttendanceViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AttendanceViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onSubmitPressed() {
    _viewModel.submitAttendance(
      onSuccess: () {
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          AppRoutes.attendanceConfirmation,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.markAttendanceHeaderTitle,
          style: TextStyle(
            color: Color(0xFF94A3B8),
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
                    // Inner Top Header Bar
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
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.profile,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              width: 32.0,
                              height: 32.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.2,
                                ),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFD6A265), Color(0xFF8B5E3C)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const ClipOval(
                                child: Icon(
                                  Icons.person,
                                  size: 22.0,
                                  color: Color(0xFFFDFBF7),
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

                          // Logout Icon
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

                    // Scrollable Main Content Area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          14.0,
                          16.0,
                          16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Class & Session Header
                            const Text(
                              AppStrings.classMathematicsTitle,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0A2540),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 6.0),

                            // Date Row
                            const Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 13.0,
                                  color: Color(0xFF64748B),
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  AppStrings.sessionDate,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),

                            // Ready to sync Box
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 6.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.syncBoxBg,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.cloud_outlined,
                                    size: 14.0,
                                    color: Color(0xFF475569),
                                  ),
                                  SizedBox(width: 6.0),
                                  Text(
                                    AppStrings.readyToSync,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.syncBoxText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14.0),

                            // Quick Action Buttons Row
                            Row(
                              children: [
                                // Mark all present
                                Expanded(
                                  child: SizedBox(
                                    height: 38.0,
                                    child: ElevatedButton.icon(
                                      onPressed: _viewModel.markAllPresent,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.presentTeal,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.check_circle_outline_rounded,
                                        size: 15.0,
                                      ),
                                      label: const Text(
                                        AppStrings.markAllPresent,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),

                                // Mark all absent
                                Expanded(
                                  child: SizedBox(
                                    height: 38.0,
                                    child: OutlinedButton.icon(
                                      onPressed: _viewModel.markAllAbsent,
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppColors.presentTeal,
                                        side: const BorderSide(
                                          color: AppColors.absentBorder,
                                          width: 1.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.highlight_off_rounded,
                                        size: 15.0,
                                      ),
                                      label: const Text(
                                        AppStrings.markAllAbsent,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14.0),

                            // Student Attendance List Card
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: AppColors.cardBorder,
                                  width: 1.0,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: List.generate(
                                  _viewModel.students.length,
                                  (index) {
                                    final student = _viewModel.students[index];
                                    return StudentAttendanceTile(
                                      student: student,
                                      showDivider: index !=
                                          _viewModel.students.length - 1,
                                      onStatusChanged: (status) {
                                        _viewModel.toggleStudentStatus(
                                          student.id,
                                          status,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 18.0),

                            // Submit Attendance Button (from Reference Image 2)
                            SizedBox(
                              width: double.infinity,
                              height: 46.0,
                              child: ElevatedButton(
                                onPressed: _viewModel.isSubmitting
                                    ? null
                                    : _onSubmitPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttonNavy,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                child: _viewModel.isSubmitting
                                    ? const SizedBox(
                                        width: 18.0,
                                        height: 18.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.send_rounded,
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            AppStrings.submitAttendance,
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
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

                    // Bottom Navigation Bar
                    HomeBottomNavBar(
                      currentIndex: 0,
                      onTap: (index) => HomeBottomNavBar.navigateToTab(
                        context,
                        0,
                        index,
                      ),
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
}
