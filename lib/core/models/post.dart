class Post {
  String userId;
  String id;
  String body;
  int category;
  int commentsCount;
  int likesCount;
  int timeStamp;
  bool isEdited;

  Post({this.userId, this.id, this.body, this.category, this.commentsCount, this.likesCount, this.timeStamp, this.isEdited});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    body = json['body'];
    category = json['category'];
    commentsCount = json['commentsCount'];
    likesCount = json['likesCount'];
    timeStamp = json['timeStamp'];
    isEdited = json['isEdited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['body'] = this.body;
    data['category'] = this.category;
    data['commentsCount'] = this.commentsCount;
    data['likesCount'] = this.likesCount;
    data['timeStamp'] = this.timeStamp;
    data['isEdited'] = this.isEdited;
    return data;
  }
}
