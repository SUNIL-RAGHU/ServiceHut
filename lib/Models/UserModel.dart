// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? Email;
  String? Roles;
  String? Uid;

// receiving data
  UserModel({this.Uid, this.Email, this.Roles});
  factory UserModel.fromMap(map) {
    print(map);
    return UserModel(
      Uid: map['Uid'],
      Email: map['Email'],
      Roles: map['Roles'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'Uid': Uid,
      'Email': Email,
      'Roles': Roles,
    };
  }
}
