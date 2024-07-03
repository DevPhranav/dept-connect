

import '../../entites/course_teacher.dart';
import '../../entites/student.dart';
import '../../entites/subject_faculty.dart';
import '../../entites/tutor.dart';

class BatchDataConvertProcessor{
  Map<String, dynamic> createBatchData(List<Student> students, List<CourseTeacher> courseTeachers, List<Tutor> tutors,String batchName, String seniorTutorId) {
    List<Tutor> section1Tutors = filterTutorsBySection(tutors, "1");
    List<Tutor> section2Tutors = filterTutorsBySection(tutors, "2");
    // Create the JSON structure for one batch with empty semesters (2 to 8)
    return {
      "batch_id": batchName,
      "senior_tutor_id": seniorTutorId,
      "tutors_sec1": section1Tutors.map((tutor) => tutor.id).toList(),
      "tutors_sec2": section2Tutors.map((tutor) => tutor.id).toList(),
      "semesters": [
        {
          "semester": 1,
        },
      ],
    };
  }

  List<Tutor> filterTutorsBySection(List<Tutor> tutors, String section) {
    return tutors.where((tutor) => tutor.section == section).toList();
  }

  List<SubjectFaculty> createSemesterCourses(List<CourseTeacher> courseTeachers) {
    Map<String, dynamic> semesterCourses = {};
    List<SubjectFaculty> subjectFaculties = [];

    courseTeachers.forEach((courseTeacher) {
      String teacherSec1Id =
      getTeacherIdForSection(courseTeacher.section, "1", courseTeachers);
      String teacherSec2Id =
      getTeacherIdForSection(courseTeacher.section, "2", courseTeachers);

      semesterCourses[courseTeacher.course_id] = {
        "teacher_sec1_id": teacherSec1Id,
        "teacher_sec2_id": teacherSec2Id,
      };

      subjectFaculties.add(SubjectFaculty(
        course_id: courseTeacher.course_id,
        teacher_sec1_id: teacherSec1Id,
        teacher_sec2_id: teacherSec2Id,
      ));
    });

    return subjectFaculties;
  }



  String getTeacherIdForSection(String currentSection, String targetSection, List<CourseTeacher> courseTeachers) {
    // Find the first teacher ID for the target section
    for (var teacher in courseTeachers) {
      if (teacher.section == targetSection) {
        return teacher.id;
      }
    }
    return ""; // Return an empty string if no teacher found for the target section
  }
}