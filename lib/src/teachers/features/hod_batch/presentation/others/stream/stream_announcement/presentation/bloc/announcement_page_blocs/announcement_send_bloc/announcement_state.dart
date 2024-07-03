import 'dart:io';

import 'package:equatable/equatable.dart';

class AnnouncementState extends Equatable {
  final String id;

  AnnouncementState({required this.id});

  @override
  List<Object?> get props => [id];
}

class AnnouncementInitialState extends AnnouncementState {
  AnnouncementInitialState({required super.id});
}

class AnnouncementSendLoadingState extends AnnouncementState {
  AnnouncementSendLoadingState({required super.id});
}

class AnnouncementSendSuccessState extends AnnouncementState {
  final bool isDetailsPage;

  AnnouncementSendSuccessState(
      {required this.isDetailsPage, required super.id});
}

class AnnouncementSendFailureState extends AnnouncementState {
  final String errorMessage;

  AnnouncementSendFailureState({required this.errorMessage, required super.id});

  @override
  List<Object?> get props => [errorMessage];
}

class AnnouncementEditInitialState extends AnnouncementState {
  final String announcementMessage;
  final String titleMessage;
  final String Eid;

  AnnouncementEditInitialState(
      {required super.id,
      required this.announcementMessage,
      required this.titleMessage,
      required this.Eid});
}

class AnnouncementEditFromDetailsPageState extends AnnouncementState {
  final bool isDetailsPageEditTriggered;

  AnnouncementEditFromDetailsPageState(
      {required super.id, required this.isDetailsPageEditTriggered});
}

class AnnouncementUpdateLoadingState extends AnnouncementState {
  AnnouncementUpdateLoadingState({required super.id});
}

class AnnouncementUpdateSuccessState extends AnnouncementState {
  final String messageId;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;
  final String batchId;
  final bool  isDetailsPage;

  AnnouncementUpdateSuccessState(

      { required this.isDetailsPage,
        required super.id,
      required this.messageId,
      required this.title,
      required this.content,
      required this.sender,
      required this.toWhom,
      required this.fileInfo,
      required this.timestamp,
      required this.batchId});
}

class AnnouncementUpdateFailureState extends AnnouncementState {
  final String errorMessage;

  AnnouncementUpdateFailureState(
      {required this.errorMessage, required super.id});

  @override
  List<Object?> get props => [errorMessage];
}
