class Post {
  int userId;
  int id;
  String title;
  String body;
  int category;

  Post({this.userId, this.id, this.title, this.body, this.category});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['category'] = this.category;
    return data;
  }
}