/// Class strong string of phone number
class PhoneNumberModel {
  /// Default constructor
  PhoneNumberModel({
    required this.phoneNumber,
  });

  /// Phone number of contact
  final String phoneNumber;

  static PhoneNumberModel fromJson(Map<String, dynamic> json) {
    return PhoneNumberModel(
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
    };
  }
}
