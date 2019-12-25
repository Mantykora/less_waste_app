
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String userId;
  DatabaseService ({this.userId});

  final CollectionReference collection = Firestore.instance.collection('userData');

  Future updateUserData(String login) async {
    return await collection.document(userId).setData({
      'login': login
    });
  }

  Stream<QuerySnapshot> get users  {
    return collection.snapshots();
  }
}