import 'package:flutter/material.dart';
import '../../core/session/app_session.dart';
import '../../data/repositories/attendance_repository.dart';
import '../../domain/entities/subject_entity.dart';

class SubjectsViewModel extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();

  List<SubjectEntity> get subjects => _subjects;

  // Start empty — real data comes from API
  List<SubjectEntity> _subjects = const [];

  String get pageTitle => _pageTitle;
  String _pageTitle = 'Subjects';

  SubjectsViewModel() {
    final classId = AppSession.instance.selectedClassId;
    if (classId.isNotEmpty) {
      _pageTitle = 'Class ${AppSession.instance.selectedClassName.replaceFirst("Class ", "")} - Subjects';
      _loadSubjects(classId);
    }
  }

  Future<void> _loadSubjects(String classId) async {
    try {
      final models = await _repo.getSubjectsForClass(classId);
      if (models.isNotEmpty) {
        _subjects = models.map((m) => SubjectEntity(
              id:            m.id.isNotEmpty ? m.id : m.name,
              name:          m.name,
              description:   m.days.isNotEmpty ? m.days.join(', ') : 'No schedule set',
              category:      'Core',
              enrolledCount: m.enrolledCount,
              symbolType:    _symbolFor(m.name),
            )).toList();
        notifyListeners();
      } else {
        _subjects = [];
        notifyListeners();
      }
    } catch (_) {
      // Keep placeholder on error
    }
  }

  Future<void> loadSubjects(String classId) => _loadSubjects(classId);

  static String _symbolFor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('math'))    return 'math';
    if (lower.contains('physics')) return 'physics';
    if (lower.contains('english') ||
        lower.contains('urdu')    ||
        lower.contains('literature')) return 'literature';
    return 'math';
  }
}
