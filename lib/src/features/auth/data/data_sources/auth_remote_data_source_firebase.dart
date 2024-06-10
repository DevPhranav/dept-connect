import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/auth_user_model.dart';
import '../network_connectivity.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceFirebase implements AuthRemoteDataSource {
  AuthRemoteDataSourceFirebase({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final InternetConnectivity internetConnectivity = InternetConnectivity();


  @override
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String userType,
  }) async {
    // Check internet connectivity
    if (!(await internetConnectivity.checkInternetConnectivity())) {
      throw Exception('No internet connection');
    }

    final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
    Map<String, dynamic> userData = {};
    firebase_auth.UserCredential credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception('Sign in failed: The user is null after sign in.');
    } else {
      if (userType == "Teacher") {
        userData = await _getFacultyData(credential.user?.email, 'faculty');
        return AuthUserModel.fromFirebaseAuthUser(
          credential.user!,
          userData,
          "Teacher",
          '',
        );
      }
      if (userType == "Student") {
        // First, check if the user exists in Firebase Authentication
        if (credential.user != null) {
          String email = credential.user!.email!;
          String emailKey = email.split("@")[0];
          String batchId = emailKey.substring(4,6); // Assuming the batch ID is at positions 2 and 3 in the emailKey
          String studentDocumentPath = 'departments/CSE/batches/20$batchId-20${int.parse(batchId) + 4}/students/$emailKey';
          userData = await _getStudentData(studentDocumentPath);
          String batchName = "20$batchId-20${int.parse(batchId) + 4}";
          print(batchName);
          return AuthUserModel.fromFirebaseAuthUser(
            credential.user!,
            userData,
            "Student",
            batchName
          );
        } else {
          throw Exception('User is null after sign in.');
        }
      }
      return const AuthUserModel(id: '', email: 'email', department: 'department');


    }
  }


  Future<Map<String, dynamic>> _getStudentData(String studentDocumentPath) async {

    try {
      DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance.doc(studentDocumentPath).get();
      if (studentSnapshot.exists) {
        Map<String, dynamic>? data = studentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return data;
        } else {
          throw Exception('Student data is null');
        }
      } else {
        throw Exception('Student document does not exist');
      }
    } catch (e) {
      throw Exception('$e');
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
