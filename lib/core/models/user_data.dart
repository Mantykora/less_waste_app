class UserData {
  String id;
  String name;
  String username;
  DateTime joinDate;
  int postsNumber;

  UserData({this.id, this.name, this.username, this.joinDate, this.postsNumber});

  UserData.initial()
      : id = "0",
        name = '',
        username = '';

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    joinDate = json['joinDate'];
    postsNumber = json['postsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['joinDate'] = this.joinDate;
    data['postsNumber'] = this.postsNumber;
    return data;
  }
}
