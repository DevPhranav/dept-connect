class CourseDetailsModel {
  final String credit;
  final String id;
  final String name;
  final String semester;

  CourseDetailsModel({
    required this.credit,
    required this.id,
    required this.name,
    required this.semester,
  });

  factory CourseDetailsModel.fromMap(Map<String, dynamic> map) {
    return CourseDetailsModel(
      credit: map['credit'],
      id: map['id'],
      name: map['name'],
      semester: map['semester'],
    );
  }
}
