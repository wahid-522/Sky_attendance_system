import 'package:flutter/material.dart';
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
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
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: const Color(0xFFBAE6FD),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        subject.category,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primarySkyBlue,
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
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subject.description,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 14.0),

                // Subtle Inner Divider
                Container(height: 1.0, color: const Color(0xFFF1F5F9)),
                const SizedBox(height: 12.0),

                // Bottom Row: Enrolled Stats & Action Pill
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.people_alt_outlined,
                            size: 15.0,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 6.0),
                          Flexible(
                            child: Text(
                              '${subject.enrolledCount} Enrolled Students',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),

                    // Action Pill Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F7FF),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: const Color(0xFFBAE6FD),
                          width: 1.0,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Mark',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primarySkyBlue,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 13.0,
                            color: AppColors.primarySkyBlue,
                          ),
                        ],
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
