import 'package:flutter/material.dart';
import '../../core/session/app_session.dart';
import '../../data/repositories/attendance_repository.dart';
import '../../domain/entities/class_entity.dart';

class HomeViewModel extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();

  bool              get isOnline => true;
  List<ClassEntity> get classes  => _classes;

  // ── Real stats (populated from API) ─────────────────────────────────────
  // NOTE: HomeView currently hardcodes '3', '90', '96.4%' as literal strings.
  // These getters are ready for when the view is updated to read from viewmodel.
  int    get totalClasses   => _classes.length;
  int    get totalStudents  => _classes.fold(0, (sum, c) => sum + c.studentCount);
  String get attendanceRate => _attendanceRate;

  String _attendanceRate = '0.0%';

  List<ClassEntity> _classes = const [];

  HomeViewModel() {
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    try {
      final models = await _repo.getMyClasses();
      _classes = models.map((m) => ClassEntity(
            id:           m.classId,
            name:         'Class ${m.className}',
            subject:      m.subjects.isNotEmpty ? m.subjects.join(', ') : '—',
            studentCount: m.studentCount,
          )).toList();

      if (_classes.isNotEmpty) {
        AppSession.instance.selectedClassId   = _classes.first.id;
        AppSession.instance.selectedClassName = _classes.first.name;

        // Calculate real attendance rate from history
        _calculateAttendanceRate();
      }

      notifyListeners();
    } catch (_) {
      notifyListeners();
    }
  }

  Future<void> _calculateAttendanceRate() async {
    try {
      final history = await _repo.getHistory();
      if (history.isEmpty) {
        _attendanceRate = '0.0%';
        notifyListeners();
        return;
      }
      final totalPresent = history.fold(0, (s, h) => s + h.presentCount);
      final totalAll     = history.fold(0, (s, h) => s + h.totalStudents);
      if (totalAll > 0) {
        final rate = (totalPresent / totalAll * 100).toStringAsFixed(1);
        _attendanceRate = '$rate%';
        notifyListeners();
      }
    } catch (_) {}
  }

  void selectClass(ClassEntity c) {
    AppSession.instance.selectedClassId   = c.id;
    AppSession.instance.selectedClassName = c.name;
  }

  void refresh() => _loadClasses();
}
