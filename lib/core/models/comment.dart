class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;
  String time;

  Comment({this.postId, this.id, this.name, this.email, this.body, this.time});

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    data['time'] = this.time;
    return data;
  }
}
