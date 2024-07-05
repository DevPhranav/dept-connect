import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/batch_remote_datasource.dart';

class HodBatchRemoteDataSourceImpl extends HodBatchRemoteDataSource {
  HodBatchRemoteDataSourceImpl();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<String>> fetchBatchIdsFromDatabase(String dept, String facultyId, String role) async {
    try {
      CollectionReference departmentCollection = firestore.collection('departments');
      DocumentSnapshot departmentDocumentSnapshot = await departmentCollection.doc(dept).get();
      CollectionReference batchesCollection = departmentDocumentSnapshot.reference.collection('batches');

      if (role == 'HOD') {
        // Fetch all batches under the department if role is HOD
        QuerySnapshot batchQuerySnapshot = await batchesCollection.get();

        List<String> batchIds = batchQuerySnapshot.docs.map((batchDoc) {
          return batchDoc.id;
        }).toList();

        return batchIds;
      } else {
        // Fetch batches based on senior_tutor_id matching with facultyId
        QuerySnapshot batchQuerySnapshot = await batchesCollection.where('senior_tutor_id', isEqualTo: facultyId).get();

        if (batchQuerySnapshot.docs.isNotEmpty) {
          List<String> batchIds = batchQuerySnapshot.docs.map((batchDoc) {
            return batchDoc.id;
          }).toList();

          return batchIds;
        } else {
          // If no batches found with senior_tutor_id, check tutors_sec1 and tutors_sec2
          List<String> batchIds = [];

          QuerySnapshot secQuerySnapshot = await batchesCollection.where('tutors_sec1', arrayContains: facultyId).get();
          if (secQuerySnapshot.docs.isNotEmpty) {
            batchIds = secQuerySnapshot.docs.map((batchDoc) {
              return batchDoc.id;
            }).toList();
          } else {
            secQuerySnapshot = await batchesCollection.where('tutors_sec2', arrayContains: facultyId).get();
            if (secQuerySnapshot.docs.isNotEmpty) {
              batchIds = secQuerySnapshot.docs.map((batchDoc) {
                return batchDoc.id;
              }).toList();
            }
          }

          return batchIds;
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
