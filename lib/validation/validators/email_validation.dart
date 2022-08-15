import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

// ! LEAF
class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  ValidationError? validate(Map input) {
    final regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
    final isValid =
        input[field].isNotEmpty != true || regex.hasMatch(input[field]);
    return isValid ? null : ValidationError.invalidField;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailValidation && other.field == field;
  }

  @override
  int get hashCode => field.hashCode;
}
