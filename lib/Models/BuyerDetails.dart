class BuyerDetails {
  String? Email;
  String? First_Name;
  String? Last_Name;
  int? PhoneNumber;

// receiving data
  BuyerDetails({this.Email, this.First_Name, this.Last_Name, this.PhoneNumber});
  factory BuyerDetails.fromMap(map) {
    print(map);
    return BuyerDetails(
      Email: map['Email'],
      First_Name: map['First Name'],
      Last_Name: map['Last Name'],
      PhoneNumber: map['PhoneNumber'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'Email': Email,
      'First Name': First_Name,
      'Last Name': Last_Name,
      'PhoneNumber': PhoneNumber
    };
  }
}
