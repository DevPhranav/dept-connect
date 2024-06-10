import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/auth_user.dart';

class AuthUserModel extends Equatable {
  final String id;
  final String email;
  final String? department;
  final String? batchId;

  const AuthUserModel({
    required this.id,
    required this.email,
     this.department,
    this.batchId,
  });

  factory AuthUserModel.fromFirebaseAuthUser(
      firebase_auth.User firebaseUser,
      Map<String, dynamic> userData,
      String userType,
      String batchId,
      ) {
    if(userType == "Teacher") {
      return AuthUserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        department: userData['department'],
      );
    }
    if(userType == "Student")
      {
        return AuthUserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          department: 'CSE',
          batchId: batchId,
        );
      }

    return const AuthUserModel(id: 'id', email: 'email');
  }



  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      email: json['email'],
      department: json['department'],
      batchId: json['batchId'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'department': department,
      'batchId':batchId,
    };
  }

  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      department: department,
      batchId: batchId,
    );
  }

  @override
  List<Object?> get props => [id, email, department,batchId];
}
