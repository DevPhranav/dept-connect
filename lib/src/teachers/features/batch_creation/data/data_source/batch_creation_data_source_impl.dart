import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entites/course_teacher.dart';
import '../../domain/entites/student.dart';
import '../../domain/entites/tutor.dart';
import '../../domain/repositories/batch_create_datasource.dart';
import '../models/course_teacher_model.dart';
import '../models/studentModel.dart';


class BatchDataSourceImpl implements BatchDataSource {
  final FirebaseFirestore firestore=FirebaseFirestore.instance;

  BatchDataSourceImpl();

  @override
  Future<void> pushBatchData(Map<String, dynamic> batchData, List<Student> students, List<CourseTeacher> courseTeachers, List<Tutor> tutors) async {
    String documentId = batchData["batch_id"];

    await firestore.collection('departments').doc('CSE').collection('batches').doc(documentId).set(batchData);

    CollectionReference studentsCollection = firestore.collection('departments').doc('CSE').collection('batches').doc(documentId).collection('students');
    CollectionReference semCoursesCollection = firestore.collection('departments').doc('CSE').collection('batches').doc(documentId).collection('semester').doc('01').collection('subject_faculty');

    for (var student in students) {
      await studentsCollection.doc(student.rollNo).set(StudentModel(
        rollNo: student.rollNo,
        name: student.name,
        email: student.email,
        phoneNumber: student.phoneNumber,
        section: student.section,
        parentName: student.parentName,
        parentEmail: student.parentEmail,
        parentPhoneNumber: student.parentPhoneNumber,
      ).toJson());
    }

    for (var courseTeacher in courseTeachers) {
      await semCoursesCollection.doc(courseTeacher.course_id).set(CourseTeacherModel(
        id: courseTeacher.id,
        courseId: courseTeacher.course_id,
        section: courseTeacher.section,
      ).toJson());
    }

    print('Batch data with student and tutor information added to Firestore.');
  }


  @override
  Future<bool> checkBatchYearExists(String batchYear) async {
    final snapshot = await firestore
        .collection('departments')
        .doc('CSE')
        .collection('batches')
        .get();

    return snapshot.docs.any((doc) => doc.id == batchYear);
  }

}
