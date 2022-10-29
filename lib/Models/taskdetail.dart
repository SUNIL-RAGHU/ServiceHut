class Taskdetail {
  String? TaskSelectedCategory;
  String? TaskselectedSubCategory;
  bool? isAccepted;
  String? pricerange;
  String? timeline;
  // ignore: non_constant_identifier_names
  String? Details;
  String? Uid;
  String? Title;

// receiving data
  Taskdetail(
      {this.Uid,
      this.Details,
      this.TaskSelectedCategory,
      this.TaskselectedSubCategory,
      this.Title,
      this.isAccepted,
      this.pricerange,
      this.timeline});

  factory Taskdetail.fromMap(map) {
    return Taskdetail(
      Uid: map['Uid'],
      Details: map['Details'],
      TaskSelectedCategory: map['TaskSelectedCategory'],
      TaskselectedSubCategory: map['TaskselectedSubCategory'],
      Title: map['Title'],
      isAccepted: map['isAccepted'],
      pricerange: map['pricerange'],
      timeline: map['timeline'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'Uid': Uid,
      'Details': Details,
      'TaskSelectedCategory': TaskSelectedCategory,
      'TaskselectedSubCategory': TaskselectedSubCategory,
      'Title': Title,
      'isAccepted': isAccepted,
      'pricerange': pricerange,
      'timeline': timeline,
    };
  }
}
