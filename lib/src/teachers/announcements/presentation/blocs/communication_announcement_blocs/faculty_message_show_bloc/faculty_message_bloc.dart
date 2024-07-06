import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../authentication/auth/data/models/auth_user_model.dart';
import '../../../../domain/usecases/faculty_message_use_case.dart';
import 'faculty_message_event.dart';
import 'faculty_message_state.dart';


class FacultyMessageBloc extends Bloc<FacultyMessageEvent, FacultyMessagesState> {
  final FacultyMessageUseCase messageUseCase;
  StreamSubscription? _messageSubscription;
  String batchId='';
  FacultyMessageBloc({required this.messageUseCase}) : super(FacultyMessageInitialState()) {
    on<FacultyLoadMessageInitialEvent>(_studentOnInitial);
    on<FacultyLoadMessagesEvent>(_studentOnLoadMessages);
    on<FacultyUpdateMessagesEvent>(_studentOnUpdateMessages);


  }

  void facultySetBatchId(AuthUserModel? user) {
    this.batchId = batchId;
    _messageSubscription?.cancel(); // Cancel previous subscription
    _messageSubscription = messageUseCase.getMessageStream(user?.facultyId ?? "").listen((messages) {
      add(FacultyUpdateMessagesEvent(messages));
    });
  }


  void _studentOnInitial(FacultyLoadMessageInitialEvent event,emit)
  {
    batchId= event.batchId;
  }


  void _studentOnLoadMessages(FacultyLoadMessagesEvent event, Emitter<FacultyMessagesState> emit) async {
    emit(FacultyMessageLoadingState());
    try {
      final messages = await messageUseCase.loadMessages(event.user?.facultyId ?? "");
      emit(FacultyMessageLoadedState(messages));
    } catch (e) {
      emit(FacultyMessageErrorState(e.toString()));
    }
  }

  void _studentOnUpdateMessages(FacultyUpdateMessagesEvent event, Emitter<FacultyMessagesState> emit) {
    emit(FacultyMessageLoadedState(event.messages));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
