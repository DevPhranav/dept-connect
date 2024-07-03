import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class ExcelFileValidator {
  List<List<List<dynamic>>> requiredColumns = [
    [
      ["roll_no", "student_name", "college_email", "phone_no", "section", "parent_name", "parent_email", "parent_ph_no"]
    ],
    [
      ["faculty_id", "course_id", "section"]
    ],
    [
      ["Tutor", "section"]
    ]
  ];

  String checkBatchName(String batchName) {
    if (batchName.isEmpty) {
      return 'Please enter batch Year';
    } else {
      List<String> years = batchName.split('-');
      if (years.length == 2) {
        try {
          int firstYear = int.parse(years[0]);
          int secondYear = int.parse(years[1]);
          int difference = secondYear - firstYear;
          int currentYear = DateTime.now().year;

          // if (firstYear < currentYear || secondYear < currentYear) {
          //   return 'Batch year should not be in the past.';
          // }

          if (difference == 4) {
            return '';
          } else {
            return 'Batch year should span exactly 4 years.';
          }
        } catch (e) {
          return 'Invalid batch year format.';
        }
      } else {
        return 'Invalid batch year format.';
      }
    }
  }


  String checkSeniorTutorId(String seniorTutorId) {
    if (seniorTutorId.isEmpty) {
      return 'Please enter senior tutor ID';
    } else {
      return '';
    }
  }

  Future<String> checkExcelHead(FilePickerResult? result) async {
    if (result == null) {
      return "No file selected";
    }

    try {
      File file = File(result.files.single.path!);
      List<List<List<dynamic>>> firstRowData = await processFirstRowExcelSheet(file);
      return compareColumns(firstRowData) ? "" : "Columns are not in correct order";
    } catch (e) {
      print('Error picking or processing Excel file: $e');
      return "Error processing Excel file";
    }
  }

  Future<List<List<List<dynamic>>>> processFirstRowExcelSheet(File file) async {
    try {
      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);
      List<List<List<dynamic>>> allExcelData = [];

      for (var table in excel.tables.keys) {
        List<List<dynamic>> excelData = [];
        var sheet = excel.tables[table]!;
        if (sheet.rows.isNotEmpty) {
          var firstRow = sheet.rows.first;
          var rowData = firstRow.map((cell) => cell?.value).toList();
          excelData.add(removeTrailingNulls(rowData));
        }
        if (excelData.isNotEmpty) {
          allExcelData.add(excelData);
        }
      }
      return allExcelData;
    } catch (e) {
      print('Error reading Excel file: $e');
      return [];
    }
  }

  List<dynamic> removeTrailingNulls(List<dynamic> rowData) {
    while (rowData.isNotEmpty && rowData.last == null) {
      rowData.removeLast();
    }
    return rowData;
  }

  bool compareColumns(List<List<List<dynamic>>> processedArray) {
    List<dynamic> flattenedProcessedArray = [];
    for (var array2D in processedArray) {
      for (var array1D in array2D) {
        flattenedProcessedArray.addAll(array1D);
      }
    }

    List<dynamic> flattenedRequiredColumns = [];
    for (var array2D in requiredColumns) {
      for (var array1D in array2D) {
        flattenedRequiredColumns.addAll(array1D);
      }
    }

    if (flattenedProcessedArray.length != flattenedRequiredColumns.length) {
      return false;
    }

    for (int i = 0; i < flattenedProcessedArray.length; i++) {
      if (flattenedProcessedArray[i].toString() != flattenedRequiredColumns[i].toString()) {
        return false;
      }
    }

    return true;
  }
}
