import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/repositories/FirestoreDataSource.dart';

class FirestoreSendDataSourceImpl implements FirestoreSendDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> updateMessageToFirebase(
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

      print('cateogires $selectedCategories');

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

      // Get the document ID
      String docId = docRef.id;

      // Reference to the folder in Firebase Storage
      String folderPath = 'uploads/$docId';
      print(folderPath);
      final folderRef = _storage.ref(folderPath);

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

      return "Success";
    } catch (e) {
      print('Failed to update message in Firebase: $e');
      throw e;
    }
  }

  @override
  Future<String> sendMessageToFirebase(
      String announcementMessage,
      String titleMessage,
      List<Map<String, dynamic>> checkboxes,
      List<File> pickedFiles,
      DateTime editedDate,
      String batchId,
      String? sender) async {
    String docId = 'no id';
    try {
      DocumentReference seniorTutorDocRef = _firestore
          .collection('departments')
          .doc('CSE')
          .collection('batches')
          .doc(batchId);

      // Filter the selected categories based on checkboxes
      List selectedCategories = checkboxes
          .where((checkbox) => checkbox['isChecked'] == true)
          .map((checkbox) {
        return checkbox['name'];
      }).toList();

      DocumentReference docRef = _firestore
          .collection('departments')
          .doc('CSE')
          .collection('batches')
          .doc(batchId)
          .collection('batchesMessages')
          .doc(); // No document ID specified, Firestore will generate one

      // Create a directory reference in Firebase Storage
      Reference storageRef = _storage.ref().child('uploads/${docRef.id}');

      List<Map<String, String>> filesInfo = [];

      // Upload files to Firebase Storage and get download URLs
      for (File file in pickedFiles) {
        String fileName = file.path.split('/').last;
        Reference fileRef = storageRef.child(fileName);
        await fileRef.putFile(file);
        String downloadUrl = await fileRef.getDownloadURL();
        filesInfo.add({'fileName': fileName, 'downloadUrl': downloadUrl});
      }

      // Set the document data including the document ID
      await docRef.set({
        'title': titleMessage,
        'content': announcementMessage,
        'sender': sender,
        'timestamp': FieldValue.serverTimestamp(),
        'toWhom': selectedCategories,
        'editedDate': editedDate,
        'fileInfo': filesInfo,
      }).then((value) {
        // Get the document ID after the document is created
        docId = docRef.id;

        // Update the document with the ID
        return docRef.update({'id': docId}); // Return the update Future
      }).then((value) {
        // Additional actions after update, if needed
        print('Document created and updated successfully!');
      });
    } catch (e) {
      print('Failed to send message to Firebase: $e');
      throw e;
    }
    return docId;
  }
}
