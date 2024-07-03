// data/entites/batchModel.dart
class BatchModel {
  final int id;
  final int startingYear;
  final String seniorTutorId;
  final String? filePath;

  BatchModel({
    required this.id,
    required this.startingYear,
    required this.seniorTutorId,
    this.filePath,
  });
}


