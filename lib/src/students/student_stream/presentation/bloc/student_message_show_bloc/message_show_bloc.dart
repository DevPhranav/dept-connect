import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/student_message_usecase.dart';
import 'message_show_event.dart';
import 'message_show_state.dart';

class StudentMessageBloc extends Bloc<StudentMessageEvent, StudentMessagesState> {
  final StudentMessageUseCase messageUseCase;
  StreamSubscription? _messageSubscription;
   String batchId='';
  StudentMessageBloc({required this.messageUseCase}) : super(StudentMessageInitialState()) {
    on<StudentLoadMessageInitialEvent>(_studentOnInitial);
    on<StudentLoadMessagesEvent>(_studentOnLoadMessages);
    on<StudentUpdateMessagesEvent>(_studentOnUpdateMessages);


  }

  void studentSetBatchId(String batchId) {
    this.batchId = batchId;
    _messageSubscription?.cancel(); // Cancel previous subscription
    _messageSubscription = messageUseCase.getMessageStream(batchId).listen((messages) {
      add(StudentUpdateMessagesEvent(messages));
    });
  }


  void _studentOnInitial(StudentLoadMessageInitialEvent event,emit)
  {
     batchId= event.batchId;
  }


  void _studentOnLoadMessages(StudentLoadMessagesEvent event, Emitter<StudentMessagesState> emit) async {
    emit(StudentMessageLoadingState());
    try {
      final messages = await messageUseCase.loadMessages(event.batchId);
      emit(StudentMessageLoadedState(messages));
    } catch (e) {
      emit(StudentMessageErrorState(e.toString()));
    }
  }

  void _studentOnUpdateMessages(StudentUpdateMessagesEvent event, Emitter<StudentMessagesState> emit) {
    emit(StudentMessageLoadedState(event.messages));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
