import 'package:flutter/material.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/domain/entities/class_entity.dart';

class ClassCard extends StatelessWidget {
  final ClassEntity classItem;
  final VoidCallback? onTap;

  const ClassCard({super.key, required this.classItem, this.onTap});

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Advanced Gradient Icon Badge with Shadow
                Container(
                  width: 52.0,
                  height: 52.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: const Color(0xFFBAE6FD),
                      width: 1.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x120284C7),
                        blurRadius: 8.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.groups_rounded,
                    size: 26.0,
                    color: AppColors.primarySkyBlue,
                  ),
                ),
                const SizedBox(width: 14.0),

                // Class Details & Metadata Chips
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              classItem.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          // Live active pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: const Color(0xFFBBF7D0),
                                width: 0.8,
                              ),
                            ),
                            child: const Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        classItem.subject,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Metadata Tags Wrap
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 4.0,
                        children: [
                          // Student Count Chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 3.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F7FF),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: const Color(0xFFE0EDFB),
                                width: 0.8,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.person_outline_rounded,
                                  size: 12.0,
                                  color: AppColors.primarySkyBlue,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${classItem.studentCount} Students',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primarySkyBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Session Tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 3.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 0.8,
                              ),
                            ),
                            child: const Text(
                              'Daily Session',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500,
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

                // Trailing Action Button
                Container(
                  width: 34.0,
                  height: 34.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F7FF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0x99BAE6FD),
                      width: 1.0,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16.0,
                    color: AppColors.primarySkyBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
