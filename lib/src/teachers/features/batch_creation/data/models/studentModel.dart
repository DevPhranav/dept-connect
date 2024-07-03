import '../../domain/entites/student.dart';

class StudentModel {
  final String rollNo;
  final String name;
  final String email;
  final String phoneNumber;
  final String section;
  final String parentName;
  final String parentEmail;
  final String parentPhoneNumber;

  StudentModel({
    required this.rollNo,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.section,
    required this.parentName,
    required this.parentEmail,
    required this.parentPhoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'rollNo': rollNo,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'section': section,
      'parentName': parentName,
      'parentEmail': parentEmail,
      'parentPhoneNumber': parentPhoneNumber,
    };
  }

  Student toEntity() {
    return Student(
      rollNo: rollNo,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      section: section,
      parentName: parentName,
      parentEmail: parentEmail,
      parentPhoneNumber: parentPhoneNumber,
    );
  }
}
