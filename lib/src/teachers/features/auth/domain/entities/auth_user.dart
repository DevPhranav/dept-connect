import 'package:equatable/equatable.dart';


class AuthUser extends Equatable {
  final String? facultyId;
  final String? deviceId;
  final String email;
  final String? department;
  final String? batchId;
  final String? role;
  final String? name;
  final String? phoneNumber;
  final String? rollNo;
  final String? section;
  final String? parentEmail;
  final String? parentName;
  final String? parentPhoneNumber;
  final String? userType;
  const AuthUser({
    this.facultyId,
    this.deviceId,
    required this.email,
    this.department,
    this.batchId,
    this.role,
    this.name,
    this.phoneNumber,
    this.rollNo,
    this.section,
    this.parentEmail,
    this.parentName,
    this.parentPhoneNumber,
    this.userType,
  });

  @override
  List<Object?> get props =>
      [
        facultyId,
        email,
        name,
        deviceId,
        department,
        phoneNumber,
        role,
        batchId,
        rollNo,
        section,
        parentEmail,
        parentName,
        parentPhoneNumber,
        userType,
      ];
}