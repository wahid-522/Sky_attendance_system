import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/domain/entities/subject_entity.dart';

class SubjectCard extends StatelessWidget {
  final SubjectEntity subject;
  final VoidCallback? onTap;

  const SubjectCard({super.key, required this.subject, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Icon Badge & Category Pill
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLeadingIcon(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pillCoreBg,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        subject.category,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pillCoreText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),

                // Title & Subtitle
                Text(
                  subject.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subject.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 14.0),

                // Subtle Inner Divider
                Container(height: 1.0, color: const Color(0xFFF1F5F9)),
                const SizedBox(height: 12.0),

                // Bottom Row: Enrolled Stats & Action Arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.studentsLabel,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '${subject.enrolledCount} Enrolled',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F2847),
                          ),
                        ),
                      ],
                    ),

                    // Action Arrow Circle
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.actionCircleBg,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 15.0,
                        color: AppColors.actionCircleIcon,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    switch (subject.symbolType) {
      case 'math':
        return Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: AppColors.mathIconBg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Σ',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w800,
              color: AppColors.mathIconColor,
            ),
          ),
        );
      case 'physics':
        return Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: AppColors.physicsIconBg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.science_outlined,
            size: 22.0,
            color: AppColors.physicsIconColor,
          ),
        );
      case 'literature':
      default:
        return Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: AppColors.literatureIconBg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.menu_book_rounded,
            size: 20.0,
            color: AppColors.literatureIconColor,
          ),
        );
    }
  }
}
