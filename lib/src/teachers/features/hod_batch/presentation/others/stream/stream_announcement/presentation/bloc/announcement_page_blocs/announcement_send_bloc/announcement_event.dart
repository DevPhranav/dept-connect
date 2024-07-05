import 'dart:io';

import 'package:equatable/equatable.dart';

class AnnouncementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnnouncementInitialEvent extends AnnouncementEvent {}

class AnnouncementSendEvent extends AnnouncementEvent {
  final String announcementMessage;
  final String titleMessage;
  final List<Map<String, dynamic>> checkBoxes;
  final List<File> pickedFiles;
  final DateTime editedDate;
  final String id;
  final String batchId;
  final String? sender;
  AnnouncementSendEvent(
      {required this.announcementMessage,
      required this.titleMessage,
      required this.checkBoxes,
      required this.pickedFiles,
      required this.editedDate,required this.id,required this.batchId,required this.sender});

  @override
  List<Object?> get props =>
      [announcementMessage, titleMessage, checkBoxes, pickedFiles,batchId,id];
}

class AnnouncementEditEvent extends AnnouncementEvent {
  final String announcementMessage;
  final String titleMessage;
  final String id;
  final String batchId;



  AnnouncementEditEvent({
    required this.announcementMessage,
    required this.titleMessage,
    required this.id,
    required this.batchId,
  });
}

class AnnouncementEditSendEvent extends AnnouncementEvent {
  final bool isDetailsPageEditTriggered;
  final String announcementMessage;
  final String titleMessage;
  final List<Map<String, dynamic>> checkBoxes;
  final String id;
  final DateTime editedDate;
  final List<File> pickedFiles;
  final String batchId;

  AnnouncementEditSendEvent(
      { required this.isDetailsPageEditTriggered,
        required this.announcementMessage,
      required this.titleMessage,
      required this.checkBoxes,
      required this.id,required this.editedDate,required this.pickedFiles,required this.batchId});
}

class DetailsPageEditEvent extends AnnouncementEvent{
  final bool isDetailsPageEdit;

  DetailsPageEditEvent({required this.isDetailsPageEdit});
}
