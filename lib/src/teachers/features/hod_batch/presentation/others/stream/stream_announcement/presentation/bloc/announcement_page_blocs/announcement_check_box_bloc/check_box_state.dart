class CheckBoxState {
  final List<Map<String, dynamic>> checkBoxes;
  final bool isAllChecked;
  final bool areTeachersChecked;
  final bool areStudentsChecked;
  final bool areParentsChecked;

  CheckBoxState({
    required this.checkBoxes,
    required this.isAllChecked,
    required this.areTeachersChecked,
    required this.areStudentsChecked,
    required this.areParentsChecked,
  });

  CheckBoxState copyWith({
    List<Map<String, dynamic>>? checkBoxes,
    bool? isAllChecked,
    bool? areTeachersChecked,
    bool? areStudentsChecked,
    bool? areParentsChecked,
  }) {
    return CheckBoxState(
      checkBoxes: checkBoxes ?? this.checkBoxes,
      isAllChecked: isAllChecked ?? this.isAllChecked,
      areTeachersChecked: areTeachersChecked ?? this.areTeachersChecked,
      areStudentsChecked: areStudentsChecked ?? this.areStudentsChecked,
      areParentsChecked: areParentsChecked ?? this.areParentsChecked,
    );
  }

  bool hasCheckedCheckbox() {
    for (final checkbox in checkBoxes) {
      if (checkbox['isChecked'] == true) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    return 'CheckBoxState(checkBoxes: $checkBoxes, isAllChecked: $isAllChecked, '
        'areTeachersChecked: $areTeachersChecked, areStudentsChecked: $areStudentsChecked, '
        'areParentsChecked: $areParentsChecked)';
  }
}

class CheckBoxInitialState extends CheckBoxState {
  CheckBoxInitialState(
      {required super.checkBoxes,
      required super.isAllChecked,
      required super.areTeachersChecked,
      required super.areStudentsChecked,
      required super.areParentsChecked});
}

class CheckBoxEditInitialState extends CheckBoxState {
  CheckBoxEditInitialState(
      {required super.checkBoxes,
      required super.isAllChecked,
      required super.areTeachersChecked,
      required super.areStudentsChecked,
      required super.areParentsChecked});
}
