import 'package:flutter/material.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/domain/entities/attendance_record_entity.dart';

class AttendanceStudentCard extends StatelessWidget {
  final StudentAttendanceRecord record;

  const AttendanceStudentCard({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPresent = record.isPresent;

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: isPresent ? Colors.white : AppColors.studentAbsentCardBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isPresent
              ? AppColors.cardBorder
              : AppColors.studentAbsentCardBorder,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          // Initials Avatar Box
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: isPresent
                  ? const Color(0xFFEEF2F6)
                  : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: isPresent
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFFFECDD3),
                width: 1.0,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              record.initials,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: isPresent
                    ? const Color(0xFF334155)
                    : const Color(0xFFB91C1C),
              ),
            ),
          ),
          const SizedBox(width: 12.0),

          // Student Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  record.name,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'ID: ${record.studentId}',
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // Status Badge Pill
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: isPresent
                  ? AppColors.studentPresentPillBg
                  : AppColors.studentAbsentPillBg,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPresent
                      ? Icons.how_to_reg_rounded
                      : Icons.person_off_rounded,
                  size: 13.0,
                  color: isPresent
                      ? AppColors.studentPresentPillText
                      : AppColors.studentAbsentPillText,
                ),
                const SizedBox(width: 4.0),
                Text(
                  isPresent ? 'Present' : 'Absent',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    color: isPresent
                        ? AppColors.studentPresentPillText
                        : AppColors.studentAbsentPillText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
