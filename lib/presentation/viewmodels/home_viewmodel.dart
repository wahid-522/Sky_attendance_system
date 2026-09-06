import 'package:flutter/material.dart';
import 'package:sky_attendance/domain/entities/class_entity.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedNavIndex = 0;
  final bool _isOnline = true;

  int get selectedNavIndex => _selectedNavIndex;
  bool get isOnline => _isOnline;

  final List<ClassEntity> classes = const [
    ClassEntity(
      id: '1',
      name: 'Class 10-A',
      subject: 'Mathematics',
      studentCount: 32,
    ),
    ClassEntity(
      id: '2',
      name: 'Class 12-B',
      subject: 'Advanced Calculus',
      studentCount: 28,
    ),
    ClassEntity(
      id: '3',
      name: 'Class 9-C',
      subject: 'Algebra I',
      studentCount: 30,
    ),
  ];

  void selectTab(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }
}
