class Like {
  String userId;
  String id;
  String postId;
  bool isLiked;

  Like({this.userId, this.id, this.postId, this.isLiked });

  Like.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['postId'] = this.postId;
    return data;
  }
}
