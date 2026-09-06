import 'package:flutter/material.dart';
import 'package:sky_attendance/domain/entities/student_entity.dart';

class AttendanceViewModel extends ChangeNotifier {
  // In reference image 2, tab 0 (Classes) has the mint pill
  int _selectedNavIndex = 0;
  bool _isSubmitting = false;

  int get selectedNavIndex => _selectedNavIndex;
  bool get isSubmitting => _isSubmitting;

  late List<StudentEntity> _students;
  List<StudentEntity> get students => _students;

  AttendanceViewModel() {
    _initStudents();
  }

  void _initStudents() {
    _students = List.generate(40, (index) {
      final num = index + 1;
      final roll = '10A-${num.toString().padLeft(3, '0')}';
      return StudentEntity(
        id: 'std_$num',
        name: 'Student $num',
        rollNumber: roll,
        status: AttendanceStatus.present,
      );
    });
  }

  void markAllPresent() {
    _students = _students
        .map((s) => s.copyWith(status: AttendanceStatus.present))
        .toList();
    notifyListeners();
  }

  void markAllAbsent() {
    _students = _students
        .map((s) => s.copyWith(status: AttendanceStatus.absent))
        .toList();
    notifyListeners();
  }

  void toggleStudentStatus(String id, AttendanceStatus status) {
    _students = _students.map((s) {
      if (s.id == id) {
        return s.copyWith(status: status);
      }
      return s;
    }).toList();
    notifyListeners();
  }

  void selectTab(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  void submitAttendance({required VoidCallback onSuccess}) {
    _isSubmitting = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 600), () {
      _isSubmitting = false;
      notifyListeners();
      onSuccess();
    });
  }
}
