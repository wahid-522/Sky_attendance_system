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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.myClassesHeaderTitle,
          style: TextStyle(
            color: AppColors.headerBlue,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
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
                    // Top App Header
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
                                  color: AppColors.lightBlueBorder,
                                  width: 1.2,
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE0F2FE),
                                    Color(0xFFBAE6FD),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const ClipOval(
                                child: Icon(
                                  Icons.person,
                                  size: 22.0,
                                  color: AppColors.primarySkyBlue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),

                          // Academy Name
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

                    // Main Scrollable Area
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
                            // "My Classes" & "Online" Status Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  AppStrings.myClassesTitle,
                                  style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F172A),
                                    letterSpacing: -0.2,
                                  ),
                                ),

                                // Online Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9.0,
                                    vertical: 3.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.onlineBadgeBg,
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: AppColors.onlineBadgeBorder,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.cloud_done_rounded,
                                        size: 13.0,
                                        color: AppColors.onlineBadgeText,
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        AppStrings.statusOnline,
                                        style: TextStyle(
                                          color: AppColors.onlineBadgeText,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),

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
}
