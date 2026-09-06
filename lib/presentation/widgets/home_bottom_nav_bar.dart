import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  static void navigateToTab(
    BuildContext context,
    int currentIndex,
    int targetIndex,
  ) {
    if (currentIndex == targetIndex) {
      if (targetIndex == 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sync completed • All records up to date'),
            backgroundColor: AppColors.buttonNavy,
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    switch (targetIndex) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.attendanceHistory,
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.submittedAttendance,
          (route) => false,
        );
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.profile,
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.dividerColor,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                index: 0,
                icon: Icons.school_rounded,
                label: AppStrings.navClasses,
              ),
              _buildNavItem(
                context: context,
                index: 1,
                icon: Icons.history_rounded,
                label: AppStrings.navHistory,
              ),
              _buildNavItem(
                context: context,
                index: 2,
                icon: Icons.sync_rounded,
                label: AppStrings.navSync,
              ),
              _buildNavItem(
                context: context,
                index: 3,
                icon: Icons.person_rounded,
                label: AppStrings.navProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(index);
        } else {
          navigateToTab(context, currentIndex, index);
        }
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.navActivePill,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Icon(
                  icon,
                  size: 20.0,
                  color: AppColors.navActiveIcon,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Icon(
                  icon,
                  size: 20.0,
                  color: AppColors.navInactive,
                ),
              ),
            const SizedBox(height: 3.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.navTextActive
                    : AppColors.navInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
