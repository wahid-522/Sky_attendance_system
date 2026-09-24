import 'package:flutter/material.dart';
import '../../core/session/app_session.dart';
import '../../domain/entities/attendance_confirmation_entity.dart';

class AttendanceConfirmationViewModel extends ChangeNotifier {
  // Populated from real API response via setFromSubmitResponse()
  AttendanceConfirmationEntity _confirmation = AttendanceConfirmationEntity(
    subjectName:         AppSession.instance.selectedSubject.isNotEmpty
                           ? AppSession.instance.selectedSubject
                           : 'Session',
    sessionDate:         _todayFormatted(),
    submissionTimestamp: _nowTimestamp(),
    presentCount:        0,
    absentCount:         0,
  );

  AttendanceConfirmationEntity get confirmation => _confirmation;

  AttendanceConfirmationViewModel() {
    // Read real response stored by AttendanceViewModel after submit
    final response = AppSession.instance.lastSubmitResponse;
    if (response != null) {
      setFromSubmitResponse(response);
    }
  }

  /// Called by AttendanceView after successful API submit
  void setFromSubmitResponse(Map<String, dynamic> data) {
    final now = DateTime.now();
    _confirmation = AttendanceConfirmationEntity(
      subjectName:         data['subject']?.toString()     ?? _confirmation.subjectName,
      sessionDate:         _formatDate(
                             DateTime.tryParse(data['date']?.toString() ?? '') ?? now),
      submissionTimestamp: 'Submission received on: ${_formatDate(now)}\nat ${_formatTime(now)}',
      presentCount:        (data['presentCount']  as num?)?.toInt() ?? 0,
      absentCount:         (data['absentCount']   as num?)?.toInt() ?? 0,
    );
    notifyListeners();
  }

  static String _todayFormatted() => _formatDate(DateTime.now());
  static String _nowTimestamp() {
    final now = DateTime.now();
    return 'Submission received on: ${_formatDate(now)}\nat ${_formatTime(now)}';
  }

  static String _formatDate(DateTime d) {
    const months = ['','Jan','Feb','Mar','Apr','May','Jun',
                    'Jul','Aug','Sep','Oct','Nov','Dec'];
    const days   = ['Monday','Tuesday','Wednesday','Thursday',
                    'Friday','Saturday','Sunday'];
    return '${days[d.weekday - 1]}, ${months[d.month]} ${d.day}, ${d.year}';
  }

  static String _formatTime(DateTime d) {
    final h  = d.hour > 12 ? d.hour - 12 : (d.hour == 0 ? 12 : d.hour);
    final m  = d.minute.toString().padLeft(2, '0');
    final ap = d.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ap';
  }
}
