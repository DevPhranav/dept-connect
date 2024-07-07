import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/faculty.dart';
import '../../domain/entities/student.dart';
import '../../domain/entities/teacher.dart';
import '../../domain/entities/tutor.dart';
import '../../domain/repositories/people_repository.dart';
import '../models/faculty_model.dart';
import '../models/student_model.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final FirebaseFirestore firestore=FirebaseFirestore.instance;


  @override
  Future<List<Teacher>> getTeachers(String batchId, String section) async {
    try {
      final DocumentSnapshot batchDoc = await firestore
          .doc('departments/CSE/batches/$batchId/semester/01')
          .get();

      List<String> teacherIds = [];
      if (section == '1') {
        teacherIds = List<String>.from(batchDoc.get('teachers_sec1') ?? []);
      } else if (section == '2') {
        teacherIds = List<String>.from(batchDoc.get('teachers_sec2') ?? []);
      }

      List<Teacher> teachers = [];

      for (String teacherId in teacherIds) {
        final DocumentSnapshot facultyDoc =
        await firestore.collection('faculty').doc(teacherId).get();

        if (facultyDoc.exists) {
          Teacher teacher = Teacher(
            id: teacherId,
            name: facultyDoc.get('name'),
            email: facultyDoc.get('email'),
            phoneNumber: facultyDoc.get('ph_no'),
            role: facultyDoc.get('role'),
          );
          teachers.add(teacher);
        }
      }

      return teachers;
    } catch (e) {
      // Handle errors here
      print('Error fetching teachers: $e');
      return []; // Return an empty list or handle error as per your app's requirement
    }
  }

  @override
  Future<List<Tutor>> getTutors(String batchId, String section) async {
    try {
      final DocumentSnapshot batchDoc =
      await firestore.doc('departments/CSE/batches/$batchId').get();

      List<String> tutorIds = [];
      if (section == '1') {
        tutorIds = List<String>.from(batchDoc.get('tutors_sec1') ?? []);
      } else if (section == '2') {
        tutorIds = List<String>.from(batchDoc.get('tutors_sec2') ?? []);
      }

      List<Tutor> tutors = [];

      for (String tutorId in tutorIds) {
        final DocumentSnapshot facultyDoc =
        await firestore.collection('faculty').doc(tutorId).get();

        if (facultyDoc.exists) {
          Tutor tutor = Tutor(
            id: tutorId,
            name: facultyDoc.get('name'),
            email: facultyDoc.get('email'),
            phoneNumber: facultyDoc.get('ph_no'),
            role: facultyDoc.get('role'),
          );
          tutors.add(tutor);
        }
      }

      print(tutors);
      return tutors;
    } catch (e) {
      // Handle errors here
      print('Error fetching tutors: $e');
      return []; // Return an empty list or handle error as per your app's requirement
    }
  }

  @override
  Future<List<Student>> getStudents(String batchId, String section) async {
    final QuerySnapshot snapshot = await firestore
        .collection('departments/CSE/batches/$batchId/students')
        .where('section', isEqualTo: section)
        .get();
    return snapshot.docs
        .map((doc) => StudentModel.fromJson(doc.data() as Map<String, dynamic>))
        .map((studentModel) => Student(
      rollNo: studentModel.rollNo,
      name: studentModel.name,
      email: studentModel.email,
      phoneNumber: studentModel.phoneNumber,
      section: studentModel.section,
    ))
        .toList();
  }
}
