import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/data/data_sources/semester_datasource.dart';
import '../models/semester_model.dart';

class SemesterDataSourceImpl implements SemesterDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<SemesterModel>> fetchSemesters(String batchId) async {
    try {
      // Get reference to the 'departments' collection
      CollectionReference departmentCollection = firestore.collection('departments');

      // Get document snapshot for 'CSE' department
      DocumentSnapshot departmentDocumentSnapshot = await departmentCollection.doc("CSE").get();

      // Get reference to the 'batches' collection under 'CSE' department
      CollectionReference batchesCollection = departmentDocumentSnapshot.reference.collection('batches');

      // Get document snapshot for the specified batchId
      DocumentSnapshot batchDocumentSnapshot = await batchesCollection.doc(batchId).get();

      // Get reference to the 'semester' collection under the specified batchId
      CollectionReference semesterCollection = batchDocumentSnapshot.reference.collection('semester');

      // Query snapshot for all documents in the 'semester' collection
      QuerySnapshot semesterQuerySnapshot = await semesterCollection.get();

      if (semesterQuerySnapshot.docs.isEmpty) {
        print('No documents found for batchId: $batchId');
        return []; // Return an empty list if no documents found
      }

      print('Documents found for batchId: $batchId');

      // Mapping query snapshot to list of SemesterModel
      return semesterQuerySnapshot.docs.map((doc) {
        return SemesterModel(
          id: doc.id,
          title: "Semester : ${doc.id}",
          // Add other fields as needed based on your SemesterModel
        );
      }).toList();
    } catch (e) {
      print('Failed to fetch semesters: $e');
      throw Exception('Failed to fetch semesters: $e');
    }
  }
}
