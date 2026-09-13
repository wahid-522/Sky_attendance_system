import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/presentation/viewmodels/subjects_viewmodel.dart';
import 'package:sky_attendance/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:sky_attendance/presentation/widgets/subject_card.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  late final SubjectsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SubjectsViewModel();
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
                    // Main Content Body
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
                            // Back Navigation & Academics Breadcrumb
                            InkWell(
                              onTap: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.home,
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 4.0,
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
                                      AppStrings.academicsLabel,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primarySkyBlue,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14.0),

                            // Main Title: Class 10-A - Subjects
                            const Text(
                              AppStrings.class10ASubjectsTitle,
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Choose a subject module to record attendance',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 18.0),

                            // Subject Cards List
                            ..._viewModel.subjects.map(
                              (subject) => SubjectCard(
                                subject: subject,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.attendance,
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
