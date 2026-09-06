import 'package:flutter/material.dart';
import 'package:sky_attendance/domain/entities/attendance_history_item_entity.dart';

class AttendanceHistoryViewModel extends ChangeNotifier {
  // Default tab is 0 (Classes / Home) as shown in the device screenshot
  int _selectedNavIndex = 0;

  int get selectedNavIndex => _selectedNavIndex;

  final String courseTitle = 'Advanced Physics 401';
  final String courseSubtitle = 'Fall Semester 2023 • Lecture Hall B';

  final List<AttendanceHistoryItemEntity> historyItems = const [
    AttendanceHistoryItemEntity(
      id: 'hist_1',
      dateTitle: 'Mon, Oct 23',
      timeAndType: '10:00 AM • Regular\nClass',
      status: 'Submitted',
    ),
    AttendanceHistoryItemEntity(
      id: 'hist_2',
      dateTitle: 'Wed, Oct 18',
      timeAndType: '10:00 AM • Regular\nClass',
      status: 'Submitted',
    ),
    AttendanceHistoryItemEntity(
      id: 'hist_3',
      dateTitle: 'Mon, Oct 16',
      timeAndType: '10:00 AM • Regular\nClass',
      status: 'Submitted',
    ),
  ];

  void selectTab(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }
}
