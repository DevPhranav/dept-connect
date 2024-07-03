import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/message_usecase.dart';
import 'message_show_event.dart';
import 'message_show_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessagesState> {
  final MessageUseCase messageUseCase;
  StreamSubscription? _messageSubscription;
   String batchId='';
  MessageBloc({required this.messageUseCase}) : super(MessageInitialState()) {
    on<LoadMessageInitialEvent>(_onInitial);
    on<LoadMessagesEvent>(_onLoadMessages);
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


  void _onLoadMessages(LoadMessagesEvent event, Emitter<MessagesState> emit) async {
    emit(MessageLoadingState());
    try {
      final messages = await messageUseCase.loadMessages(event.batchId);
      emit(MessageLoadedState(messages));
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  void _onUpdateMessages(UpdateMessagesEvent event, Emitter<MessagesState> emit) {
    emit(MessageLoadedState(event.messages));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
