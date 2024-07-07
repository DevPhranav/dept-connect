// BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_details_page_event.dart';
import 'message_details_page_state.dart';

class ParentMessageDetailsBloc
    extends Bloc<ParentMessageDetailsEvent, ParentMessageDetailsInitial> {
  ParentMessageDetailsBloc()
      : super(ParentMessageDetailsInitial(
      id: '',
      title: '',
      content: '',
      sender: '',
      toWhom: [],
      fileInfo: [],
      timestamp: '',
      batchId: '')) {
    on<ParentEditSuccessMessageEvent>(_editMessageAction);
    on<ParentMessageDetailsInitialEvent>(_detailsPageInitial);
  }

  void _detailsPageInitial(ParentMessageDetailsInitialEvent event, emit) {
    print(event.timestamp);
    emit(ParentMessageDetailsInitial(
        id: event.id,
        title: event.title,
        content: event.content,
        sender: event.sender,
        toWhom: event.toWhom,
        fileInfo: event.fileInfo,
        timestamp: event.timestamp,
        batchId: event.batchId));
  }


  void _editMessageAction(ParentEditSuccessMessageEvent event, emit) {
    emit(ParentMessageDetailsInitial(
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