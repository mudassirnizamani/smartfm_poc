class User {
  int? phoneNumber;
  String? name;
  String? profilePic;
  bool? creator;
  String? userId;

  User(
      {this.phoneNumber,
      this.name,
      this.profilePic,
      this.creator,
      this.userId});

  User.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    profilePic = json['profilePic'];
    creator = json['creator'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['name'] = name;
    data['profilePic'] = profilePic;
    data['creator'] = creator;
    data['userId'] = userId;
    return data;
  }
}
