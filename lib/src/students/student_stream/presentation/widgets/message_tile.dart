import 'package:flutter/material.dart';
import '../../../../../../../../../static/date_to_display_format.dart';
import '../../../../../../../../../static/file_icon_choose.dart';
class StudentMessageTile extends StatelessWidget {
  final String title;
  final DateTime date;
  final String content;
  final List<Map<String, dynamic>> attachmentFiles;
  final List<dynamic> toWhom;
  final VoidCallback onTap;
  final String id;
  final DateTime editedDate;
  final String batchId;
  final String sender;


  const StudentMessageTile({
    super.key,
    required this.title,
    required this.date,
    required this.content,
    required this.attachmentFiles,
    required this.onTap,
    required this.id,
    required this.toWhom, required this.editedDate,required this.batchId,required this.sender
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        color: Colors.grey[200],
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[50],
                            child: const Icon(Icons.message),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              truncateFileName(title,15),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                          DateToDisplayFormat().formattedDate(date, editedDate),
                              // Change this to your date formatting logic
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              sender,
                              // Change this to your date formatting logic
                              style: const TextStyle(
                                color:Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _truncateContent(content, 15),
                    ),
                    const SizedBox(height: 20),
                    _buildAttachmentFiles(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateContent(String content, int maxLength) {
    if (content.length <= maxLength) {
      return content;
    }

    int nextSpaceIndex = content.indexOf(' ', maxLength);
    if (nextSpaceIndex != -1) {
      return '${content.substring(0, nextSpaceIndex)}...';
    }

    return '${content.substring(0, maxLength)}...';
  }

  Widget _buildAttachmentFiles() {
    if (attachmentFiles.isEmpty) {
      return Container();
    }

    List<Widget> attachmentWidgets = [];
    for (int i = 0; i < attachmentFiles.length && i < 2; i++) {
      attachmentWidgets
          .add(_buildAttachmentWidget(attachmentFiles[i]['fileName']));
    }

    if (attachmentFiles.length > 2) {
      attachmentWidgets.add(
        Text('+${attachmentFiles.length - 2} more attachments'),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: attachmentWidgets,
      ),
    );
  }

  String truncateFileName(String fileName, int maxLength) {
    int extIndex = fileName.lastIndexOf('.');
    if (extIndex == -1) {
      return fileName.length > maxLength
          ? '${fileName.substring(0, maxLength)}...'
          : fileName;
    }

    String baseName = fileName.substring(0, extIndex);
    String extension = fileName.substring(extIndex);

    if (baseName.length > maxLength) {
      baseName = '${baseName.substring(0, maxLength)}...';
    }
    return baseName + extension;
  }

  Widget _buildAttachmentWidget(String fileName) {
    String extension = fileName
        .split('.')
        .last
        .toLowerCase();
    String truncatedFileName = truncateFileName(fileName, 20);

    // Use your FileIconChoose logic to get the icon based on the file extension
    String iconData = FileIconChoose().getIcon(extension);

    return Row(
      children: [
       Image.asset(
         'lib/assets/icons/$iconData.png',
         width: 24, // Set the width of the image
         height: 24, // Set the height of the image
       ),
        const SizedBox(width: 8.0),
        Text(truncatedFileName),
      ],
    );
  }
}
