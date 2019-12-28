
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user_data.dart';

class DatabaseService {

  final String userId;
  DatabaseService ({this.userId});

  final CollectionReference userDataCollection = Firestore.instance.collection('userData');
  final CollectionReference postsCollection = Firestore.instance.collection('posts');

  Future updateUserData(String login) async {
    return await userDataCollection.document(userId).setData({
      'login': login
    });
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(id: doc.documentID, username: doc.data['login']);
    }).toList();
  }

  Stream<List<UserData>> get users  {
    return userDataCollection.snapshots().map(_userListFromSnapshot);
  }
  
  Future updatePost(Post post) async {
    return await postsCollection.document().setData({
//    int userId;
//    int id;
//    String body;
//    int category;
      'userId': post.userId,
      'id': post.id,
      'body': post.body,
      'category': post.category
    });
  }
  
}