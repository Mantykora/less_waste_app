
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:less_waste_app/core/models/user_data.dart';

class DatabaseService {

  final String userId;
  DatabaseService ({this.userId});

  final CollectionReference collection = Firestore.instance.collection('userData');

  Future updateUserData(String login) async {
    return await collection.document(userId).setData({
      'login': login
    });
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(id: doc.documentID, username: doc.data['login']);
    }).toList();
  }

  Stream<List<UserData>> get users  {
    return collection.snapshots().map(_userListFromSnapshot);
  }
}