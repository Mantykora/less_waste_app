import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user_data.dart';

class DatabaseService {
  final String userId;

  DatabaseService({this.userId});

  final CollectionReference userDataCollection = Firestore.instance.collection('userData');
  final CollectionReference postsCollection = Firestore.instance.collection('posts');

  Future updateUserData(String login) async {
    return await userDataCollection.document(userId).setData({
      'login': login,
      // 'userId': userId
    });
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(id: doc.documentID, username: doc.data['login']);
    }).toList();
  }

  Stream<List<UserData>> get users {
    return userDataCollection.snapshots().map(_userListFromSnapshot);
  }

  Future updatePost(Post post) async {
    var docdoc = postsCollection.document();
    var docdocUid = docdoc.documentID;
    print(docdocUid);
    docdoc.setData({
//    int userId;
//    int id;
//    String body;
//    int category;
      'userId': post.userId,
      'id': docdocUid,
      'body': post.body,
      'category': post.category,
      'count': post.commentsCount
    });
  }

  Future updatePostById(String id, int count) async {
    return postsCollection.document(id).updateData({'count': count});
  }

  Stream<Post> getPostById(String id) {
    return postsCollection.document(id).snapshots().map((doc) {
      return Post(id: doc.documentID, userId: doc.data['userId'], body: doc.data['body'], category: doc.data['category'], commentsCount: doc.data['count']);
    });
  }

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(id: doc.documentID, userId: doc.data['userId'], body: doc.data['body'], category: doc.data['category'], commentsCount: doc.data['count']);
    }).toList();
  }

  Stream<List<Post>> get posts {
    return postsCollection.snapshots().map(_postListFromSnapshot);
  }

  Future updateComment(Comment comment, String postId) async {
    return await postsCollection.document(postId).collection('comments').document().setData({
      'body': comment.body,
      'time': Timestamp.now(),
    });
  }

  List<Comment> _commentsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Comment(body: doc.data['body']);
    }).toList();
  }

  Stream<List<Comment>> getComments(String postId) {
    return postsCollection.document(postId).collection('comments').orderBy("time", descending: true).snapshots().map(_commentsListFromSnapshot);
  }
}
