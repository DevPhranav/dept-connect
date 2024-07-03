
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entites/batchSeniorTutorList.dart';

class FacultySeniorTutorListModel {
  final String id;
  final String name;
  final bool alreadyBatchSeniorTutor;

  FacultySeniorTutorListModel({
    required this.id,
    required this.name,
    required this.alreadyBatchSeniorTutor,
  });

  factory FacultySeniorTutorListModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FacultySeniorTutorListModel(
      id: doc.id,
      name: data['name'] ?? '',
      alreadyBatchSeniorTutor: data['alreadyBatchSeniorTutor'] ?? false,
    );
  }

  FacultySeniorTutorEntity toEntity() {
    return FacultySeniorTutorEntity(
      id: id,
      name: name,
      alreadyBatchSeniorTutor: alreadyBatchSeniorTutor,
    );
  }
}
