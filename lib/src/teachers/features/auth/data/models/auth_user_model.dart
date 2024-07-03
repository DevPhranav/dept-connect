import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/auth_user.dart';


class AuthUserModel extends Equatable {
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

  const AuthUserModel({
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
  List<Object?> get props => [
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
    userType
  ];

  // Factory method to create AuthUserModel from Firebase data for students
  factory AuthUserModel.fromStudentFirebaseAuthUser(
      firebase_auth.User user, Map<String, dynamic> userData, String batchId) {
    return AuthUserModel(
      email: user.email!,
      name: userData['name'],
      deviceId: user.uid,
      phoneNumber: userData['phoneNumber'],
      batchId: batchId,
      rollNo: userData['roll_no'],
      section: userData['section'],
      parentEmail: userData['parentEmail'],
      parentName: userData['parentName'],
      parentPhoneNumber: userData['parentPhoneNumber'],
      userType: 'Student',
        department: 'CSE',
    );
  }

  // Factory method to create AuthUserModel from Firebase data for teachers
  factory AuthUserModel.fromTeacherFirebaseAuthUser(
      firebase_auth.User user, Map<String, dynamic> userData) {
    return AuthUserModel(
      facultyId: userData['id'],
      email: user.email!,
      name: userData['name'],
      deviceId: userData['deviceId'],
      department: userData['department'],
      phoneNumber: userData['ph_no'],
      role: userData['role'],
      userType: 'Teacher',

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'facultyId': facultyId ?? '',
      'deviceId': deviceId ?? '',
      'email': email,
      'department': department ?? '',
      'batchId': batchId ?? '',
      'role': role ?? '',
      'name': name ?? '',
      'phoneNumber': phoneNumber ?? '',
      'rollNo': rollNo ?? '',
      'section': section ?? '',
      'parentEmail': parentEmail ?? '',
      'parentName': parentName ?? '',
      'parentPhoneNumber': parentPhoneNumber ?? '',
      'userType': userType ?? '',
    };
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      facultyId: json['facultyId'] ?? '',
      deviceId: json['deviceId'] ?? '',
      email: json['email'],
      department: json['department'] ?? '',
      batchId: json['batchId'] ?? '',
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      rollNo: json['rollNo'] ?? '',
      section: json['section'] ?? '',
      parentEmail: json['parentEmail'] ?? '',
      parentName: json['parentName'] ?? '',
      parentPhoneNumber: json['parentPhoneNumber'] ?? '',
      userType: json['userType'] ?? '',
    );
  }



  AuthUser toEntity() {
    return AuthUser(
      email: email,
      name: name,
      deviceId: deviceId,
      department: department,
      phoneNumber: phoneNumber,
      role: role,
      batchId: batchId,
      rollNo: rollNo,
      section: section,
      parentEmail: parentEmail,
      parentName: parentName,
      parentPhoneNumber: parentPhoneNumber,
      userType: userType,
      facultyId: facultyId,
    );
  }

}
