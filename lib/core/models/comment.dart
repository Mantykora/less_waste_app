class Comment {
  int postId;
  int id;
  String userName;
  String userId;
  String email;
  String body;
  int time;
  String profilePhotoUrl;

  Comment({
    this.postId,
    this.id,
    this.userName,
    this.userId,
    this.email,
    this.body,
    this.time,
    this.profilePhotoUrl
  });

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    userName = json['userName'];
    userId = json['userId'];
    email = json['email'];
    body = json['body'];
    time = json['time'];
    profilePhotoUrl = json['profilePhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['body'] = this.body;
    data['time'] = this.time;
    data['profilePhotoUrl'] = this.profilePhotoUrl;
    return data;
  }
}
