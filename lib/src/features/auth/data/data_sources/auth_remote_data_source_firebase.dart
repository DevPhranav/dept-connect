import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/auth_user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceFirebase implements AuthRemoteDataSource {
  AuthRemoteDataSourceFirebase({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;


  @override
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String userType,
  }) async {
    final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
    Map<String, dynamic> facultyData = {};
    firebase_auth.UserCredential credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception('Sign in failed: The user is null after sign in.');
    } else {
      if (userType=="Teacher") {
        facultyData = await _getFacultyData(credential.user?.email,'faculty');
      }

      return AuthUserModel.fromFirebaseAuthUser(
        credential.user!,
        facultyData,
      );
    }
  }
  Future<Map<String, dynamic>> _getFacultyData(String? email, String userType) async {
    try {
      QuerySnapshot facultySnapshot = await FirebaseFirestore.instance
          .collection(userType)
          .where('email', isEqualTo: email)
          .get();

      if (facultySnapshot.docs.isNotEmpty) {
        // Assuming there should only be one document per email
        DocumentSnapshot facultyDoc = facultySnapshot.docs.first;
        return facultyDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception('No faculty data found for email: $email');
      }
    } catch (e) {
      throw Exception('Failed to fetch faculty data: $e');
    }
  }


  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}
