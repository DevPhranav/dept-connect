import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

import '../bloc/batch_creation_bloc/batch_creation_bloc.dart';
import '../bloc/batch_creation_bloc/batch_creation_event.dart';
import '../bloc/batch_creation_bloc/batch_creation_state.dart';
import '../bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_bloc.dart';
import '../bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_state.dart';
import '../bloc/batch_year_bloc/batch_year_bloc.dart';
import '../bloc/batch_year_bloc/batch_year_event.dart';
import '../bloc/batch_year_bloc/batch_year_state.dart';
import '../bloc/file_pick_bloc/file_pick_bloc.dart';
import '../bloc/file_pick_bloc/file_pick_event.dart';
import '../bloc/file_pick_bloc/file_pick_state.dart';
import '../widgets/drop_down_button.dart';

class BatchCreationPage extends StatefulWidget {
  const BatchCreationPage({super.key});

  @override
  State<BatchCreationPage> createState() => _BatchCreationPageState();
}

class _BatchCreationPageState extends State<BatchCreationPage> {
  final TextEditingController _batchYearController = TextEditingController();
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batch Creation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Add any actions for the three-dot vertical icon
            },
          ),
        ],
      ),
      body: BlocListener<BatchCreationBloc, BatchCreationState>(
        listener: (context, state) {
          if (state is BatchValidationSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Batch Validation Success'),
                  content: Text('Are you sure you want to continue?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final String batchYear = context.read<BatchYearBloc>().state.batchYear;
                        final String seniorTutor = context.read<DropdownBloc>().state.selectedItem;
                        final String tutorCode = seniorTutor.split(' ')[0];
                        final FilePickerResult? selectedFile = context.read<BatchCreationFilePickerBloc>().state.selectedFile;
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<BatchCreationBloc>(context).add(StartBatchCreationProcess(selectedFile: selectedFile, batchYear: batchYear, seniorTutorId: tutorCode));
                      },
                      child: Text('Continue'),
                    ),
                  ],
                );
              },
            );
          } else if (state is BatchCreationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is BatchCreationSuccess) {
            Navigator.pushReplacementNamed(context, '/hod_space');
          }
          else if(state is BatchCreationLoading)
            {

            }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStartingYearSelection(context),
                const SizedBox(height: 16.0),
                _buildSeniorTutorIdDropDown(),
                _buildUploadBatchExcelFile(context),
                _buildSelectedFileInfo(context),
                ElevatedButton(
                  onPressed: () {
                    final String batchYear = context.read<BatchYearBloc>().state.batchYear;
                    final String seniorTutor = context.read<DropdownBloc>().state.selectedItem;
                    final FilePickerResult? selectedFile = context.read<BatchCreationFilePickerBloc>().state.selectedFile;
                    BlocProvider.of<BatchCreationBloc>(context).add(
                        ProcessBatchValidation(batchYear: batchYear, seniorTutor: seniorTutor, selectedFile: selectedFile)
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    side: MaterialStateProperty.all(const BorderSide(width: 0.1)),
                    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 55.0)),
                  ),
                  child: BlocBuilder<BatchCreationBloc, BatchCreationState>(
                    builder: (context, state) {
                      if (state is BatchCreationLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Text(
                          'Process Excel',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartingYearSelection(BuildContext bContext) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select the Batch Starting Year'),
          BlocBuilder<BatchYearBloc, BatchYearState>(
            builder: (context, state) {
              _batchYearController.text = state.batchYear;
              return TextFormField(
                controller: _batchYearController,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    initialDatePickerMode: DatePickerMode.year,
                  );
                  if (date != null) {
                    BlocProvider.of<BatchYearBloc>(context)
                        .add(BatchYearChanged('${date.year}-${date.year + 4}'));
                  }
                },
                readOnly: true,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSeniorTutorIdDropDown() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Senior Tutor ID'),
          BlocBuilder<DropdownBloc, DropdownState>(
            builder: (context, state) {
              return BlocProvider.value(
                value: context.read<DropdownBloc>(),
                child: const SimpleDropDownField(
                  hintText: 'Select a Senior Tutor ID',
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBatchExcelFile(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Upload Batch Excel File'),
          const Icon(
            Icons.cloud_upload,
            size: 150,
          ),
          const SizedBox(height: 8.0),
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xls', 'xlsx'],
              );
              if (result != null) {
                context
                    .read<BatchCreationFilePickerBloc>()
                    .add(FileSelected(result));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tap to Upload'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedFileInfo(BuildContext context) {
    return BlocBuilder<BatchCreationFilePickerBloc, FilePickerState>(
        builder: (context, state) {
      if (state is FilePickerLoaded) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
    color: Colors.grey,
    border: Border.all(),
    borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            state.selectedFile?.files.single.name ?? 'No file selected',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<BatchCreationFilePickerBloc>().add(ClearFileSelected());
          },
        ),
      ],
    ),
        );
      }
      return Container();
        },
    );
  }
}
