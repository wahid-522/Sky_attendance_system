class AttendanceHistoryItemEntity {
  final String id;
  final String dateTitle;
  final String timeAndType;
  final String status;

  const AttendanceHistoryItemEntity({
    required this.id,
    required this.dateTitle,
    required this.timeAndType,
    this.status = 'Submitted',
  });
}
