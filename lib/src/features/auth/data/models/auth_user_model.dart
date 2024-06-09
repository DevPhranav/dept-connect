import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/auth_user.dart';

class AuthUserModel extends Equatable {
  final String id;
  final String email;
  final String department;

  const AuthUserModel({
    required this.id,
    required this.email,
    required this.department,
  });

  factory AuthUserModel.fromFirebaseAuthUser(
      firebase_auth.User firebaseUser,
      Map<String, dynamic> facultyData,
      ) {
    return AuthUserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      department: facultyData['department'],
    );
  }



  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      email: json['email'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'department': department,
    };
  }

  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      department: department,
    );
  }

  @override
  List<Object?> get props => [id, email, department];
}
