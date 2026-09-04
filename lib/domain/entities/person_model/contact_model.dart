import 'package:super_vicky/domain/entities/person_model/phone_number_model.dart';

/// Strong class of contact
class ContactModel {
  /// Default constructor
  ContactModel({
    required this.phoneNumber,
  });

  /// Phone number of contact
  final PhoneNumberModel phoneNumber;

  static ContactModel fromJson(Map<String, dynamic> json) {
    return ContactModel(
      phoneNumber: PhoneNumberModel.fromJson(
        json['phoneNumber'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber.toJson(),
    };
  }
}
