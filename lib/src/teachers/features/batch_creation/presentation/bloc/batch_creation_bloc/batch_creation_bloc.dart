import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/externals/batchDataProcessor/batch_data_convert_processor.dart';
import '../../../domain/externals/batchDataProcessor/batch_data_model_processor.dart';
import '../../../domain/usecases/batch_year_check_use_case.dart';
import '../../../domain/usecases/excel_error_check_usecase.dart';
import '../../../domain/usecases/pre_process_excel_use_case.dart';
import '../../../domain/usecases/push_batch_data_usecase.dart';
import '../file_pick_bloc/file_pick_bloc.dart';
import 'batch_creation_event.dart';
import 'batch_creation_state.dart';

class BatchCreationBloc extends Bloc<BatchCreationEvent, BatchCreationState> {
  final ValidateExcelFileUseCase validateExcelFileUseCase;
  final PreprocessExcelUseCase preprocessExcelUseCase;
  final PushBatchDataUseCase pushBatchDataUseCase;
  final BatchYearCheckUseCase batchYearCheckUseCase;
  BatchCreationBloc({required this.batchYearCheckUseCase, required this.pushBatchDataUseCase,required this.preprocessExcelUseCase, required this.validateExcelFileUseCase}) : super(BatchCreationInitial()) {
    on<ProcessBatchValidation>(_processBatchValidation);
    on<StartBatchCreationProcess>(_startBatchCreationProcess);
  }


  void _startBatchCreationProcess(StartBatchCreationProcess event, Emitter<BatchCreationState> emit) async {
    emit(BatchCreationLoading());
    try {
      // Preprocess the Excel file
      List<List<List<dynamic>>> excelData = await preprocessExcelUseCase.execute(event.selectedFile);
      // Convert excelData to respective entities
      final modelProcessor = BatchDataProcessor();
      final convertProcessor = BatchDataConvertProcessor();
      final students = modelProcessor.convertToStudents(excelData[0]).map((student) => student.toEntity()).toList();
      final courseTeachers = modelProcessor.convertToCourseTeachers(excelData[1]).map((courseTeacher) => courseTeacher.toEntity()).toList();
      final tutors = modelProcessor.convertToTutors(excelData[2]).map((tutor) => tutor.toEntity()).toList();
      final batchData = convertProcessor.createBatchData(students,courseTeachers,tutors,event.batchYear,event.seniorTutorId);
      // Push batch data
      await pushBatchDataUseCase.execute(batchData, students, courseTeachers, tutors);

      emit(BatchCreationSuccess());
    } catch (error) {
      emit(BatchCreationFailure(error.toString()));
    }
  }

  void _processBatchValidation(event, emit) async {
    emit(BatchCreationLoading());
    try {
      final errors = await validateExcelFileUseCase.execute(event.batchYear, event.seniorTutor, event.selectedFile);
      if (errors['batchYearError']!.isEmpty && errors['seniorTutorError']!.isEmpty && errors['fileError']!.isEmpty) {
        // Process the excel file here
        // Example: print information
        // print('Batch Year: ${event.batchYear}');
        // print('Senior Tutor ID: ${event.seniorTutor}');
        // print('File: ${event.selectedFile?.paths}');

        final result = await batchYearCheckUseCase.execute(event.batchYear);
        if(result == "Batch year already exists")
          {
            emit(BatchCreationFailure(result));
          }
        else{
          emit(const BatchValidationSuccess('Batch validation process successful.'));
        }
      } else {
        String errorMessage = '';
        if (errors['batchYearError']!.isNotEmpty) errorMessage += '${errors['batchYearError']}\n';
        if (errors['seniorTutorError']!.isNotEmpty) errorMessage += '${errors['seniorTutorError']}\n';
        if (errors['fileError']!.isNotEmpty) errorMessage += '${errors['fileError']}\n';

        emit(BatchCreationFailure(errorMessage.trim()));
      }
    } catch (error) {
      emit(BatchCreationFailure(error.toString()));
    }
  }

}
