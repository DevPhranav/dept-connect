import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/faculty_model.dart';
import '../models/student_model.dart';

class PeopleRemoteDataSource {
  final FirebaseFirestore firestore;

  PeopleRemoteDataSource(this.firestore);

  Future<List<FacultyModel>> getFaculty(List<String> ids) async {
    final QuerySnapshot snapshot = await firestore.collection('faculty').get();
    return snapshot.docs
        .map((doc) => FacultyModel.fromJson(doc.data() as Map<String, dynamic>))
        .where((faculty) => ids.contains(faculty.id))
        .toList();
  }

  Future<List<StudentModel>> getStudents(String batchId, String section) async {
    final QuerySnapshot snapshot = await firestore
        .collection('departments/CSE/batches/$batchId/semester/student')
        .where('section', isEqualTo: section)
        .get();
    return snapshot.docs
        .map((doc) => StudentModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
