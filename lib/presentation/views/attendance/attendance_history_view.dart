import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/presentation/viewmodels/attendance_history_viewmodel.dart';
import 'package:sky_attendance/presentation/widgets/home_bottom_nav_bar.dart';

class AttendanceHistoryView extends StatefulWidget {
  const AttendanceHistoryView({super.key});

  @override
  State<AttendanceHistoryView> createState() => _AttendanceHistoryViewState();
}

class _AttendanceHistoryViewState extends State<AttendanceHistoryView> {
  late final AttendanceHistoryViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AttendanceHistoryViewModel();
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
        title: const Text(
          AppStrings.attendanceHistoryHeaderTitle,
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

                    // Scrollable Main Content Area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          18.0,
                          16.0,
                          16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Course Title
                            Text(
                              _viewModel.courseTitle,
                              style: const TextStyle(
                                fontSize: 22.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0A1C30),
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 6.0),

                            // Subtitle
                            Text(
                              _viewModel.courseSubtitle,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 20.0),

                            // History Submissions Card
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
                                children: [
                                  // Card Top Header
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.historyHeaderBoxBg,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          AppStrings.recentSubmissionsLabel,
                                          style: TextStyle(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                AppColors.historyHeaderBoxText,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Filter clicked'),
                                                backgroundColor:
                                                    AppColors.buttonNavy,
                                                duration:
                                                    Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.filter_list_rounded,
                                                size: 14.0,
                                                color:
                                                    AppColors.historyFilterText,
                                              ),
                                              SizedBox(width: 4.0),
                                              Text(
                                                AppStrings.filterAction,
                                                style: TextStyle(
                                                  fontSize: 11.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .historyFilterText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Submission Rows
                                  ...List.generate(
                                    _viewModel.historyItems.length,
                                    (index) {
                                      final item =
                                          _viewModel.historyItems[index];
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.submittedAttendance,
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 14.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Date & Time Column
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          item.dateTitle,
                                                          style: const TextStyle(
                                                            fontSize: 15.5,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Color(0xFF0F172A),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 3.0),
                                                        Text(
                                                          item.timeAndType,
                                                          style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color(0xFF64748B),
                                                            height: 1.25,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8.0),

                                                  // Status Badge & Chevron
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 3.5,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .historySubmittedBadgeBg,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4.0),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .historySubmittedBadgeBorder,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: const Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .check_circle_outline_rounded,
                                                              size: 13.0,
                                                              color: AppColors
                                                                  .historySubmittedBadgeText,
                                                            ),
                                                            SizedBox(width: 4.0),
                                                            Text(
                                                              AppStrings
                                                                  .submittedStatusLabel,
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColors
                                                                    .historySubmittedBadgeText,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10.0),
                                                      const Icon(
                                                        Icons
                                                            .chevron_right_rounded,
                                                        size: 18.0,
                                                        color: Color(0xFF94A3B8),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (index !=
                                              _viewModel.historyItems.length -
                                                  1)
                                            const Divider(
                                              height: 1.0,
                                              thickness: 1.0,
                                              color: Color(0xFFE5E7EB),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Navigation Bar
                    HomeBottomNavBar(
                      currentIndex: 1,
                      onTap: (index) => HomeBottomNavBar.navigateToTab(
                        context,
                        1,
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
