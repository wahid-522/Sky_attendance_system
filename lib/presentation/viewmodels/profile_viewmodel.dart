import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final int selectedNavIndex = 3;

  final String teacherName = 'Prof. Sarah Jenkins';
  final String teacherEmail = 'instructor@skyacademy.edu';
  final String teacherRole = 'Senior Faculty Instructor';
  final String department = 'Department of Mathematics & Physics';
  final String employeeId = 'EMP-2026-401';
  final String semester = 'Fall Semester 2026';
  final String status = 'Online';

  final List<Map<String, String>> assignedClasses = const [
    {
      'name': 'Class 10-A',
      'subject': 'Mathematics & Calculus',
      'students': '32 Students',
    },
    {
      'name': 'Class 12-B',
      'subject': 'Advanced Physics 401',
      'students': '28 Students',
    },
    {
      'name': 'Class 9-C',
      'subject': 'Algebra I & Geometry',
      'students': '20 Students',
    },
  ];
}
