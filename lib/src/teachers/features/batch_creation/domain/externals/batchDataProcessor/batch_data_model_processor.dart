


import '../../../data/models/course_teacher_model.dart';
import '../../../data/models/studentModel.dart';
import '../../../data/models/tutor_model.dart';

class BatchDataProcessor {
  List<StudentModel> convertToStudents(List<List<dynamic>> studentsData) {
    return studentsData.map((studentInfo) {
      return StudentModel(
        rollNo: "${studentInfo[0]}",
        name:  "${studentInfo[1]}",
        email:  "${studentInfo[2]}",
        phoneNumber:  "${studentInfo[3]}",
        section:  "${studentInfo[4]}",
        parentName:  "${studentInfo[5]}",
        parentEmail:  "${studentInfo[6]}",
        parentPhoneNumber:  "${studentInfo[7]}",
      );
    }).toList();
  }

  List<CourseTeacherModel> convertToCourseTeachers(List<List<dynamic>> facultyData) {
    return facultyData.map((facultyInfo) {
      return CourseTeacherModel(
          id: "${facultyInfo[0]}",
          courseId: "${facultyInfo[1]}",
          section:"${facultyInfo[2]}"
      );
    }).toList();
  }

  List<TutorModel> convertToTutors(List<List<dynamic>> tutorsData) {
    return tutorsData.map((tutorInfo) {
      return TutorModel(
        id: "${tutorInfo[0]}",
        section: "${tutorInfo[1]}",
      );
    }).toList();
  }
}
