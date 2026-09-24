/// Lightweight singleton that holds the instructor's current navigation state.
/// Used to pass selected class/subject between screens without modifying views.
class AppSession {
  AppSession._();
  static final AppSession instance = AppSession._();

  String selectedClassId   = '';
  String selectedClassName = '';
  String selectedSubject   = '';
  String selectedSubjectId = '';

  // Attendance confirmation data — set after submit, read by confirmation view
  Map<String, dynamic>? lastSubmitResponse;
}
