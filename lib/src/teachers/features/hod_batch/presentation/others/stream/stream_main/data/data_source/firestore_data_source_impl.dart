import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/repositories/FirestoreDataSource.dart';

class FirestoreDataSourceImpl implements FirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<Map<String, dynamic>> updateMessageToFirebase(
      String messageId,
      String announcementMessage,
      String titleMessage,
      List<Map<String, dynamic>> checkboxes,
      DateTime editedDate,
      List<File> newFiles,
      String batchId) async {
    try {
      // Filter the selected categories based on checkboxes
      List selectedCategories = checkboxes
          .where((checkbox) => checkbox['isChecked'] == true)
          .map((checkbox) => checkbox['name'])
          .toList();

      print('categories $selectedCategories');

      // Reference to the Firestore document to update
      DocumentReference docRef = _firestore
          .collection('departments')
          .doc('CSE')
          .collection('batches')
          .doc(batchId)
          .collection('batchesMessages')
          .doc(messageId);

      // Fetch the document to check its existence
      DocumentSnapshot docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        throw Exception('Document does not exist');
      }

      Timestamp creationTimestamp = docSnapshot['timestamp'];
      DateTime creationDateTime = creationTimestamp.toDate();

      // Get the document ID
      String docId = docRef.id;

      // Reference to the folder in Firebase Storage
      String folderPath = 'uploads/$docId';
      print(folderPath);
      final folderRef = _storage.ref(folderPath);

      // List all files in the directory and delete them
      ListResult listResult = await folderRef.listAll();
      for (Reference fileRef in listResult.items) {
        await fileRef.delete();
      }

      List<Map<String, String>> filesInfo = [];

      // Upload new files to Firebase Storage and get download URLs
      for (File file in newFiles) {
        String fileName = file.path.split('/').last;
        Reference fileRef = folderRef.child(fileName);
        await fileRef.putFile(file);
        String downloadUrl = await fileRef.getDownloadURL();
        filesInfo.add({'fileName': fileName, 'downloadUrl': downloadUrl});
      }

      // Update the document with the new message content and file information
      await docRef.update({
        'title': titleMessage,
        'content': announcementMessage,
        'toWhom': selectedCategories,
        'editedDate': editedDate,
        'fileInfo': filesInfo,
      });


      Map<String, dynamic> updatedData = {
        'messageId': messageId,
        'titleMessage': titleMessage,
        'announcementMessage': announcementMessage,
        'checkboxes': selectedCategories,
        'editedDate': editedDate,
        'fileInfo':filesInfo,
        'batchId': batchId,
        'timestamp':creationDateTime
      };
      return updatedData;
    } catch (e) {
      print('Failed to update message in Firebase: $e');
      throw e;
    }
  }


  Future<void> removeFiles(List<dynamic> downloadUrls) async {
    try {
      for (final url in downloadUrls) {
        final storageRef = _storage.refFromURL(url);
        await storageRef.delete();
        print('File deleted: $url');
      }
    } catch (e) {
      print('Failed to remove files: $e');
      throw e;
    }
  }

  @override
  Future<void> removeMessage(
      String id, List<Map<String, dynamic>> fileInfo, String batchId) async {
    if (id.isEmpty) {
      throw Exception('Invalid message ID');
    }

    try {
      // Delete files in Firebase Storage using download URLs
      for (final file in fileInfo) {
        final downloadURL = file['downloadUrl'] as String;
        final storageRef = _storage.refFromURL(downloadURL);
        await storageRef.delete();
        print('File deleted: $downloadURL');
      }

      // Check if the message document exists in Firestore
      final docRef = _firestore
          .collection('departments')
          .doc('CSE')
          .collection('batches')
          .doc(batchId)
          .collection('batchesMessages')
          .doc(id);

      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        // If document exists, delete it
        await docRef.delete();
        print('Document deleted: $id');
      } else {
        print('Document does not exist: $id');
      }
    } catch (e) {
      // Handle any errors here
      throw e;
    }
  }


}
