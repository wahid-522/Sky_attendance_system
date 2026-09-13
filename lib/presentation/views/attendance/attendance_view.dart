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
        Navigator.pushNamed(context, AppRoutes.attendanceConfirmation);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440.0),
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) {
                final int total = _viewModel.students.length;
                final int present = _viewModel.presentCount;
                final int absent = _viewModel.absentCount;
                final double progress = total > 0 ? present / total : 0.0;
                final int percentage = (progress * 100).round();

                return Column(
                  children: [
                    // Scrollable Main Content Area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          16.0,
                          16.0,
                          20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Back Navigation Link
                            InkWell(
                              onTap: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.subjects,
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 2.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE0F2FE),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back_rounded,
                                        size: 15.0,
                                        color: AppColors.primarySkyBlue,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Text(
                                      'BACK TO SUBJECTS',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primarySkyBlue,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12.0),

                            // Live Session Stats & Progress Card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.0,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x080284C7),
                                    blurRadius: 16.0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.classMathematicsTitle,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF0F172A),
                                                letterSpacing: -0.3,
                                              ),
                                            ),
                                            SizedBox(height: 3.0),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_rounded,
                                                  size: 12.0,
                                                  color: Color(0xFF64748B),
                                                ),
                                                SizedBox(width: 5.0),
                                                Flexible(
                                                  child: Text(
                                                    AppStrings.sessionDate,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFF64748B),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF0FDF4),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                            color: const Color(0xFFBBF7D0),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Text(
                                          '$percentage% Rate',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF16A34A),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14.0),

                                  // Progress Bar
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 8.0,
                                      backgroundColor: const Color(0xFFF1F5F9),
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            AppColors.primarySkyBlue,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 14.0),

                                  // Quick Metrics Row
                                  Row(
                                    children: [
                                      _buildLivePill(
                                        'Present',
                                        '$present',
                                        const Color(0xFFE0F2FE),
                                        AppColors.primarySkyBlue,
                                      ),
                                      const SizedBox(width: 8.0),
                                      _buildLivePill(
                                        'Absent',
                                        '$absent',
                                        const Color(0xFFFEE2E2),
                                        const Color(0xFFDC2626),
                                      ),
                                      const SizedBox(width: 8.0),
                                      _buildLivePill(
                                        'Total',
                                        '$total',
                                        const Color(0xFFF1F5F9),
                                        const Color(0xFF475569),
                                      ),
                                    ],
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
                                    height: 40.0,
                                    child: ElevatedButton.icon(
                                      onPressed: _viewModel.markAllPresent,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primarySkyBlue,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.check_circle_rounded,
                                        size: 16.0,
                                      ),
                                      label: const Text(
                                        AppStrings.markAllPresent,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),

                                // Mark all absent
                                Expanded(
                                  child: SizedBox(
                                    height: 40.0,
                                    child: OutlinedButton.icon(
                                      onPressed: _viewModel.markAllAbsent,
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0xFFDC2626),
                                        side: const BorderSide(
                                          color: Color(0xFFFECDD3),
                                          width: 1.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.highlight_off_rounded,
                                        size: 16.0,
                                      ),
                                      label: const Text(
                                        AppStrings.markAllAbsent,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w700,
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
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.0,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x050F172A),
                                    blurRadius: 8.0,
                                    offset: Offset(0, 2),
                                  ),
                                  BoxShadow(
                                    color: Color(0x0A0284C7),
                                    blurRadius: 18.0,
                                    offset: Offset(0, 6),
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
                                      showDivider:
                                          index !=
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

                            // Submit Attendance Button
                            SizedBox(
                              width: double.infinity,
                              height: 48.0,
                              child: ElevatedButton(
                                onPressed: _viewModel.isSubmitting
                                    ? null
                                    : _onSubmitPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primarySkyBlue,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shadowColor: const Color(0x300284C7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                child: _viewModel.isSubmitting
                                    ? const SizedBox(
                                        width: 20.0,
                                        height: 20.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.2,
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
                                          Icon(Icons.send_rounded, size: 17.0),
                                          SizedBox(width: 8.0),
                                          Text(
                                            AppStrings.submitAttendance,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
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
                      onTap: (index) =>
                          HomeBottomNavBar.navigateToTab(context, 0, index),
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

  Widget _buildLivePill(
    String label,
    String count,
    Color bg,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
