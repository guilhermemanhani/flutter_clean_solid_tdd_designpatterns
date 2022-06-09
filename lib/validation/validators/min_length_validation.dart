import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;
  MinLengthValidation({
    required this.field,
    required this.size,
  });

  @override
  ValidationError? validate(String? value) {
    if (value != null) {
      final isValid = value.length >= size;
      return isValid ? null : ValidationError.invalidField;
    } else {
      return ValidationError.invalidField;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MinLengthValidation &&
        other.field == field &&
        other.size == size;
  }

  @override
  int get hashCode => field.hashCode ^ size.hashCode;
}
