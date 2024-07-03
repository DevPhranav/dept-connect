import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../../../../static/date_to_display_format.dart';
import '../../../../domain/use_cases/send_update_message_use_case.dart';
import 'announcement_event.dart';
import 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final SendUpdateMessageUseCase sendUpdateMessageUseCase;

  bool isDetailsPage = false;

  AnnouncementBloc({required this.sendUpdateMessageUseCase})
      : super(AnnouncementInitialState(id: '')) {
    on<AnnouncementSendEvent>(_sendMessageToFirebase);
    on<AnnouncementInitialEvent>(_callInitialState);
    on<AnnouncementEditEvent>(_callEditInitialState);
    on<DetailsPageEditEvent>(_markAsIsDetailsPageEdit);
    on<AnnouncementEditSendEvent>(_callUpdateMessageToFirebase);
  }

  void _markAsIsDetailsPageEdit(
      DetailsPageEditEvent event, Emitter<AnnouncementState> emit) {
    isDetailsPage = event.isDetailsPageEdit;
    emit(AnnouncementEditFromDetailsPageState(id: '', isDetailsPageEditTriggered: isDetailsPage));
  }

  void _callEditInitialState(
      AnnouncementEditEvent event, Emitter<AnnouncementState> emit) {
    emit(AnnouncementEditInitialState(
        announcementMessage: event.announcementMessage,
        titleMessage: event.titleMessage,
        id: event.id,
        Eid: event.id,));
  }

  void _callInitialState(
      AnnouncementInitialEvent event, Emitter<AnnouncementState> emit) {
    emit(AnnouncementInitialState(id: ''));
  }

  Future<void> _callUpdateMessageToFirebase(
      AnnouncementEditSendEvent event, emit) async {
    try {
      // Send message and checkboxes data to Firestore using the FirestoreService
      emit(AnnouncementSendLoadingState(id: ''));
      print("usecase picked file : ${event.pickedFiles}");
      Map<String, dynamic> updatedData =
          await sendUpdateMessageUseCase.updateMessage(
        event.announcementMessage,
        event.titleMessage,
        event.checkBoxes,
        event.pickedFiles,
        event.editedDate,
        event.id,
        event.batchId,
      );

      // Emit a success state if sending to Firestore is successful
      emit(AnnouncementUpdateSuccessState(
          id: event.id,
          messageId: updatedData['messageId'],
          title: updatedData['titleMessage'],
          content: updatedData['announcementMessage'],
          sender: 'Hod',
          toWhom: updatedData['checkboxes'],
          fileInfo: updatedData['fileInfo'],
          timestamp: DateToDisplayFormat().formattedDate(updatedData['timestamp'], updatedData['editedDate']),
          batchId: updatedData['batchId'], isDetailsPage: event.isDetailsPageEditTriggered ));

    } catch (e) {
      print(e);
      // Emit a failure state if an error occurs during Firestore operation
      emit(AnnouncementSendFailureState(
          errorMessage: 'Failed to send data to Firebase: $e', id: event.id));
    }
  }

  void _sendMessageToFirebase(
      AnnouncementSendEvent event, Emitter<AnnouncementState> emit) async {
    try {
      // Send message and checkboxes data to Firestore using the FirestoreService
      emit(AnnouncementSendLoadingState(id: ''));
      await sendUpdateMessageUseCase.sendMessage(
        event.announcementMessage,
        event.titleMessage,
        event.checkBoxes,
        event.pickedFiles,
        event.editedDate,
        event.id,
        event.batchId,
      );

      // Emit a success state if sending to Firestore is successful
      emit(AnnouncementSendSuccessState(
          id: event.id, isDetailsPage: false));
    } catch (e) {
      print(e);
      // Emit a failure state if an error occurs during Firestore operation
      emit(AnnouncementSendFailureState(
          errorMessage: 'Failed to send data to Firebase: $e', id: event.id));
    }
  }
}
