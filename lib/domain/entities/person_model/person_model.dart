import 'package:super_vicky/domain/entities/person_model/contact_model.dart';
import 'package:super_vicky/domain/entities/person_model/person_name_model.dart';

import '../product_model.dart';

/// Person created [ProductModel]
class PersonModel {
  /// Default constructor
  PersonModel({
    required this.personName,
    required this.contact,
  });

  /// Name of person
  final PersonNameModel personName;

  /// Contact of person
  final ContactModel contact;
}
