import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/like.dart';
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
      return UserData(id: doc.documentID,
                   username: doc.data['login'],
                   name: doc.data['name'],
                   lastName: doc.data['lastName'],
                   description: doc.data['description']
      );
    }).toList();
  }

  Stream<List<UserData>> get users {
    return userDataCollection.snapshots().map(_userListFromSnapshot);
  }

  Future updateUserById(String id, String name, String lastName, String description) async {
    return userDataCollection.document(id)
        .updateData({
      'name': name,
      'lastName': lastName,
      'description': description
    },);
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
      'count': post.commentsCount,
      'likesCount': post.likesCount
    });
  }

  Future updatePostById(String id, int count) async {
    return postsCollection.document(id).updateData({'count': count});
  }

  Future updateLikesCountPostById(String id, int likesCount) async {
    return postsCollection.document(id).updateData({'likesCount': likesCount});
  }

  Stream<Post> getPostById(String id) {
    return postsCollection.document(id).snapshots().map((doc) {
      return Post(id: doc.documentID,
          userId: doc.data['userId'],
          body: doc.data['body'],
          category: doc.data['category'],
          commentsCount: doc.data['count'],
          likesCount: doc.data['likesCount']
      );
    });
  }

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(id: doc.documentID,
          userId: doc.data['userId'],
          body: doc.data['body'],
          category: doc.data['category'],
          commentsCount: doc.data['count'],
          likesCount: doc.data['likesCount']
      );
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

  Future updateLikes(Like like, String postId) async {
    var doc = postsCollection.document(postId).collection('likes').document();
    var docId = doc.documentID;
    return await doc.setData({
    'userId': like.userId,
    'id': docId,
    'postId': like.postId,
    });
  }

  Future deleteLike(String likeId, String postId) async {
    return await postsCollection.document(postId).collection('likes').document(likeId).delete();
  }

  Stream<List<Like>> getUserLikeForPost(String postId, String userId)  {
    return postsCollection
        .document(postId).collection('likes')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map(_likeFromSnapshot);

  }

  List<Like> _likeFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
           return Like(userId: doc.data["userId"], postId: doc.data["postId"],  id: doc.data["id"]);
    }).toList();
  }





}
