class AttendanceConfirmationEntity {
  final String subjectName;
  final String sessionDate;
  final String submissionTimestamp;
  final int presentCount;
  final int absentCount;

  const AttendanceConfirmationEntity({
    required this.subjectName,
    required this.sessionDate,
    required this.submissionTimestamp,
    required this.presentCount,
    required this.absentCount,
  });
}
