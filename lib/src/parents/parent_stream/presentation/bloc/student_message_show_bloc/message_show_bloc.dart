import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/parent_message_usecase.dart';
import 'message_show_event.dart';
import 'message_show_state.dart';

class ParentMessageBloc extends Bloc<ParentMessageEvent, ParentMessagesState> {
  final ParentMessageUseCase messageUseCase;
  StreamSubscription? _messageSubscription;
   String batchId='';
  ParentMessageBloc({required this.messageUseCase}) : super(ParentMessageInitialState()) {
    on<ParentLoadMessageInitialEvent>(_parentOnInitial);
    on<ParentLoadMessagesEvent>(_ParentOnLoadMessages);
    on<ParentUpdateMessagesEvent>(_ParentOnUpdateMessages);


  }

  void parentSetBatchId(String batchId) {
    this.batchId = batchId;
    _messageSubscription?.cancel(); // Cancel previous subscription
    _messageSubscription = messageUseCase.getMessageStream(batchId).listen((messages) {
      add(ParentUpdateMessagesEvent(messages));
    });
  }


  void _parentOnInitial(ParentLoadMessageInitialEvent event,emit)
  {
     batchId= event.batchId;
  }


  void _ParentOnLoadMessages(ParentLoadMessagesEvent event, Emitter<ParentMessagesState> emit) async {
    emit(ParentMessageLoadingState());
    try {
      final messages = await messageUseCase.loadMessages(event.batchId);
      emit(ParentMessageLoadedState(messages));
    } catch (e) {
      emit(ParentMessageErrorState(e.toString()));
    }
  }

  void _ParentOnUpdateMessages(ParentUpdateMessagesEvent event, Emitter<ParentMessagesState> emit) {
    emit(ParentMessageLoadedState(event.messages));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
