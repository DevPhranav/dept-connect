import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/student_message_usecase.dart';
import 'message_show_event.dart';
import 'message_show_state.dart';

class StudentMessageBloc extends Bloc<StudentMessageEvent, StudentMessagesState> {
  final StudentMessageUseCase messageUseCase;
  StreamSubscription? _messageSubscription;
   String batchId='';
  StudentMessageBloc({required this.messageUseCase}) : super(MessageInitialState()) {
    on<LoadMessageInitialEvent>(_onInitial);
    on<StudentLoadMessagesEvent>(_onLoadMessages);
    on<UpdateMessagesEvent>(_onUpdateMessages);


  }

  void setBatchId(String batchId) {
    this.batchId = batchId;
    _messageSubscription?.cancel(); // Cancel previous subscription
    _messageSubscription = messageUseCase.getMessageStream(batchId).listen((messages) {
      add(UpdateMessagesEvent(messages));
    });
  }

  void _onInitial(LoadMessageInitialEvent event,emit)
  {
     batchId= event.batchId;
  }


  void _onLoadMessages(StudentLoadMessagesEvent event, Emitter<StudentMessagesState> emit) async {
    emit(MessageLoadingState());
    try {
      final messages = await messageUseCase.loadMessages(event.batchId);
      emit(MessageLoadedState(messages));
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  void _onUpdateMessages(UpdateMessagesEvent event, Emitter<StudentMessagesState> emit) {
    emit(MessageLoadedState(event.messages));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
