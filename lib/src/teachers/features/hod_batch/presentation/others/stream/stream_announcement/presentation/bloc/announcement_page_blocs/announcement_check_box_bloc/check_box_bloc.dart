import 'package:flutter_bloc/flutter_bloc.dart';

import 'check_box_event.dart';
import 'check_box_state.dart';

class CheckBoxBloc extends Bloc<CheckBoxEvent, CheckBoxState> {

  final initialCheckBoxes = [
    {"name": "all", "isChecked": false},
    {"name": "teachers", "isChecked": false},
    {"name": "tSec1", "isChecked": false},
    {"name": "tSec2", "isChecked": false},
    {"name": "students", "isChecked": false},
    {"name": "sSec1", "isChecked": false},
    {"name": "sSec2", "isChecked": false},
    {"name": "parents", "isChecked": false},
    {"name": "pSec1", "isChecked": false},
    {"name": "pSec2", "isChecked": false},
    {"name": "seniorTutor", "isChecked": false}
  ];
  CheckBoxBloc()
      : super(CheckBoxInitialState(
      checkBoxes: [
        {"name": "all", "isChecked": false},
        {"name": "teachers", "isChecked": false},
        {"name": "tSec1", "isChecked": false},
        {"name": "tSec2", "isChecked": false},
        {"name": "students", "isChecked": false},
        {"name": "sSec1", "isChecked": false},
        {"name": "sSec2", "isChecked": false},
        {"name": "parents", "isChecked": false},
        {"name": "pSec1", "isChecked": false},
        {"name": "pSec2", "isChecked": false},
        {"name": "seniorTutor", "isChecked": false}
      ],
      isAllChecked: false,
      areTeachersChecked: false,
      areStudentsChecked: false,
      areParentsChecked: false)) {
    on<CheckBoxInitialEvent>(_callInitialState);
    on<ToggleNotificationEvent>(_updateCheckBox);
    on<ToggleAllCheckBoxEvent>(_toggleAllCheckBox);
    on<ToggleTeacherCheckBoxEvent>(_toggleTeacherCheckBox);
    on<ToggleStudentCheckBoxEvent>(_toggleStudentCheckBox);
    on<ToggleParentCheckBoxEvent>(_toggleParentCheckBox);


    // for edit section
    on<CheckBoxEditInitialEvent>(_callInitialEditState);
  }



  void _callInitialState(CheckBoxInitialEvent event, Emitter<CheckBoxState> emit) {
    print("checkbox initialEvent is trigged and it method also triggered");
    emit(CheckBoxInitialState(
      checkBoxes: event.checkboxes,
      isAllChecked:false,
      areTeachersChecked: false,
      areStudentsChecked: false,
      areParentsChecked: false,
    ));

  }

  void _callInitialEditState(CheckBoxEditInitialEvent event, Emitter<CheckBoxState> emit) {
    print("checkbox initialEvent is trigged and it method also triggered");
    emit(CheckBoxEditInitialState(
      checkBoxes: event.previousCheckBoxes,
      isAllChecked:event.isAllChecked,
      areTeachersChecked: event.areTeachersChecked,
      areStudentsChecked: event.areStudentsChecked,
      areParentsChecked: event.areParentsChecked,
    ));

  }


  void _updateCheckBox(ToggleNotificationEvent event, Emitter<CheckBoxState> emit) {
    final updatedCheckBoxes = List<Map<String, dynamic>>.from(state.checkBoxes);
    updatedCheckBoxes[event.index]["isChecked"] = event.newValue;

    // Handle the logic for tSec1, tSec2, sSec1, sSec2, pSec1, and pSec2
    if (!updatedCheckBoxes[2]["isChecked"] && !updatedCheckBoxes[3]["isChecked"]) {
      updatedCheckBoxes[1]["isChecked"] = false; // Uncheck teachers if both tSec1 and tSec2 are unchecked
    }

    if (!updatedCheckBoxes[5]["isChecked"] && !updatedCheckBoxes[6]["isChecked"]) {
      updatedCheckBoxes[4]["isChecked"] = false; // Uncheck students if both sSec1 and sSec2 are unchecked
    }

    if (!updatedCheckBoxes[8]["isChecked"] && !updatedCheckBoxes[9]["isChecked"]) {
      updatedCheckBoxes[7]["isChecked"] = false; // Uncheck parents if both pSec1 and pSec2 are unchecked
    }


    emit(state.copyWith(checkBoxes: updatedCheckBoxes));
  }



  void _toggleAllCheckBox(
      ToggleAllCheckBoxEvent event, Emitter<CheckBoxState> emit) {
    final updatedCheckBoxes = List<Map<String, dynamic>>.from(state.checkBoxes);
    for (var i = 0; i < updatedCheckBoxes.length; i++) {
      updatedCheckBoxes[i]["isChecked"] = event.newValue;
    }

    emit(state.copyWith(
      checkBoxes: updatedCheckBoxes,
      isAllChecked: event.newValue,
      areTeachersChecked: event.newValue,
      areStudentsChecked: event.newValue,
      areParentsChecked: event.newValue,
    ));
  }

  void _toggleTeacherCheckBox(
      ToggleTeacherCheckBoxEvent event, Emitter<CheckBoxState> emit) {
    final updatedCheckBoxes = List<Map<String, dynamic>>.from(state.checkBoxes);
    updatedCheckBoxes[1]["isChecked"] = event.newValue;
    updatedCheckBoxes[2]["isChecked"] = event.newValue;
    updatedCheckBoxes[3]["isChecked"] = event.newValue;

    emit(state.copyWith(
      checkBoxes: updatedCheckBoxes,
      areTeachersChecked: event.newValue,
    ));
  }

  void _toggleStudentCheckBox(
      ToggleStudentCheckBoxEvent event, Emitter<CheckBoxState> emit) {
    final updatedCheckBoxes = List<Map<String, dynamic>>.from(state.checkBoxes);
    updatedCheckBoxes[4]["isChecked"] = event.newValue;
    updatedCheckBoxes[5]["isChecked"] = event.newValue;
    updatedCheckBoxes[6]["isChecked"] = event.newValue;

    emit(state.copyWith(
      checkBoxes: updatedCheckBoxes,
      areStudentsChecked: event.newValue,
    ));
  }

  void _toggleParentCheckBox(
      ToggleParentCheckBoxEvent event, Emitter<CheckBoxState> emit) {
    final updatedCheckBoxes = List<Map<String, dynamic>>.from(state.checkBoxes);
    updatedCheckBoxes[7]["isChecked"] = event.newValue;
    updatedCheckBoxes[8]["isChecked"] = event.newValue;
    updatedCheckBoxes[9]["isChecked"] = event.newValue;

    emit(state.copyWith(
      checkBoxes: updatedCheckBoxes,
      areParentsChecked: event.newValue,
    ));
  }
}
