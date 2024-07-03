import 'package:equatable/equatable.dart';

abstract class CheckBoxEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckBoxInitialEvent extends CheckBoxEvent {
  final  List<Map<String, dynamic>> checkboxes;

  CheckBoxInitialEvent({required this.checkboxes});
}

// Event to toggle notification for a checkbox at a specific index
class ToggleNotificationEvent extends CheckBoxEvent {
  final int index;
  final bool newValue;

  ToggleNotificationEvent({required this.index, required this.newValue});

  @override
  List<Object?> get props => [index, newValue];
}

// Event to toggle all checkboxes except the "All" checkbox
class ToggleAllCheckBoxEvent extends CheckBoxEvent {
  final bool newValue;

  ToggleAllCheckBoxEvent({required this.newValue});

  @override
  List<Object?> get props => [newValue];
}

// Event to toggle "Teachers" checkbox and associated checkboxes
class ToggleTeacherCheckBoxEvent extends CheckBoxEvent {
  final bool newValue;

  ToggleTeacherCheckBoxEvent({required this.newValue});

  @override
  List<Object?> get props => [newValue];
}

// Event to toggle "Students" checkbox and associated checkboxes
class ToggleStudentCheckBoxEvent extends CheckBoxEvent {
  final bool newValue;

  ToggleStudentCheckBoxEvent({required this.newValue});

  @override
  List<Object?> get props => [newValue];
}

// Event to toggle "Parents" checkbox and associated checkboxes
class ToggleParentCheckBoxEvent extends CheckBoxEvent {
  final bool newValue;

  ToggleParentCheckBoxEvent({required this.newValue});

  @override
  List<Object?> get props => [newValue];
}

class CheckBoxEditInitialEvent extends CheckBoxEvent {
  final List<Map<String, dynamic>> previousCheckBoxes;
  final bool isAllChecked;
  final bool areTeachersChecked;
  final bool areStudentsChecked;
  final bool areParentsChecked;

  CheckBoxEditInitialEvent(
      {required this.previousCheckBoxes,
      required this.isAllChecked,
      required this.areTeachersChecked,
      required this.areStudentsChecked,
      required this.areParentsChecked});
}
