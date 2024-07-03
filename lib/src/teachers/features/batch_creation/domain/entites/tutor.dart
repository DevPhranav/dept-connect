class Tutor {
  final String id;
  final String section;

  Tutor({
    required this.id,
    required this.section,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'section': section,
    };
  }
}
