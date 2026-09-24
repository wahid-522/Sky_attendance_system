class InstructorModel {
  final String id;
  final String name;
  final String email;
  final String qualification;
  final List<String> subjects;
  final List<String> classes;
  final String status;

  const InstructorModel({
    required this.id,
    required this.name,
    required this.email,
    this.qualification = '',
    this.subjects = const [],
    this.classes = const [],
    this.status = 'Active',
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id:            json['id']?.toString()            ?? json['_id']?.toString() ?? '',
      name:          json['name']?.toString()          ?? '',
      email:         json['email']?.toString()         ?? '',
      qualification: json['qualification']?.toString() ?? '',
      subjects: (json['subjects'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      classes: (json['classes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      status: json['status']?.toString() ?? 'Active',
    );
  }

  Map<String, dynamic> toJson() => {
        'id':            id,
        'name':          name,
        'email':         email,
        'qualification': qualification,
        'subjects':      subjects,
        'classes':       classes,
        'status':        status,
      };
}
