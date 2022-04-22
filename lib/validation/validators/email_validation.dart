import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

// ! LEAF
class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  ValidationError? validate(String? value) {
    if (value != null) {
      final regex =
          RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
      final isValid = value.isNotEmpty != true || regex.hasMatch(value);
      return isValid ? null : ValidationError.invalidField;
    } else {
      return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailValidation && other.field == field;
  }

  @override
  int get hashCode => field.hashCode;
}
