import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';
import '../models/faculty_model.dart';
import '../models/course_details_model.dart';

class CourseFirebaseDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<CourseModel>> getCourses(String batchId) async {
    final List<CourseModel> courses = [];
    final batchRef = firestore.collection(
        'departments/CSE/batches/$batchId/semester');

    final semesters = await batchRef.get();
    for (var semester in semesters.docs) {
      final coursesRef = batchRef.doc(semester.id).collection(
          'subject_faculty');
      final courseDocs = await coursesRef.get();
      for (var course in courseDocs.docs) {
        courses.add(CourseModel.fromMap(course.data()));
      }
    }
    return courses;
  }

  Future<FacultyModel> getFacultyDetails(String facultyId) async {
    final facultyDoc = await firestore.collection('faculty')
        .doc(facultyId)
        .get();
    return FacultyModel.fromMap(facultyDoc.data()!);
  }

  Future<List<CourseDetailsModel>> getCourseDetails(String courseId,
      String semester) async {
    print(semester);
    final courseCollection = await firestore.collection(
        'departments/CSE/courses')
        .where('id', isEqualTo: courseId)
        //.where('semester', isEqualTo: semester)
        .get();



    if (courseCollection.docs.isNotEmpty) {
       return courseCollection.docs.map((doc) =>
          CourseDetailsModel.fromMap(doc.data())).toList();



    } else {
      throw Exception('No courses found');
    }
  }

}