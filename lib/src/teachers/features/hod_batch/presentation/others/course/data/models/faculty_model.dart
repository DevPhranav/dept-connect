class FacultyModel {
  final String department;
  final String email;
  final String facultyId;
  final String name;
  final String phoneNumber;
  final String role;

  FacultyModel({
    required this.department,
    required this.email,
    required this.facultyId,
    required this.name,
    required this.phoneNumber,
    required this.role,
  });

  factory FacultyModel.fromMap(Map<String, dynamic> map) {
    return FacultyModel(
      department: map['department'],
      email: map['email'],
      facultyId: map['id'],
      name: map['name'],
      phoneNumber: map['ph_no'],
      role: map['role'],
    );
  }
}
