import 'package:flutter/material.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/domain/entities/student_entity.dart';

class StudentAttendanceTile extends StatelessWidget {
  final StudentEntity student;
  final ValueChanged<AttendanceStatus> onStatusChanged;
  final bool showDivider;

  const StudentAttendanceTile({
    super.key,
    required this.student,
    required this.onStatusChanged,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPresent = student.status == AttendanceStatus.present;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 11.0),
          child: Row(
            children: [
              // Avatar Placeholder Box
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: AppColors.studentAvatarBorder,
                    width: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 14.0),

              // Student Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Roll: ${student.rollNumber}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              // Present Button
              InkWell(
                onTap: () => onStatusChanged(AttendanceStatus.present),
                borderRadius: BorderRadius.circular(4.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: isPresent ? AppColors.presentTeal : Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    border: isPresent
                        ? null
                        : Border.all(color: AppColors.absentBorder, width: 1.0),
                  ),
                  child: Text(
                    'Present',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isPresent ? FontWeight.w600 : FontWeight.w500,
                      color: isPresent ? Colors.white : AppColors.absentText,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),

              // Absent Button
              InkWell(
                onTap: () => onStatusChanged(AttendanceStatus.absent),
                borderRadius: BorderRadius.circular(4.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: !isPresent ? const Color(0xFFDC2626) : Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    border: !isPresent
                        ? null
                        : Border.all(color: AppColors.absentBorder, width: 1.0),
                  ),
                  child: Text(
                    'Absent',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: !isPresent
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: !isPresent ? Colors.white : AppColors.absentText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFF1F5F9)),
      ],
    );
  }
}
