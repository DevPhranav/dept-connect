class TutorsModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String role;

  TutorsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  factory TutorsModel.fromJson(Map<String, dynamic> json) {
    return TutorsModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['ph_no'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'ph_no': phoneNumber,
      'role': role,
    };
  }
}
