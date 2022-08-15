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
  ValidationError? validate(Map input) =>
      input[field] != null && input[field].length >= size
          ? null
          : ValidationError.invalidField;

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
