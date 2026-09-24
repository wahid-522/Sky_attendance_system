import 'package:flutter/material.dart';
import '../../data/repositories/attendance_repository.dart';
import '../../data/models/attendance_session_model.dart';
import '../../domain/entities/attendance_history_item_entity.dart';

class AttendanceHistoryViewModel extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();

  // ── Getters expected by AttendanceHistoryView ─────────────────────────────
  String get courseTitle    => _courseTitle;
  String get courseSubtitle => _courseSubtitle;

  /// historyItems — what the view iterates over
  List<AttendanceHistoryItemEntity> get historyItems => _historyItems;

  // ── Internal state ────────────────────────────────────────────────────────
  String _courseTitle    = 'My Attendance Sessions';
  String _courseSubtitle = 'All submitted sessions';

  List<AttendanceHistoryItemEntity> _historyItems = [
    const AttendanceHistoryItemEntity(
      id:          '1',
      dateTitle:   'Loading...',
      timeAndType: '',
      status:      'Submitted',
    ),
  ];

  AttendanceHistoryViewModel() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final sessions = await _repo.getHistory();
      if (sessions.isNotEmpty) {
        _courseTitle    = '${sessions.first.subject} — ${sessions.first.className}';
        _courseSubtitle = 'Fall Semester ${sessions.first.date.year}';
        _historyItems   = sessions.map(_toEntity).toList();
        notifyListeners();
      } else {
        _historyItems = [];
        notifyListeners();
      }
    } catch (_) {
      // Keep default placeholders on network error
    }
  }

  static AttendanceHistoryItemEntity _toEntity(AttendanceSessionModel s) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final dateTitle = '${months[s.date.month]} ${s.date.day}, ${s.date.year}';
    final timeAndType =
        '${s.subject} • ${s.presentCount}/${s.totalStudents} present';
    return AttendanceHistoryItemEntity(
      id:          s.sessionId,
      dateTitle:   dateTitle,
      timeAndType: timeAndType,
      status:      'Submitted',
    );
  }
}
