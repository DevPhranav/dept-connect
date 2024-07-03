// data_sources/firebase_dropdown_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entites/batchSeniorTutorList.dart';
import '../../domain/repositories/drop_down_data_source.dart';

class FirebaseDropdownDataSource extends DropdownDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<FacultySeniorTutorEntity>> fetchDropdownItems() async {
    try {
      final QuerySnapshot snapshot =
      await _firestore.collection('departments/CSE/faculty_senior_tutor_privilege').get();
      return snapshot.docs.map((doc) => _mapToFacultySeniorTutor(doc)).toList();
    } catch (e) {
      throw Exception('Error fetching dropdown items: $e');
    }
  }

  FacultySeniorTutorEntity _mapToFacultySeniorTutor(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FacultySeniorTutorEntity(
      id: doc.id,
      name: data['name'] ?? '',
      alreadyBatchSeniorTutor: data['alreadyBatchSeniorTutor'] ?? false,
    );
  }
}
