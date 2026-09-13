import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/presentation/viewmodels/profile_viewmodel.dart';
import 'package:sky_attendance/presentation/widgets/home_bottom_nav_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF334155),
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          AppStrings.profileHeaderTitle,
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
            child: Column(
              children: [
                // Top Academy Header Bar
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
                      // Avatar
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFBAE6FD),
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
                      const SizedBox(width: 10.0),
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

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Profile Info Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: AppColors.cardBorder,
                              width: 1.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.cardShadow,
                                blurRadius: 10.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Avatar Circle
                              Container(
                                width: 72.0,
                                height: 72.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFEEF4FE),
                                  border: Border.all(
                                    color: const Color(0xFFBFDBFE),
                                    width: 2.0,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 44.0,
                                  color: AppColors.primaryNavy,
                                ),
                              ),
                              const SizedBox(height: 12.0),

                              // Name
                              Text(
                                _viewModel.teacherName,
                                style: const TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4.0),

                              // Email
                              Text(
                                _viewModel.teacherEmail,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 12.0),

                              // Status Pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 4.0,
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

                              const SizedBox(height: 18.0),
                              const Divider(
                                height: 1.0,
                                color: AppColors.dividerColor,
                              ),
                              const SizedBox(height: 16.0),

                              // Metadata Rows
                              _buildInfoRow(
                                Icons.badge_outlined,
                                'Role',
                                _viewModel.teacherRole,
                              ),
                              const SizedBox(height: 12.0),
                              _buildInfoRow(
                                Icons.account_balance_outlined,
                                'Department',
                                _viewModel.department,
                              ),
                              const SizedBox(height: 12.0),
                              _buildInfoRow(
                                Icons.tag_rounded,
                                'Staff ID',
                                _viewModel.employeeId,
                              ),
                              const SizedBox(height: 12.0),
                              _buildInfoRow(
                                Icons.calendar_today_outlined,
                                'Semester',
                                _viewModel.semester,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Assigned Classes Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: AppColors.cardBorder,
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
                                    size: 18.0,
                                    color: AppColors.primaryNavy,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Assigned Classes',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12.0),
                              ..._viewModel.assignedClasses.map(
                                (c) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: const Color(0xFFE2E8F0),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                c['name']!,
                                                style: const TextStyle(
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF0F172A),
                                                ),
                                              ),
                                              Text(
                                                c['subject']!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 11.5,
                                                  color: Color(0xFF64748B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          c['students']!,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryNavy,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 46.0,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.login,
                                (route) => false,
                              );
                            },
                            icon: const Icon(Icons.logout_rounded, size: 18.0),
                            label: const Text(
                              'Logout from Academy',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonNavy,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Navigation Bar
                const HomeBottomNavBar(currentIndex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.0, color: const Color(0xFF64748B)),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }
}
