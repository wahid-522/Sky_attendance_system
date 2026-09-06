import 'package:flutter/material.dart';
import 'package:sky_attendance/domain/entities/attendance_confirmation_entity.dart';

class AttendanceConfirmationViewModel extends ChangeNotifier {
  final AttendanceConfirmationEntity confirmation =
      const AttendanceConfirmationEntity(
        subjectName: 'Mathematics',
        sessionDate: 'Aug 31, 2026',
        submissionTimestamp:
            'Submission received on: Aug 31, 2026\nat 09:42 AM',
        presentCount: 24,
        absentCount: 3,
      );
}
