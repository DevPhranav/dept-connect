class FacultySeniorTutorEntity {
  final String id;
  final String name;
  final bool alreadyBatchSeniorTutor;

  FacultySeniorTutorEntity({
    required this.id,
    required this.name,
    required this.alreadyBatchSeniorTutor,
  });

  String getFormattedText() {
    return '$id : $name';
  }
}