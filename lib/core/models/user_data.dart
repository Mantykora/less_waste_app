class UserData {
  String id;
  String name;
  String username;
  String lastName;
  String description;
  DateTime joinDate;
  int postsNumber;
  String profilePhotoUrl;

  UserData({this.id, this.name, this.username, this.lastName, this.description, this.joinDate, this.postsNumber, this.profilePhotoUrl});

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
    lastName = json['lastName'];
    description = json['description'];
    profilePhotoUrl = json['profilePhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['joinDate'] = this.joinDate;
    data['postsNumber'] = this.postsNumber;
    data['lastName'] = this.lastName;
    data['description'] = this.description;
    data['profilePhotoUrl'] = this.profilePhotoUrl;
    return data;
  }
}
