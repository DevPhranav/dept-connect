import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../domain/usecases/message_usecase.dart';
import 'message_remove_state.dart';
import 'message_remove_event.dart';

class MessageRemoveBloc extends Bloc<MessageRemoveEvent, MessageRemoveState> {

  final MessageUseCase messageUseCase;

  MessageRemoveBloc({required this.messageUseCase}) : super(MessageRemoveInitial()) {
    on<RemoveMessageEvent>(_callRemoveMethod);
  }

  _callRemoveMethod(RemoveMessageEvent event, Emitter<MessageRemoveState> emit) async {
    emit(MessageRemoveInProgress());
    try {

      messageUseCase.removeMessage(event.id,event.fileInfo,event.batchId);

       emit(MessageRemoveSuccess());
      Fluttertoast.showToast(
        msg: "Message and attachments removed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print(e);
      emit(MessageRemoveFailure(error: e.toString()));
      Fluttertoast.showToast(
        msg: "Failed to remove message: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

}

