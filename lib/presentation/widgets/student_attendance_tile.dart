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
    final List<String> nameParts = student.name.split(' ');
    final String initials = nameParts.length > 1
        ? '${nameParts[0][0]}${nameParts[1][0]}'
        : student.name.substring(0, 1);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            children: [
              // Initials Avatar Badge
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color(0xFFBAE6FD),
                    width: 1.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primarySkyBlue,
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
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Roll #${student.rollNumber}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Modern Segmented Toggle Control
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Present Toggle
                    InkWell(
                      onTap: () => onStatusChanged(AttendanceStatus.present),
                      borderRadius: BorderRadius.circular(6.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: isPresent
                              ? AppColors.primarySkyBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: isPresent
                              ? const [
                                  BoxShadow(
                                    color: Color(0x200284C7),
                                    blurRadius: 4.0,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_rounded,
                              size: 13.0,
                              color: isPresent
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                            const SizedBox(width: 3.0),
                            Text(
                              'Present',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: isPresent
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isPresent
                                    ? Colors.white
                                    : const Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Absent Toggle
                    InkWell(
                      onTap: () => onStatusChanged(AttendanceStatus.absent),
                      borderRadius: BorderRadius.circular(6.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: !isPresent
                              ? const Color(0xFFEF4444)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: !isPresent
                              ? const [
                                  BoxShadow(
                                    color: Color(0x25EF4444),
                                    blurRadius: 4.0,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.close_rounded,
                              size: 13.0,
                              color: !isPresent
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                            const SizedBox(width: 3.0),
                            Text(
                              'Absent',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: !isPresent
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: !isPresent
                                    ? Colors.white
                                    : const Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
