// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: non_constant_identifier_names

class Providerdetails {
  final String? About;
  final String? Email;
  final String? Name;
  final int? PhoneNumber;
  final String? Profilepics;
  late final String? SelectedCategory;
  final List<dynamic>? SubCategory;
  final List<dynamic>? WorkdoneImages;
  final List<dynamic>? Id_proofs;
  final String? Latitude;
  final String? Longitude;
  final bool? isAccepted;
  final String? Uid;
  Providerdetails({
    this.About,
    this.Email,
    this.Name,
    this.PhoneNumber,
    this.Profilepics,
    this.SelectedCategory,
    this.SubCategory,
    this.WorkdoneImages,
    this.Id_proofs,
    this.Latitude,
    this.Longitude,
    this.isAccepted,
    this.Uid,
  });

  Providerdetails copyWith({
    String? About,
    String? Email,
    String? Name,
    int? PhoneNumber,
    String? Profilepics,
    String? SelectedCategory,
    List<dynamic>? SubCategory,
    List<dynamic>? WorkdoneImages,
    List<dynamic>? Id_proofs,
    String? Latitude,
    String? Longitude,
    bool? isAccepted,
    String? Uid,
  }) {
    return Providerdetails(
      About: About ?? this.About,
      Email: Email ?? this.Email,
      Name: Name ?? this.Name,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      Profilepics: Profilepics ?? this.Profilepics,
      SelectedCategory: SelectedCategory ?? this.SelectedCategory,
      SubCategory: SubCategory ?? this.SubCategory,
      WorkdoneImages: WorkdoneImages ?? this.WorkdoneImages,
      Id_proofs: Id_proofs ?? this.Id_proofs,
      Latitude: Latitude ?? this.Latitude,
      Longitude: Longitude ?? this.Longitude,
      isAccepted: isAccepted ?? this.isAccepted,
      Uid: Uid ?? this.Uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'About': About,
      'Email': Email,
      'Name': Name,
      'PhoneNumber': PhoneNumber,
      'Profilepics': Profilepics,
      'SelectedCategory': SelectedCategory,
      'SubCategory': SubCategory,
      'WorkdoneImages': WorkdoneImages,
      'Id_proofs': Id_proofs,
      'Latitude': Latitude,
      'Longitude': Longitude,
      'isAccepted': isAccepted,
      'Uid': Uid,
    };
  }

  factory Providerdetails.fromMap(data) {
    Map<String, dynamic> map = data.data();
    return Providerdetails(
      About: map['About'] != null ? map['About'] as String : null,
      Email: map['Email'] != null ? map['Email'] as String : null,
      Name: map['Name'] != null ? map['Name'] as String : null,
      PhoneNumber:
          map['PhoneNumber'] != null ? map['PhoneNumber'] as int : null,
      Profilepics:
          map['Profilepics'] != null ? map['Profilepics'] as String : null,
      SelectedCategory: map['SelectedCategory'] != null
          ? map['SelectedCategory'] as String
          : null,
      SubCategory: map['SubCategory'] != null
          ? List<dynamic>.from((map['SubCategory'] as List<dynamic>))
          : null,
      WorkdoneImages: map['WorkdoneImages'] != null
          ? List<dynamic>.from((map['WorkdoneImages'] as List<dynamic>))
          : null,
      Id_proofs: map['Id_proofs'] != null
          ? List<dynamic>.from((map['Id_proofs'] as List<dynamic>))
          : null,
      Latitude: map['Latitude'] != null ? map['Latitude'] as String : null,
      Longitude: map['Longitude'] != null ? map['Longitude'] as String : null,
      isAccepted: map['isAccepted'] != null ? map['isAccepted'] as bool : null,
      Uid: map['Uid'] != null ? map['Uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Providerdetails.fromJson(String source) =>
      Providerdetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Providerdetails(About: $About, Email: $Email, Name: $Name, PhoneNumber: $PhoneNumber, Profilepics: $Profilepics, Category: $Category, SubCategory: $SubCategory, WorkdoneImages: $WorkdoneImages, Id_proofs: $Id_proofs, Latitude: $Latitude, Longitude: $Longitude, isAccepted: $isAccepted, Uid: $Uid)';
  }

  @override
  bool operator ==(covariant Providerdetails other) {
    if (identical(this, other)) return true;

    return other.About == About &&
        other.Email == Email &&
        other.Name == Name &&
        other.PhoneNumber == PhoneNumber &&
        other.Profilepics == Profilepics &&
        other.SelectedCategory == SelectedCategory &&
        listEquals(other.SubCategory, SubCategory) &&
        listEquals(other.WorkdoneImages, WorkdoneImages) &&
        listEquals(other.Id_proofs, Id_proofs) &&
        other.Latitude == Latitude &&
        other.Longitude == Longitude &&
        other.isAccepted == isAccepted &&
        other.Uid == Uid;
  }

  @override
  int get hashCode {
    return About.hashCode ^
        Email.hashCode ^
        Name.hashCode ^
        PhoneNumber.hashCode ^
        Profilepics.hashCode ^
        SelectedCategory.hashCode ^
        SubCategory.hashCode ^
        WorkdoneImages.hashCode ^
        Id_proofs.hashCode ^
        Latitude.hashCode ^
        Longitude.hashCode ^
        isAccepted.hashCode ^
        Uid.hashCode;
  }
}


// receiving data
//   Providerdetails({
//     this.About,
//     this.Category,
//     this.Email,
//     this.Name,
//     this.PhoneNumber,
//     this.Profilepics,
//     this.SubCategory,
//     this.WorkdoneImages,
//     this.Id_proofs,
//     this.Latitude,
//     this.Longitude,
//     this.isAccepted,
//     this.Uid,
//   });
//   factory Providerdetails.fromMap(map) {
//     print(map);
//     return Providerdetails(
//       About: map['About'],
//       Email: map['Email'],
//       Name: map['Name'],
//       PhoneNumber: map['PhoneNumber'],
//       Profilepics: map['Profile_Pics'],
//       Category: map['SelectedCategory'],
//       SubCategory: map['SubCategory'],
//       WorkdoneImages: map['WorkdoneImages'],
//       Id_proofs: map['Id_proofs'],
//       Latitude: map['Latitude'],
//       Longitude: map['Longitude'],
//       isAccepted: map['isAccepted'],
//       Uid: map['Uid'],
//     );
//   }
// // sending data
//   Map<String, dynamic> toMap() {
//     return {
//       'About': About,
//       'Email': Email,
//       'Name': Name,
//       'PhoneNumber': PhoneNumber,
//       'Profile_Pics': Profilepics,
//       'SelectedCategory': Category,
//       'SubCategory': SubCategory,
//       'WorkdoneImages': WorkdoneImages,
//       'Id_proofs': Id_proofs,
//       'Latitude': Latitude,
//       'Longitude': Longitude,
//       'isAccepted': isAccepted,
//       'Uid': Uid,
//     };
//   }