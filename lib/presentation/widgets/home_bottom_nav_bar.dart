import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const HomeBottomNavBar({super.key, required this.currentIndex, this.onTap});

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
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080284C7),
            blurRadius: 16.0,
            offset: Offset(0, -4),
          ),
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 4.0,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 18.0 : 12.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE0F2FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Icon(
                icon,
                size: 21.0,
                color: isSelected
                    ? AppColors.primarySkyBlue
                    : const Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 3.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.primarySkyBlue
                    : const Color(0xFF64748B),
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
