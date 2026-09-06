import 'package:flutter/material.dart';
import 'package:sky_attendance/domain/entities/attendance_record_entity.dart';

class SubmittedAttendanceViewModel extends ChangeNotifier {
  // Active tab 2 (Sync / Submitted Attendance)
  int _selectedNavIndex = 2;

  int get selectedNavIndex => _selectedNavIndex;

  final int totalStudents = 32;
  final int presentCount = 28;
  final int absentCount = 4;
  final String attendanceRate = '87.5%';

  final List<StudentAttendanceRecord> students = const [
    StudentAttendanceRecord(
      id: 'rec_1',
      name: 'Alex Johnson',
      initials: 'AJ',
      studentId: '10A-001',
      isPresent: true,
    ),
    StudentAttendanceRecord(
      id: 'rec_2',
      name: 'Bella Patel',
      initials: 'BP',
      studentId: '10A-002',
      isPresent: true,
    ),
    StudentAttendanceRecord(
      id: 'rec_3',
      name: 'Cameron Davis',
      initials: 'CD',
      studentId: '10A-003',
      isPresent: false,
    ),
  ];

  void selectTab(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }
}
