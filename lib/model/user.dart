class User {
  int? id;
  String? email;
  String? password;

  User(
      {this.id,
        this.email,
        this.password,});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['email'] = email;
    map['password'] = password;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    password = map['password'];
  }
}
