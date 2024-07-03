import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../externals/excel_pre_processor/excel_pre_processor.dart';

class PreprocessExcelUseCase {
  Future<List<List<List<dynamic>>>> execute(FilePickerResult? result) async {
    // Your ExcelProcessor class instance
    final excelProcessor = ExcelProcessor();

    // Process the Excel file
    final excelData = await excelProcessor.processExcelSheet(result);

    return excelData;
  }
}
