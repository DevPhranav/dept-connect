import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/models/auth_user_model.dart';

import '../../../../../../../../../../static/snack_bar_helper.dart';
import '../bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import '../bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import '../bloc/announcement_page_blocs/announcement_send_bloc/announcement_event.dart';
import '../bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';

class FloatingActionButtons {
  FloatingActionButton buildFloatingActionButton(
      String batchId,
      BuildContext context,
      TextEditingController announcementMessage,
      TextEditingController announcementTitleMessage, bool isDetailsPage,AuthUserModel? user) {
    return FloatingActionButton(
      onPressed: () {
        final checkBoxState = BlocProvider.of<CheckBoxBloc>(context).state;
        final pickedFiles = BlocProvider.of<FilePickBloc>(context).uploadedFiles;
        final idState = BlocProvider.of<AnnouncementBloc>(context).state;
        final id=idState.id;

        if (announcementMessage.text.isEmpty &&
            announcementTitleMessage.text.isEmpty) {
          SnackBarHelper.showSnackBar(
              context, 'Please enter a message and title before sending.');
        } else if (!checkBoxState.hasCheckedCheckbox()) {
          SnackBarHelper.showSnackBar(
              context, 'Please select at least one checkbox.');
        } else {
          print("id : $id");
          if (id.isNotEmpty) {
            BlocProvider.of<AnnouncementBloc>(context).add(
              AnnouncementEditSendEvent(
                announcementMessage: announcementMessage.text,
                titleMessage: announcementTitleMessage.text,
                checkBoxes: checkBoxState.checkBoxes,
                id: id,
                editedDate: DateTime.now(),
                pickedFiles: pickedFiles,
                batchId: batchId, isDetailsPageEditTriggered: isDetailsPage,
              ),
            );
          } else {
            BlocProvider.of<AnnouncementBloc>(context).add(
              AnnouncementSendEvent(
                announcementMessage: announcementMessage.text,
                titleMessage: announcementTitleMessage.text,
                checkBoxes: checkBoxState.checkBoxes,
                pickedFiles: pickedFiles,
                editedDate: DateTime.now(),
                id: id,
                batchId:batchId,
                sender:user!.name
              ),
            );
          }
        }
      },
      foregroundColor: Colors.grey[150],
      backgroundColor: Colors.grey,
      child: const Icon(Icons.send),
    );
  }
}
