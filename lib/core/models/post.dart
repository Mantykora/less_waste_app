class Post {
  String userId;
  int id;
  String body;
  int category;

  Post({this.userId, this.id, this.body, this.category});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    body = json['body'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['body'] = this.body;
    data['category'] = this.category;
    return data;
  }
}
