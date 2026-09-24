class SubjectModel {
  final String id;
  final String name;
  final List<String> days;
  final String startTime;
  final String endTime;
  final String room;
  final int enrolledCount;

  const SubjectModel({
    required this.id,
    required this.name,
    this.days = const [],
    this.startTime = '',
    this.endTime = '',
    this.room = '',
    this.enrolledCount = 0,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id:   json['id']?.toString()   ?? json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      startTime:    json['startTime']?.toString()    ?? '',
      endTime:      json['endTime']?.toString()      ?? '',
      room:         json['room']?.toString()         ?? '',
      enrolledCount:(json['enrolledCount'] as num?)?.toInt() ?? 0,
    );
  }
}
