import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/batch_remote_datasource.dart';


class HodBatchRemoteDataSourceImpl extends HodBatchRemoteDataSource {

  HodBatchRemoteDataSourceImpl();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<String>> fetchBatchIdsFromDatabase(String dept) async {
    try {
      CollectionReference departmentCollection = firestore.collection('departments');
      DocumentSnapshot departmentDocumentSnapshot = await departmentCollection.doc(dept).get();
      CollectionReference batchesCollection = departmentDocumentSnapshot.reference.collection('batches');
      QuerySnapshot batchQuerySnapshot = await batchesCollection.get();

      List<String> batchIds = batchQuerySnapshot.docs.map((batchDoc) {
        return batchDoc.id;
      }).toList();

      return batchIds;
    } catch (error) {
      throw error;
    }
  }
}
