
import 'package:file_picker/file_picker.dart';

import '../externals/validator/excel_validator.dart';

class ValidateExcelFileUseCase {
  final ExcelFileValidator excelFileValidator;

  ValidateExcelFileUseCase({required this.excelFileValidator});

  Future<Map<String, String>> execute(String batchYear, String seniorTutorId, FilePickerResult? selectedFile) async {
    String batchYearError = excelFileValidator.checkBatchName(batchYear);
    String seniorTutorError = excelFileValidator.checkSeniorTutorId(seniorTutorId);
    String fileError = await excelFileValidator.checkExcelHead(selectedFile);

    return {
      'batchYearError': batchYearError,
      'seniorTutorError': seniorTutorError,
      'fileError': fileError,
    };
  }
}
