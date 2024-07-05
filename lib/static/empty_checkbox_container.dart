import 'package:flutter/material.dart';
import 'checkbox_title.dart';


class EmptyCheckBoxContainer {
  final List<dynamic> checkedBoxes;

  EmptyCheckBoxContainer({required this.checkedBoxes});

  Column buildCheckBoxes(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Opacity(
                  opacity: checkedBoxes.contains("all") ? 1.0 : 0.5,
                  child: CheckboxTile(

                    label: "All",
                    value: checkedBoxes.contains("all"),
                    onChanged: (value) {
                      // Handle onChanged
                    },
                  ),
                ),
                Opacity(
                  opacity: checkedBoxes.any((box) => box.startsWith("seniorTutor")) ? 1.0 : 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: CheckboxTile(
                      label: "Senior Tutor",
                      value: checkedBoxes.any((box) => box.startsWith("seniorTutor")),
                      onChanged: (value) {
                        // Handle onChanged
                      },
                    ),
                  ),
                )

              ],
            ),
            teachersRow(context),
            studentsRow(context),
            parentsRow(context),
          ],
        ),
      ],
    );
  }

  Row parentsRow(BuildContext context) {
    return Row(
      children: [
        Opacity(
          opacity: checkedBoxes.contains("parents") ? 1.0 : 0.5,
          child: CheckboxTile(
            label: "Parents",
            value: checkedBoxes.contains("parents"),
            onChanged: (value) {
              // Handle onChanged
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 11.0),
          child: Icon(Icons.arrow_right),
        ),
        Opacity(
          opacity: checkedBoxes.contains("pSec1") ? 1.0 : 0.5,
          child: CheckboxTile(
            label: "Sec1",
            value: checkedBoxes.contains("pSec1"),
            onChanged: (value) {
              // Handle onChanged
            },
          ),
        ),
        Opacity(
          opacity: checkedBoxes.contains("pSec2") ? 1.0 : 0.5,
          child: CheckboxTile(
            label: "Sec2",
            value: checkedBoxes.contains("pSec2"),
            onChanged: (value) {
              // Handle onChanged
            },
          ),
        ),
      ],
    );
  }

  Row studentsRow(BuildContext context) {
    return Row(
      children: [
        Opacity(
          opacity: checkedBoxes.contains("students") ? 1.0 : 0.5,
          child: CheckboxTile(
            label: "Students",
            value: checkedBoxes.contains("students"),
            onChanged: (value) {
              // Handle onChanged
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 3.0),
          child: Icon(Icons.arrow_right),
        ),
        Row(
          children: [
            Opacity(
              opacity: checkedBoxes.contains("sSec1") ? 1.0 : 0.5,
              child: CheckboxTile(
                label: "Sec1",
                value: checkedBoxes.contains("sSec1"),
                onChanged: (value) {
                  // Handle onChanged
                },
              ),
            ),
            Opacity(
              opacity: checkedBoxes.contains("sSec2") ? 1.0 : 0.5,
              child: CheckboxTile(
                label: "Sec2",
                value: checkedBoxes.contains("sSec2"),
                onChanged: (value) {
                  // Handle onChanged
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row teachersRow(BuildContext context) {
    return Row(
      children: [
        Opacity(
          opacity: checkedBoxes.contains("teachers") ? 1.0 : 0.5,
          child: CheckboxTile(
            label: "Teachers",
            value: checkedBoxes.contains("teachers"),
            onChanged: (value) {
              // Handle onChanged
            },
          ),
        ),
        const Icon(Icons.arrow_right),
        Opacity(
          opacity: checkedBoxes.contains("tSec1") ? 1.0 : 0.5,
          child: CheckboxTile(
            label: "Sec1",
            value: checkedBoxes.contains("tSec1"),
            onChanged: (value) {
              // Handle onChanged
            },
          ),
        ),
        Opacity(
          opacity: checkedBoxes.contains("tSec2") ? 1.0 : 0.5,
          child: CheckboxTile(
            label: "Sec2",
            value: checkedBoxes.contains("tSec2"),
            onChanged: (value) {
              // Handle onChanged
            },
          ),
        ),
      ],
    );
  }
}
