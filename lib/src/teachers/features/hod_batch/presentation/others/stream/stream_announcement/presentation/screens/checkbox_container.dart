import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/models/auth_user_model.dart';
import '../../../../../../../../../../static/checkbox_title.dart';
import '../bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import '../bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_event.dart';
import '../bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_state.dart';


class CheckBoxContainer {
  Column buildCheckBoxes(BuildContext context,AuthUserModel? user) {
    return Column(
      children: [
        BlocBuilder<CheckBoxBloc, CheckBoxState>(
          builder: (context, state) {
            final checkBoxes;
            if (state is CheckBoxInitialState) {
              checkBoxes = [
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
            } else if (state is CheckBoxEditInitialState) {
              checkBoxes = state.checkBoxes;
            } else {
              checkBoxes = state.checkBoxes;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CheckboxTile(
                      label: "All",
                      value: checkBoxes[0]["isChecked"],
                      onChanged: (value) {
                        BlocProvider.of<CheckBoxBloc>(context).add(
                          ToggleAllCheckBoxEvent(newValue: value ?? false,isHod:(user!.role =='HOD')??false),
                        ); // 'All', json index 0
                      },
                    ),
                    if (user?.role == "HOD")
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: IgnorePointer(
                          ignoring: checkBoxes[0]["isChecked"],
                          child: Opacity(
                            opacity: !checkBoxes[0]["isChecked"] ? 1.0 : 0.5,
                            child: CheckboxTile(
                              label: "Senior Tutor",
                              value: checkBoxes[10]["isChecked"],
                              onChanged: (value) {
                                BlocProvider.of<CheckBoxBloc>(context).add(
                                  ToggleNotificationEvent(
                                      index: 10, newValue: value ?? false),
                                ); // senior Tutor json index is 10
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                teachersRow(checkBoxes, context),
                studentsRow(checkBoxes, context),
                parentsRow(checkBoxes, context),
              ],
            );

          },
        ),
      ],
    );
  }

  Row parentsRow(List<Map<String, dynamic>> checkBoxes, BuildContext context) {
    return Row(
      children: [
        IgnorePointer(
          ignoring: checkBoxes[0]["isChecked"],
          child: Opacity(
            opacity: !checkBoxes[0]["isChecked"] ? 1.0 : 0.5,
            child: CheckboxTile(
              label: "Parents",
              value: checkBoxes[7]["isChecked"],
              onChanged: (value) {
                BlocProvider.of<CheckBoxBloc>(context).add(
                  ToggleParentCheckBoxEvent(
                    newValue: value ?? false,
                  ),
                );
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 11.0),
          child: Icon(Icons.arrow_right),
        ),
        IgnorePointer(
          ignoring: checkBoxes[7]["isChecked"]
              ? checkBoxes[0]["isChecked"]
                  ? true
                  : false
              : true,
          // Disable pSec1 if Parents checkbox is unchecked
          child: Opacity(
            opacity: checkBoxes[7]["isChecked"]
                ? (checkBoxes[0]["isChecked"] ? 0.5 : 1.0)
                : 0.5,
            // Change opacity based on enabled/disabled state
            child: CheckboxTile(
              label: "Sec 1",
              value: checkBoxes[8]["isChecked"],
              onChanged: (value) {
                BlocProvider.of<CheckBoxBloc>(context).add(
                  ToggleNotificationEvent(index: 8, newValue: value ?? false),
                );
              },
            ),
          ),
        ),
        IgnorePointer(
          ignoring: checkBoxes[7]["isChecked"]
              ? checkBoxes[0]["isChecked"]
                  ? true
                  : false
              : true,
          // Disable pSec2 if Parents checkbox is unchecked
          child: Opacity(
            opacity: checkBoxes[7]["isChecked"]
                ? (checkBoxes[0]["isChecked"] ? 0.5 : 1.0)
                : 0.5,
            // Change opacity based on enabled/disabled state
            child: CheckboxTile(
              label: "Sec 2",
              value: checkBoxes[9]["isChecked"],
              onChanged: (value) {
                BlocProvider.of<CheckBoxBloc>(context).add(
                  ToggleNotificationEvent(index: 9, newValue: value ?? false),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Row studentsRow(List<Map<String, dynamic>> checkBoxes, BuildContext context) {
    return Row(
      children: [
        IgnorePointer(
          ignoring: checkBoxes[0]["isChecked"],
          child: Opacity(
            opacity: !checkBoxes[0]["isChecked"] ? 1.0 : 0.5,
            child: CheckboxTile(
              label: "Students",
              value: checkBoxes[4]["isChecked"],
              onChanged: (value) {
                BlocProvider.of<CheckBoxBloc>(context).add(
                  ToggleStudentCheckBoxEvent(
                    newValue: value ?? false,
                  ),
                );
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 3.0),
          child: Icon(Icons.arrow_right),
        ),
        Row(
          children: [
            IgnorePointer(
              ignoring: checkBoxes[4]["isChecked"]
                  ? checkBoxes[0]["isChecked"]
                      ? true
                      : false
                  : true,
              // Disable sSec1 if Students checkbox is unchecked
              child: Opacity(
                opacity: checkBoxes[4]["isChecked"]
                    ? (checkBoxes[0]["isChecked"] ? 0.5 : 1.0)
                    : 0.5,
                // Change opacity based on enabled/disabled state
                child: CheckboxTile(
                  label: "Sec 1",
                  value: checkBoxes[5]["isChecked"],
                  onChanged: (value) {
                    BlocProvider.of<CheckBoxBloc>(context).add(
                      ToggleNotificationEvent(
                          index: 5, newValue: value ?? false),
                    );
                  },
                ),
              ),
            ),
            IgnorePointer(
              ignoring: checkBoxes[4]["isChecked"]
                  ? checkBoxes[0]["isChecked"]
                      ? true
                      : false
                  : true,
              // Disable sSec2 if Students checkbox is unchecked
              child: Opacity(
                opacity: checkBoxes[4]["isChecked"]
                    ? (checkBoxes[0]["isChecked"] ? 0.5 : 1.0)
                    : 0.5,
                // Change opacity based on enabled/disabled state
                child: CheckboxTile(
                  label: "Sec 2",
                  value: checkBoxes[6]["isChecked"],
                  onChanged: (value) {
                    BlocProvider.of<CheckBoxBloc>(context).add(
                      ToggleNotificationEvent(
                          index: 6, newValue: value ?? false),
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row teachersRow(List<Map<String, dynamic>> checkBoxes, BuildContext context) {
    return Row(
      children: [
        IgnorePointer(
          ignoring: checkBoxes[0]["isChecked"],
          child: Opacity(
            opacity: !checkBoxes[0]["isChecked"] ? 1.0 : 0.5,
            child: CheckboxTile(
                label: "Teachers",
                value: checkBoxes[1]["isChecked"],
                onChanged: (value) {
                  BlocProvider.of<CheckBoxBloc>(context).add(
                    ToggleTeacherCheckBoxEvent(
                      newValue: value ?? false,
                    ),
                  );
                  // Enable tSec1 and tSec2 when Teachers checkbox is checked
                  if (value ?? false) {
                    BlocProvider.of<CheckBoxBloc>(context).add(
                      ToggleNotificationEvent(index: 2, newValue: true),
                    );
                    BlocProvider.of<CheckBoxBloc>(context).add(
                      ToggleNotificationEvent(index: 3, newValue: true),
                    );
                  }
                }),
          ),
        ),
        const Icon(Icons.arrow_right),
        IgnorePointer(
          ignoring: checkBoxes[1]["isChecked"]
              ? checkBoxes[0]["isChecked"]
                  ? true
                  : false
              : true,
          child: Opacity(
            opacity: checkBoxes[1]["isChecked"]
                ? (checkBoxes[0]["isChecked"] ? 0.5 : 1.0)
                : 0.5,
            // Change opacity based on enabled/disabled state
            child: CheckboxTile(
              label: "Sec 1",
              value: checkBoxes[2]["isChecked"],
              onChanged: (value) {
                BlocProvider.of<CheckBoxBloc>(context).add(
                  ToggleNotificationEvent(index: 2, newValue: value ?? false),
                );
              },
            ),
          ),
        ),
        IgnorePointer(
          ignoring: checkBoxes[1]["isChecked"]
              ? checkBoxes[0]["isChecked"]
                  ? true
                  : false
              : true,
          // Disable tSec2 if Teachers checkbox is unchecked
          child: Opacity(
            opacity: checkBoxes[1]["isChecked"]
                ? (checkBoxes[0]["isChecked"] ? 0.5 : 1.0)
                : 0.5,
            // Change opacity based on enabled/disabled state
            child: CheckboxTile(
              label: "Sec 2",
              value: checkBoxes[3]["isChecked"],
              onChanged: (value) {
                BlocProvider.of<CheckBoxBloc>(context).add(
                  ToggleNotificationEvent(index: 3, newValue: value ?? false),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
