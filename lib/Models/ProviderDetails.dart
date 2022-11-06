// ignore_for_file: non_constant_identifier_names

class Providerdetails {
  String? About;
  String? Email;
  String? Name;
  int? PhoneNumber;
  String? Profilepics;
  String? Category;
  List<dynamic>? SubCategory;
  List<dynamic>? WorkdoneImages;
  List<dynamic>? Id_proofs;
  String? Latitude;
  String? Longitude;
  bool? isAccepted;
  String? Uid;

// receiving data
  Providerdetails({
    this.About,
    this.Category,
    this.Email,
    this.Name,
    this.PhoneNumber,
    this.Profilepics,
    this.SubCategory,
    this.WorkdoneImages,
    this.Id_proofs,
    this.Latitude,
    this.Longitude,
    this.isAccepted,
    this.Uid,
  });
  factory Providerdetails.fromMap(map) {
    print(map);
    return Providerdetails(
      About: map['About'],
      Email: map['Email'],
      Name: map['Name'],
      PhoneNumber: map['PhoneNumber'],
      Profilepics: map['Profile_Pics'],
      Category: map['SelectedCategory'],
      SubCategory: map['SubCategory'],
      WorkdoneImages: map['WorkdoneImages'],
      Id_proofs: map['Id_proofs'],
      Latitude: map['Latitude'],
      Longitude: map['Longitude'],
      isAccepted: map['isAccepted'],
      Uid: map['Uid'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'About': About,
      'Email': Email,
      'Name': Name,
      'PhoneNumber': PhoneNumber,
      'Profile_Pics': Profilepics,
      'SelectedCategory': Category,
      'SubCategory': SubCategory,
      'WorkdoneImages': WorkdoneImages,
      'Id_proofs': Id_proofs,
      'Latitude': Latitude,
      'Longitude': Longitude,
      'isAccepted': isAccepted,
      'Uid': Uid,
    };
  }
}
