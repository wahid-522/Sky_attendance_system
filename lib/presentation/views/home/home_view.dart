import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/presentation/viewmodels/home_viewmodel.dart';
import 'package:sky_attendance/presentation/widgets/class_card.dart';
import 'package:sky_attendance/presentation/widgets/home_bottom_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
                return Column(
                  children: [
                    // Main Scrollable Area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          18.0,
                          16.0,
                          20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hero Executive Stats Deck
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0284C7),
                                    Color(0xFF0369A1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(18.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x280284C7),
                                    blurRadius: 18.0,
                                    offset: Offset(0, 8),
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
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.verified_rounded,
                                            size: 16.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 6.0),
                                          Text(
                                            'Today\'s Overview',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 3.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0x2EFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: const Text(
                                          'Term 2026',
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    children: [
                                      _buildHeroMetric(
                                        '3',
                                        'Classes',
                                        Icons.school_rounded,
                                      ),
                                      _buildMetricDivider(),
                                      _buildHeroMetric(
                                        '90',
                                        'Students',
                                        Icons.groups_rounded,
                                      ),
                                      _buildMetricDivider(),
                                      _buildHeroMetric(
                                        '96.4%',
                                        'Attendance',
                                        Icons.trending_up_rounded,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 22.0),

                            // "My Classes" & Status Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.myClassesTitle,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF0F172A),
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        'Select a class to manage attendance',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8.0),

                                // Modern Pulse Online Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0F2FE),
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: const Color(0xFFBAE6FD),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.cloud_done_rounded,
                                        size: 13.0,
                                        color: AppColors.primarySkyBlue,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        'Synced',
                                        style: TextStyle(
                                          color: AppColors.primarySkyBlue,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4.0),

                                // Logout Action
                                IconButton(
                                  icon: const Icon(
                                    Icons.logout_rounded,
                                    size: 20.0,
                                    color: Color(0xFF64748B),
                                  ),
                                  tooltip: 'Logout',
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.login,
                                      (route) => false,
                                    );
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 32.0,
                                    minHeight: 32.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14.0),

                            // Class Cards List
                            ..._viewModel.classes.map(
                              (classItem) => ClassCard(
                                classItem: classItem,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.subjects,
                                  );
                                },
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

  Widget _buildHeroMetric(String value, String label, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14.0, color: const Color(0xFFBAE6FD)),
              const SizedBox(width: 4.0),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFE0F2FE),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricDivider() {
    return Container(
      width: 1.0,
      height: 36.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      color: const Color(0x33FFFFFF),
    );
  }
}
