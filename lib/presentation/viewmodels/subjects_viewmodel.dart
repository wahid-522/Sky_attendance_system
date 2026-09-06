import 'package:flutter/material.dart';
import 'package:sky_attendance/domain/entities/subject_entity.dart';

class SubjectsViewModel extends ChangeNotifier {
  // Active tab 0 (Classes)
  int _selectedNavIndex = 0;

  int get selectedNavIndex => _selectedNavIndex;

  final List<SubjectEntity> subjects = const [
    SubjectEntity(
      id: 'sub_1',
      name: 'Mathematics',
      description: 'Advanced Algebra & Calculus',
      category: 'Core',
      enrolledCount: 32,
      symbolType: 'math',
    ),
    SubjectEntity(
      id: 'sub_2',
      name: 'Physics',
      description: 'Mechanics & Thermodynamics',
      category: 'Core',
      enrolledCount: 32,
      symbolType: 'physics',
    ),
    SubjectEntity(
      id: 'sub_3',
      name: 'English Literature',
      description: 'Modern Prose & Poetry',
      category: 'Language',
      enrolledCount: 32,
      symbolType: 'literature',
    ),
  ];

  void selectTab(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }
}
