// class UserAssign {
//   String? About;
//   String? Email;
//   String? Uid;
//   String? Latitude;
//   String? Longitude;
//   List<String>? Id_proofs;
//   String? Name;
//   String? PhoneNumber;
//   String? Profile_pics;
//   String? Roles;
//   String? SelectedCategory;
//   List<String>? SubCategory;
//   List<String>? WorkdoneImages;

// // receiving data
//   UserAssign(
//       {this.Uid,
//       this.Email,
//       this.Roles,
//       this.About,
//       this.Id_proofs,
//       this.Latitude,
//       this.Longitude,
//       this.Name,
//       this.PhoneNumber,
//       this.Profile_pics,
//       this.SelectedCategory,
//       this.SubCategory,
//       this.WorkdoneImages});
//   factory UserAssign.fromMap(map) {
//     print(map);
//     return UserAssign(
//         Uid: map['Uid'],
//         Email: map['Email'],
//         Roles: map['Roles'],
//         About: map['About'],
//         Id_proofs: map['Id_proofs'],
//         Latitude: map['Latitude'],
//         Longitude: map['Longitude'],
//         Name: map['Name'],
//         PhoneNumber: map['PhoneNumber'],
//         Profile_pics: map['Profile_pics'],
//         SelectedCategory: map['SelectedCategory'],
//         SubCategory: map['SubCategory'],
//         WorkdoneImages: map['WorkdoneImages']);
//   }
// // sending data
//   Map<String, dynamic> toMap() {
//     return {
//       'Uid': Uid,
//       'Email': Email,
//       'Roles': Roles,
//       'About': About,
//       'Id_proofs': Id_proofs,
//       'Latitude': Latitude,
//       'Longitude': Longitude,
//       'Name': Name,
//       'PhoneNumber': PhoneNumber,
//       'Profile_pics': Profile_pics,
//       'SelectedCategory': SelectedCategory,
//       'SubCategory': SubCategory,
//       'WorkdoneImages': WorkdoneImages,
//     };
//   }
// }
