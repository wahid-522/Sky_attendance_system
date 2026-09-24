class ClassModel {
  final String classId;    // e.g. "9th"
  final String className;
  final List<String> subjects;
  final int studentCount;

  const ClassModel({
    required this.classId,
    required this.className,
    this.subjects = const [],
    this.studentCount = 0,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      classId:      json['classId']?.toString()  ?? '',
      className:    json['className']?.toString() ?? '',
      subjects: (json['subjects'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      studentCount: (json['studentCount'] as num?)?.toInt() ?? 0,
    );
  }
}
