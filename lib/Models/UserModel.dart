// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class UserModel {
  final String? Email;
  final String? Roles;
  final String? Uid;
  final String? SelectedCategory;
  UserModel({
    this.Email,
    this.Roles,
    this.Uid,
    this.SelectedCategory,
  });

  UserModel copyWith({
    String? Email,
    String? Roles,
    String? Uid,
    String? SelectedCategory,
  }) {
    return UserModel(
      Email: Email ?? this.Email,
      Roles: Roles ?? this.Roles,
      Uid: Uid ?? this.Uid,
      SelectedCategory: SelectedCategory ?? this.SelectedCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Email': Email,
      'Roles': Roles,
      'Uid': Uid,
      'SelectedCategory': SelectedCategory,
    };
  }

  factory UserModel.fromMap(data) {
    Map<String, dynamic> map = data.data();
    return UserModel(
      Email: map['Email'] != null ? map['Email'] as String : null,
      Roles: map['Roles'] != null ? map['Roles'] as String : null,
      Uid: map['Uid'] != null ? map['Uid'] as String : null,
      SelectedCategory: map['SelectedCategory'] != null
          ? map['SelectedCategory'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(Email: $Email, Roles: $Roles, Uid: $Uid, SelectedCategory: $SelectedCategory)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.Email == Email &&
        other.Roles == Roles &&
        other.Uid == Uid &&
        other.SelectedCategory == SelectedCategory;
  }

  @override
  int get hashCode {
    return Email.hashCode ^
        Roles.hashCode ^
        Uid.hashCode ^
        SelectedCategory.hashCode;
  }
}


// // receiving data
//   UserModel({this.Uid, this.Email, this.Roles, this.SelectedCategory});
//   // UserModel({
//   //   this.Uid,
//   //   this.Email,
//   //   this.Roles,
//   // });
//   factory UserModel.fromMap(map) {
//     print("!!!!");
//     print(map);
//     return UserModel(
//       Uid: map['Uid'],
//       Email: map['Email'],
//       Roles: map['Roles'],
//       SelectedCategory:map['SelectedCategory'] == null ? null : map['SelectedCatergory'],
//     );
//   }
// // sending data
//   Map<String, dynamic> toMap() {
//     return {
//       'Uid': Uid,
//       'Email': Email,
//       'Roles': Roles,
//       'SelectedCategory': SelectedCategory,
//     };
//   }
