// BLoC
import 'package:flutter_bloc/flutter_bloc.dart';

import 'message_details_page_event.dart';
import 'message_details_page_state.dart';

class MessageDetailsBloc
    extends Bloc<MessageDetailsEvent, MessageDetailsInitial> {
  MessageDetailsBloc()
      : super(MessageDetailsInitial(
      id: '',
      title: '',
      content: '',
      sender: '',
      toWhom: [],
      fileInfo: [],
      timestamp: '',
      batchId: '')) {
    on<EditSuccessMessageEvent>(_editMessageAction);
    on<MessageDetailsInitialEvent>(_detailsPageInitial);
  }

  void _detailsPageInitial(MessageDetailsInitialEvent event, emit) {
    print(event.timestamp);
    emit(MessageDetailsInitial(
        id: event.id,
        title: event.title,
        content: event.content,
        sender: event.sender,
        toWhom: event.toWhom,
        fileInfo: event.fileInfo,
        timestamp: event.timestamp,
        batchId: event.batchId));
  }


  void _editMessageAction(EditSuccessMessageEvent event, emit) {
    print(" timestamp;;;;;;;;;;;;;;;${event.timestamp}");
    emit(MessageDetailsInitial(
        id: event.id,
        title: event.title,
        content: event.content,
        sender: event.sender,
        toWhom: event.toWhom,
        fileInfo: event.fileInfo,
        timestamp: event.timestamp,
        batchId: event.batchId));
  }

}