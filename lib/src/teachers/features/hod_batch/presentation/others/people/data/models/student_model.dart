class StudentModel {
  final String rollNo;
  final String name;
  final String email;
  final String phoneNumber;
  final String section;

  StudentModel({
    required this.rollNo,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.section,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      rollNo: json['rollNo'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      section: json['section'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rollNo': rollNo,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'section': section,
    };
  }
}
