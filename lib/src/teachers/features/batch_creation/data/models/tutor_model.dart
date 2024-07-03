import '../../domain/entites/tutor.dart';

class TutorModel {
  final String id;
  final String section;

  TutorModel({
    required this.id,
    required this.section,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'section': section,
    };
  }

  Tutor toEntity() {
    return Tutor(
      id: id,
      section: section,
    );
  }
}
