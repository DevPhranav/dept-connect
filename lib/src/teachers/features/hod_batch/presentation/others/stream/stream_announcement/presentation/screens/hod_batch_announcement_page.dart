import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../../../../../static/loading_dialog.dart';
import '../bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import '../bloc/announcement_page_blocs/announcement_send_bloc/announcement_state.dart';
import 'checkbox_container.dart';
import 'build_announcement_tile.dart';
import 'file_upload_button.dart';
import 'floating_action_button.dart';

class HodBatchAnnouncementPage extends StatefulWidget {
  final String batchId;

  const HodBatchAnnouncementPage({super.key, required this.batchId});


  @override
  HodBatchAnnouncementPageState createState() =>
      HodBatchAnnouncementPageState();
}

class HodBatchAnnouncementPageState extends State<HodBatchAnnouncementPage> {
  FloatingActionButtons floatingButton = FloatingActionButtons();
  final TextEditingController _announcementMessage = TextEditingController();
  final TextEditingController _announcementTitleMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Announcement"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<AnnouncementBloc, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementSendLoadingState) {
            LoadingDialog.show(context);
          } else if (state is AnnouncementSendSuccessState || state is AnnouncementUpdateSuccessState) {
            LoadingDialog.hide(context);

            if (state is AnnouncementSendSuccessState && state.isDetailsPage ||
                state is AnnouncementUpdateSuccessState && state.isDetailsPage) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
            }


            if (state.id.isNotEmpty) {
              Fluttertoast.showToast(
                msg: "Message updated successfully!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
            else {
              Fluttertoast.showToast(
                msg: "Message posted successfully!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          } else if (state is AnnouncementSendFailureState) {
            LoadingDialog.hide(context);
            print('error :::::::::::::::${state.errorMessage}');
            Fluttertoast.showToast(
              msg: "Message sent failed! ${state.errorMessage}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
          builder: (context, state) {
            if (state is AnnouncementEditInitialState) {
              _announcementTitleMessage.text = state.titleMessage;
              _announcementMessage.text = state.announcementMessage;
            } else if (state is AnnouncementInitialState) {
              _announcementTitleMessage.clear();
              _announcementMessage.clear();
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: CheckBoxContainer().buildCheckBoxes(context),
                  ),
                  const SizedBox(height: 20),
                  BuildAnnouncementInputTile().buildAnnouncementTitleInputTile(
                      _announcementTitleMessage),
                  BuildAnnouncementInputTile().buildAnnouncementInputTile(
                      _announcementMessage),
                  FileUploadButton().buildFileUploadButton(context),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: BlocBuilder<AnnouncementBloc, AnnouncementState>(
        builder: (context, state) {
          if(state is AnnouncementEditFromDetailsPageState) {
            return floatingButton.buildFloatingActionButton(widget.batchId,
              context, _announcementMessage, _announcementTitleMessage,true);
          }
          else {
            return floatingButton.buildFloatingActionButton(widget.batchId,
              context, _announcementMessage, _announcementTitleMessage,false);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
