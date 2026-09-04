/// Strong class of person name
class PersonNameModel {
  /// Default constructor
  PersonNameModel({
    required this.personName,
  });

  /// Just name of person
  final String personName;

  static PersonNameModel fromJson(Map<String, dynamic> json) {
    return PersonNameModel(
      personName: json['personName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personName': personName,
    };
  }
}
