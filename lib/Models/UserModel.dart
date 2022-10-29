// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? Email;
  String? Roles;
  String? uid;

// receiving data
  UserModel({this.uid, this.Email, this.Roles});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['Uid'],
      Email: map['Email'],
      Roles: map['Roles'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'Email': Email,
      'Roles': Roles,
    };
  }
}
