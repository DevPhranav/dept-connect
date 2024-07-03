import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMovePage extends StatefulWidget {
  @override
  _FirestoreMovePageState createState() => _FirestoreMovePageState();
}

class _FirestoreMovePageState extends State<FirestoreMovePage> {
  final CollectionReference sourceCollection =
  FirebaseFirestore.instance.collection('faculty');
  final CollectionReference destinationCollection =
  FirebaseFirestore.instance.collection('departments/CSE/faculty_senior_tutor_privilege/');

  Future<void> moveDocuments() async {
    QuerySnapshot<Object?> snapshot = await sourceCollection.get();
    for (QueryDocumentSnapshot<Object?> doc in snapshot.docs) {
      Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
      await destinationCollection.doc(doc.id).set({
        'id': doc.id,
        'name': data['name'],
        'alreadyBatchSeniorTutor': false,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Move Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: moveDocuments,
          child: Text('Move Documents'),
        ),
      ),
    );
  }
}
